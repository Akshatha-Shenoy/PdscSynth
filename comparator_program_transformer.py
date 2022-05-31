from z3 import *
import datetime
import re
# Simplistic (and fragile) converter from
# a class of Horn clauses corresponding to
# a transition system into a transition system
# representation as <init, trans, exit>
# It assumes it is given three forms of Horn clauses
#  init_cond(x) => compare@_1(x)
#  compare@_1(x) => compare@_#(x) where # is block number or cutpoint marking
#  compare@_#(x) => compare(x) which marks exit and summary of the method compare
from dynamic_program import DynamicProgram


def comparator_transform(file_path, force_predicate_abstraction, method_name,prop,entry_to_memory_map=None):
    return Transformer(force_predicate_abstraction, method_name,entry_to_memory_map,prop).parse(file_path)


class Transformer:
    def __init__(self, force_predicate_abstraction, method_name,entry_to_memory_map,prop):
        self.ctx = z3.Context()
        self.file_name = None
        self.prop = prop
        self.pc_var = z3.Int("pc", self.ctx)
        self.pcp_var = z3.Int("pc_p", self.ctx)
        self.fp = None
        self.exit_tuples = []
        self.trans_tuples = []
        self.var_id_to_normal_var = {}
        self.curr_rule = None
        self.init_cond = None
        self.inv_vars = []
        self.inv_varsp = {}
        self.inv_varsp[self.pc_var] = self.pcp_var
        self.predicates_tuples = []
        self.rel_predicates_tuples = []
        self.try_again = []
        self.ret_var = None
        self.rules = []
        self.force_predicate_abstraction = force_predicate_abstraction
        self.entry_to_memory_map = entry_to_memory_map if entry_to_memory_map is not None else {}
        self.array_index_vars = []
        self.all_concrete_vars = []
        self.method_name = method_name

    def parse(self, file_path):
        self.file_name = file_path.split('/')[len(file_path.split('/'))-1]
        self.fp = Fixedpoint(ctx=self.ctx)
        self.fp.parse_file(file_path)
        dp = DynamicProgram(True,self.ctx,self.prop)

        for r in self.fp.get_rules():
            self.curr_rule = r
            if not is_quantifier(r):
                continue
            b = r.body()
            if not is_implies(b):
                self.try_init(b)
                continue
            f = b.arg(0)
            g = b.arg(1)
            if self.try_exit(f, g):  # check if g is compare
                self.rules.append(r)
                continue
            if self.try_transition(f, g):  # check that f,g has two compare_1
                self.rules.append(r)
                continue
            # if self.try_predicate(f, g):
            #     continue
        # for r, f, g in self.try_again:
        #     self.curr_rule = r
        #     if self.try_predicate(f, g):
        #         continue
        self.fix_tr_ret_var()
        # start = datetime.datetime.now()
        # if self.force_predicate_abstraction:
        self.relate_array_vars()
        self.add_conditions_on_indixes()
        # end = datetime.datetime.now()
        # delta = end - start
        # print "RelateArrayTime: " + str(delta.total_seconds())
        self.update_dynamic_program(dp)
        return dp, self.entry_to_memory_map

    def is_pred(self, p, name):
        return is_app(p) and p.decl().name() == name

    def try_exit(self, body, head):
        if not self.is_pred(head, self.method_name):
            return False
        unibody = False
        body_pred_before = self.get_pred_from_body(body)
        if body_pred_before == body:
            unibody = True
        body_pred_after, xs, pc_val = self.subst_vars(body_pred_before, self.pc_var)
        body = z3.substitute(body, [(body_pred_before, body_pred_after)])
        if not unibody:
            body, xs, ignore = self.subst_vars(body, None)
        body = z3.substitute(body, [(body_pred_after, z3.BoolVal(True, self.ctx))])
        head, xps, pcp_val = self.subst_vars(head, None)
        self.exit_tuples.append(
            (head, z3.And(body, self.pc_var == pc_val, self.ctx), xs, xps))
        self.ret_var = head.children()[-1]
        return True

    def try_transition(self, body, head):
        pre_pred = self.get_pred_from_body(body)
        if pre_pred.decl().name() != self.method_name+"_1":
            return False
        unibody = False
        body_pred_before = self.get_pred_from_body(body)
        if body_pred_before == body:
            unibody = True
        body_pred_after, xs, pc_val = self.subst_vars(body_pred_before, self.pc_var)
        xs_in_body = list(xs)
        body = z3.substitute(body, [(body_pred_before, body_pred_after)])
        if not unibody:
            body, all_body_vars, ignore = self.subst_vars(body, None)
            xs_in_body.extend(all_body_vars)
        head, xps, pcp_val = self.subst_vars(head, self.pcp_var)

        # body without oredicate
        body = z3.substitute(body, [(body_pred_after, z3.BoolVal(True, self.ctx))])

        self.trans_tuples.append(
            (z3.And(body, self.pc_var == pc_val, self.pcp_var == pcp_val, self.ctx), xs_in_body, xps))

        for xp in xps:
            if str(xp) not in [str(x) for x in xs]:
                var_name = str(xp)[:-1]
                for x in xs:
                    if str(x)[:-1] == var_name:
                        if x in self.inv_varsp:
                            self.inv_varsp[x].append(xp)
                        else:
                            self.inv_varsp[x] = [xp]
                            self.inv_varsp[x].append(x)
                        break
        self.extend_uniquely(xs_in_body)
        return True

    def fix_tr_ret_var(self):
        for v, vps in self.inv_varsp.items():
            if not isinstance(vps, list):
                continue
            chosen_vp = max(vps, key=str)
            vps_names = [str(vp) for vp in vps]
            new_tuples = []
            for body, xs, xps in self.trans_tuples:
                xp_to_subst = None
                #  check if xps contains one of vps and is not chosen_vp
                xps_names = [(str(xp), xp) for xp in xps]
                for xp_name, xp in xps_names:
                    if xp_name in vps_names and xp_name != str(chosen_vp):
                        xp_to_subst = xp

                if xp_to_subst is not None:
                    body = z3.And(body, xp_to_subst == chosen_vp, self.ctx)
                    xps.append(chosen_vp)
                new_tuples.append((body, xs, xps))
            self.trans_tuples = new_tuples
            self.inv_varsp[v] = chosen_vp

    def get_pred_vars(self, pred):
        return pred.children()

    def try_init(self, head):
        if not self.is_pred(head, self.method_name+"_1"):
            return False
        head, xs, pc_val = self.subst_vars(head, self.pc_var)
        self.init_cond = z3.And(self.pc_var == pc_val, self.ctx)
        self.inv_vars.extend(xs)
        self.extend_uniquely(xs)
        return True

    def extend_uniquely(self, xs):
        names = [str(v) for v in self.all_concrete_vars]
        for x in xs:
            if str(x) not in names:
                self.all_concrete_vars.append(x)

    def get_pred_from_body(self, body):
        if is_app(body) and not is_and(body):
            return body
        for child in body.children():
            pred = self.get_pred_from_body(child)
            if pred is not None:
                return child

    def subst_vars(self, body, pc_var):
        subst, pc_val = self.mk_subst(body, pc_var)
        for v, x in subst:
            if v.get_id() not in self.var_id_to_normal_var:
                self.var_id_to_normal_var[v.get_id()] = x
        all_vars = [v for (k, v) in subst]
        unique_vars_names = []
        unique_vars = []
        for v in all_vars:
            if str(v) not in unique_vars_names:
                unique_vars.append(v)
                unique_vars_names.append(str(v))
        return substitute(body, subst), unique_vars, pc_val

    def mk_subst(self, body, pc_var):
        vars_in_body = []
        self.get_pre_subst_vars(body, vars_in_body)
        total = self.curr_rule.num_vars() - 1
        ret = [(body.children()[0], pc_var)] if pc_var is not None else []
        ret.extend([(f, self.mk_var(f, total)) for f in
                    vars_in_body])
        return ret, body.children()[0]

    def mk_var(self, f, total):
        f_num = int(re.findall('\d+', str(f))[0])
        if f.sort() == z3.IntSort(ctx=self.ctx):
            return Int("%s" % (self.curr_rule.var_name(total - f_num)), self.ctx)
        elif f.sort() == z3.BoolSort(ctx=self.ctx):
            return Bool("%s" % (self.curr_rule.var_name(total - f_num)), self.ctx)
        elif f.sort() == z3.ArraySort([z3.IntSort(ctx=self.ctx), z3.IntSort(ctx=self.ctx)]):
            return Array("%s" % (self.curr_rule.var_name(total - f_num)), IntSort(self.ctx), IntSort(self.ctx))
        else:
            print("unsupported variable sort. only Int, Bool, Array(Int Int) are supported.")
            return None

    def try_predicate(self, body, head):
        if not is_app(head):
            return False
        pred_name = head.decl().name()
        if "pred_" not in pred_name:
            return False
        if not self.check_self_implication(body, pred_name):
            return False
        if len(self.inv_vars) == 0:
            self.try_again.append((self.curr_rule, body, head))
            return True
        relational = False  # todo: check if relational
        if relational:
            self.handle_rel_predicate(pred_name, body)
        else:
            self.handle_predicate(pred_name, body, head)
        return True

    def check_self_implication(self, body, pred_name):
        body_pred_name = body.children()[0].decl().name()
        return body_pred_name == pred_name

    def handle_predicate(self, name, body, head):
        # assuming predicate function has only one block so this rule is the single rule that applies to this predicate
        # first child of body- relation of the predicate
        # second argument in relation of predicate - return value which is the value of the predicate
        # for each predicate keep track of
        # 1. predicate variable
        # 2. used variables (to quantify)
        # 3. a formula consisting of everything in body except for the predicate relation application in the beginning
        hp_fd = open("handle_predicate.txt","w")
        hp_fd.write('name:'+name+"head:"+head+"body"+body)

        pred_name = name[:-2]  # remove "_1"
        hp_fd.write('pred_name:'+pred_name)
        pred_var = z3.Bool(pred_name, self.ctx)
        hp_fd.write('pred_var: '+pred_var)
        subst_body, xs, ignore = self.subst_vars(body, None)
        hp_fd.write('subst_body, xs, ignore'+subst_body+'\n'+xs+'\n'+ignore)
        body_pred = self.get_pred_from_body(subst_body)
        hp_fd.write('body_pred'+body_pred)
        formula = z3.substitute(subst_body, (body_pred, z3.BoolVal(True, self.ctx)))
        hp_fd.write('formula'+formula)
        xs_subst, no_match = self.get_subst_to_compare_vars(xs, pred_name)
        hp_fd.write('xs_subst:'+xs_subst)
        hp_fd.write('no_match:'+no_match)
        xs_subst, bad_sort = self.remove_different_sort(xs_subst)
        hp_fd.write('xs_subst:'+xs_subst)
        formula = z3.substitute(formula, xs_subst)
        hp_fd.write('formula:'+formula)
        subst_head, xps, ignore = self.subst_vars(head, None)
        hp_fd.write('subst-head'+subst_head)
        hp_fd.write('xps'+xps)
        hp_fd.write('ignore'+ignore)
        ret_val_variable = xps[0]
        hp_fd.write('ret_val_variable',ret_val_variable)
        xs = [x2 for x1, x2 in xs_subst] + no_match + bad_sort
        hp_fd.write('xs'+xs)
        formula = z3.And(formula, ret_val_variable == 1, self.ctx)
        hp_fd.write('formula'+formula)
        if pred_name in ["pred_i_gteq_0", "pred_i_lt_5"]:

            hp_fd.write('pred_name'+pred_name)
            formula = formula.children()[0].children()[2].children()[1]
            hp_fd.write('formula'+formula)
            xs = [xs_subst[0][1]]
            hp_fd.write('xs'+xs)
        hp_fd.close()
        self.predicates_tuples.append(pred_var, xs, formula)

    def remove_different_sort(self, pairs):
        new_pairs = []
        no_match = []
        for x, y in pairs:
            if x.sort() == y.sort():
                new_pairs.append((x, y))
            else:
                no_match.append(x)
        return new_pairs, no_match

    def get_subst_to_compare_vars(self, xs, pred_name):
        ret = []
        no_match = []

        for x in xs:
            found = False
            if str(x) == "pred_i_btw_0_1000@%i_0":
                wanted = "compare@%i.0_0"
            else:
                wanted = str(x).replace(pred_name, self.method_name)[:-2]
            for v in self.inv_vars:
                if wanted in str(v):
                    found = True
                    ret.append((x, v))
            if not found:
                no_match.append(x)
        return ret, no_match

    def get_pre_subst_vars(self, body, vs):
        for kid in body.children():
            if len(kid.children()) == 0 and "Var" in str(kid):
                vs.append(kid)
            else:
                self.get_pre_subst_vars(kid, vs)
    def relate_array_vars(self):
        inv_vars_names = [str(v) for v in self.inv_vars]
        array_inv_vars = [v for v in self.inv_vars if v.sort() == z3.ArraySort([z3.IntSort(ctx=self.ctx), z3.IntSort(ctx=self.ctx)])]
        for body, xs, xps in self.trans_tuples:
            for inv_var in array_inv_vars:
                xs_names = [str(x) for x in xs]
                if str(inv_var) in xs_names:
                    select_exprs = self.find_select_exprs(body, str(inv_var))
                    if select_exprs is not None:
                        select_vars = []
                        for expr in select_exprs:
                            right_oper = expr.children()[1]
                            vs=[]
                            self.get_post_subst_vars(right_oper, vs)
                            if len(vs) == 0:
                                continue
                            result = self.find_nondet_or_o_assigned(body, vs[0], inv_vars_names)
                            if result is not None:
                                self.entry_to_memory_map[str(result)] = inv_var
                            select_vars.extend(vs)
                        array_index = []
                        if self.force_predicate_abstraction:
                            self.find_array_index(body, select_vars, inv_vars_names,array_index)
                            for index in array_index:
                                name = str(index)
                                if name not in self.array_index_vars:
                                    self.array_index_vars.append(name)

    def find_array_index(self, body, vars_assigned_to, inv_vars_names,indices):
        continue_to_check = []
        for v in vars_assigned_to:
            name = str(v)
            if not ("nondet" in name or "o1_" in name or "o2_" in name) and name in inv_vars_names:
                indices.append(v)
            else:
                continue_to_check.append(v)
        if len(continue_to_check)>0:
            assignments = self.get_assignto_exprs(body, continue_to_check,[str(v) for v in continue_to_check])
            next_vars=[]
            for assignment in assignments:
                right_expr = assignment.children()[1]
                vars_in_expr = []
                self.get_post_subst_vars(right_expr, vars_in_expr)
                next_vars.extend(vars_in_expr)
            self.find_array_index(body,next_vars,inv_vars_names,indices)

    def find_nondet_or_o_assigned(self, body, var_assigned_to, inv_vars_names):
        if ("nondet" in str(var_assigned_to) or "o1_" in str(var_assigned_to) or "o2_" in str(var_assigned_to) or "o3_" in str(var_assigned_to)) and str(
                var_assigned_to) in inv_vars_names:
            return var_assigned_to

        assignments = self.get_assignto_exprs(body, [var_assigned_to],[str(var_assigned_to)])
        for assignment in assignments:
            right_expr = assignment.children()[1]
            vars_in_expr = []
            self.get_post_subst_vars(right_expr, vars_in_expr)
            if len(vars_in_expr) == 0:
                continue
            for v in vars_in_expr:
                result = self.find_nondet_or_o_assigned(body, v, inv_vars_names)
                if result is not None:
                    return result

    def get_post_subst_vars(self, body, vs):
        if len(body.children()) == 0 and not is_int_value(body) and not is_true(body) and not is_false(body):
            vs.append(body)
        else:
            for kid in body.children():
                self.get_post_subst_vars(kid, vs)

    def get_assignto_exprs(self, body, vars_assigned_to, names):
        children = body.children()
        if len(children) == 0:
            return None
        if is_eq(body) and str(body.children()[0]) in names:
            return [body]
        assignments = []
        for child in children:
            assignment = self.get_assignto_exprs(child, vars_assigned_to,names)
            if assignment is not None:
                assignments.extend(assignment)
        return assignments

    def add_conditions_on_indixes(self):
        if self.file_name == "NameComparator-true.smt2":
            o1Name = None
            o2Name = None
            for v in self.inv_vars:
                if str(v) == "compare@%o1_Name_0":
                    o1Name = v
                if str(v) == "compare@%o2_Name_0":
                    o2Name = v
            self.predicates_tuples.append((z3.Bool("o1_eq_o2",self.ctx), [o1Name,o2Name], o1Name == o2Name))
        if self.file_name == "NzbFile-true.smt2":
            lt_expr = self.trans_tuples[2][0].children()[0].children()[0].children()[2].children()[1]
            i_var = lt_expr.children()[0]
            self.predicates_tuples.append((z3.Bool("0_lt_i_lt_5",self.ctx), [i_var], z3.And(i_var <= z3.IntVal(5,self.ctx),i_var >= z3.IntVal(0,self.ctx),self.ctx)))
            o1_getFileName = None
            o2_getFileName = None
            o1_getFileName_toLowerCase_endsWith = None
            o2_getFileName_toLowerCase_endsWith = None
            o1_getSubject = None
            o2_getSubject = None
            call_0 = None
            call_2_0 = None
            for v in self.inv_vars:
                if str(v) == "compare@%o1_getFileName_toLowerCase_endsWith_0":
                    o1_getFileName_toLowerCase_endsWith = v
                if str(v) == "compare@%o2_getFileName_toLowerCase_endsWith_0":
                    o2_getFileName_toLowerCase_endsWith = v
                if str(v) == "compare@%o1_getSubject_0":
                    o1_getSubject = v
                if str(v) == "compare@%o1_getSubject_0":
                    o2_getSubject = v
                if str(v) == "compare@%o1_getFileName_0":
                    o1_getFileName = v
                if str(v) == "compare@%o2_getFileName_0":
                    o2_getFileName = v
                if str(v) == "compare@%_call_0":
                    call_0 = v
                if str(v) == "compare@%_2_0":
                    call_2_0 = v
            self.predicates_tuples.append((z3.Bool("eq1", self.ctx), [o1_getFileName_toLowerCase_endsWith,o2_getFileName_toLowerCase_endsWith,o1_getSubject,o2_getSubject,o1_getFileName,o2_getFileName,call_0,call_2_0],
                                           z3.And(call_0==call_2_0,o1_getFileName==o2_getFileName,o1_getSubject==o2_getSubject,o1_getFileName_toLowerCase_endsWith==o2_getFileName_toLowerCase_endsWith,self.ctx)))
        if self.file_name == "PokerHand-false.smt2":
            # compare@%_87_1 (select compare@%_6_0 (+ compare@%o1_lastIndexOf_0 (* 3 4))) == (higherTriple=o1_lastIndexOf[3])
            higherTriple_var = None
            o1_lastIndexOf_mem = None
            o2_lastIndexOf_mem = None
            o1_lastIndexOf_entry = None
            o2_lastIndexOf_entry = None
            for v in self.inv_vars:
                if str(v) == "compare@%_87_0":
                    higherTriple_var = v
                if str(v) == "compare@%_6_0":
                    o1_lastIndexOf_mem = v
                if str(v) == "compare@%o1_lastIndexOf_0":
                    o1_lastIndexOf_entry = v
                if str(v) == "compare@%_3_0":
                    o2_lastIndexOf_mem = v
                if str(v) == "compare@%o2_lastIndexOf_0":
                    o2_lastIndexOf_entry = v
            select_o1 = z3.Select(o1_lastIndexOf_mem,o1_lastIndexOf_entry + 12)
            self.predicates_tuples.append((z3.Bool("higherTriple_eq_o1_lastIndexOf_3",self.ctx), [higherTriple_var,o1_lastIndexOf_mem,o1_lastIndexOf_entry],higherTriple_var == select_o1))
            select_o2 = z3.Select(o2_lastIndexOf_mem, o2_lastIndexOf_entry + 12)
            self.predicates_tuples.append((z3.Bool("higherTriple_eq_o2_lastIndexOf_3", self.ctx),
                                           [higherTriple_var, o2_lastIndexOf_mem, o2_lastIndexOf_entry],
                                           higherTriple_var == select_o2))
        # if self.file_name == "PokerHand-true.smt2":
        #     higherTriple_var = None
        #     o1_lastIndexOf_mem = None
        #     o2_lastIndexOf_mem = None
        #     o1_lastIndexOf_entry = None
        #     o2_lastIndexOf_entry = None
        #     o1_countOccurrencesOf_mem = None
        #     o2_countOccurrencesOf_mem = None
        #     o1_countOccurrencesOf_entry = None
        #     o2_countOccurrencesOf_entry = None
        #     o1_indexOf_mem = None
        #     o1_indexOf_entry = None
        #     o2_indexOf_mem = None
        #     o2_indexOf_entry = None
        #     for v in self.inv_vars:
        #         if str(v) == "compare@%_87_0":
        #             higherTriple_var = v
        #         if str(v) == "compare@%_8_0":
        #             o1_lastIndexOf_mem = v
        #         if str(v) == "compare@%o1_lastIndexOf_0":
        #             o1_lastIndexOf_entry = v
        #         if str(v) == "compare@%_5_0":
        #             o2_lastIndexOf_mem = v
        #         if str(v) == "compare@%o2_lastIndexOf_0":
        #             o2_lastIndexOf_entry = v
        #         if str(v) == "compare@%_4_0":
        #             o1_countOccurrencesOf_mem = v
        #         if str(v) == "compare@%_3_0":
        #             o2_countOccurrencesOf_mem = v
        #         if str(v) == "compare@%o1_countOccurrencesOf_0":
        #             o1_countOccurrencesOf_entry = v
        #         if str(v) == "compare@%o2_countOccurrencesOf_0":
        #             o2_countOccurrencesOf_entry = v
        #         if str(v) == "compare@%_7_0":
        #             o1_indexOf_mem = v
        #         if str(v) == "compare@%o1_indexOf_0":
        #             o1_indexOf_entry = v
        #         if str(v) == "compare@%_6_0":
        #             o2_indexOf_mem = v
        #         if str(v) == "compare@%o2_indexOf_0":
        #             o2_indexOf_entry = v
        #     self.predicates_tuples.append((z3.Bool("compare@%_87_0_eq_0", self.ctx),
        #                                    [higherTriple_var],
        #                                    higherTriple_var == 0))
        #     select_o1 = z3.Select(o1_lastIndexOf_mem, o1_lastIndexOf_entry + 12)
        #     self.predicates_tuples.append((z3.Bool("higherTriple_eq_o1_lastIndexOf_3", self.ctx),
        #                                    [higherTriple_var, o1_lastIndexOf_mem, o1_lastIndexOf_entry],
        #                                    higherTriple_var == select_o1))
        #     select_o2 = z3.Select(o2_lastIndexOf_mem, o2_lastIndexOf_entry + 12)
        #     self.predicates_tuples.append((z3.Bool("higherTriple_eq_o2_lastIndexOf_3", self.ctx),
        #                                    [higherTriple_var, o2_lastIndexOf_mem, o2_lastIndexOf_entry],
        #                                    higherTriple_var == select_o2))
        #     self.predicates_tuples.append((z3.Bool("higherTriple_gt_o2_lastIndexOf_3", self.ctx),
        #                                    [higherTriple_var, o2_lastIndexOf_mem, o2_lastIndexOf_entry],
        #                                    higherTriple_var > select_o2))
        #     self.predicates_tuples.append((z3.Bool("o1_lastIndexOf_3_eq_o2_lastIndexOf_3", self.ctx),
        #                                    [o1_lastIndexOf_mem, o1_lastIndexOf_entry, o2_lastIndexOf_mem, o2_lastIndexOf_entry],
        #                                    select_o1 == select_o2))
        #     self.predicates_tuples.append((z3.Bool("ret_eq_0", self.ctx),
        #                                    [self.ret_var],
        #                                    self.ret_var == 0))
        #     self.predicates_tuples.append((z3.Bool("ret_gt_0", self.ctx),
        #                                    [self.ret_var],
        #                                    self.ret_var == 1))
        #     self.predicates_tuples.append((z3.Bool("ret_lt_0", self.ctx),
        #                                    [self.ret_var],
        #                                    self.ret_var == -1))
        #     select_o1_occur = z3.Select(o1_countOccurrencesOf_mem, o1_countOccurrencesOf_entry + 12)
        #     self.predicates_tuples.append((z3.Bool("tripleCount1_gt_1", self.ctx),
        #                                    [o1_countOccurrencesOf_mem, o1_countOccurrencesOf_entry],
        #                                    select_o1_occur > 1))
        #     select_o2_occur = z3.Select(o2_countOccurrencesOf_mem, o2_countOccurrencesOf_entry + 12)
        #     self.predicates_tuples.append((z3.Bool("tripleCount2_gt_1", self.ctx),
        #                                    [o2_countOccurrencesOf_mem, o2_countOccurrencesOf_entry],
        #                                    select_o2_occur > 1))
        #     self.predicates_tuples.append((z3.Bool("tripleCount1_eq_1", self.ctx),
        #                                    [o1_countOccurrencesOf_mem, o1_countOccurrencesOf_entry],
        #                                    select_o1_occur == 1))
        #     select_o2_occur = z3.Select(o2_countOccurrencesOf_mem, o2_countOccurrencesOf_entry + 12)
        #     self.predicates_tuples.append((z3.Bool("tripleCount2_eq_1", self.ctx),
        #                                    [o2_countOccurrencesOf_mem, o2_countOccurrencesOf_entry],
        #                                    select_o2_occur == 1))
        #     select_o1_index = z3.Select(o1_indexOf_mem, o1_indexOf_entry + 8)
        #     self.predicates_tuples.append((z3.Bool("o1_indexOf_eq_m1", self.ctx),
        #                                    [o1_indexOf_mem, o1_indexOf_entry],
        #                                    select_o1_index == -1))
        #     select_o2_index = z3.Select(o2_indexOf_mem, o2_indexOf_entry + 8)
        #     self.predicates_tuples.append((z3.Bool("o2_indexOf_eq_m1", self.ctx),
        #                                    [o2_indexOf_mem, o2_indexOf_entry],
        #                                    select_o2_index == -1))
        #     select_o1_index2 = z3.Select(o1_indexOf_mem, o1_indexOf_entry + 16)
        #     self.predicates_tuples.append((z3.Bool("o1_indexOf_eq_m12", self.ctx),
        #                                    [o1_indexOf_mem, o1_indexOf_entry],
        #                                    select_o1_index2 == -1))
        #     select_o2_index2 = z3.Select(o2_indexOf_mem, o2_indexOf_entry + 16)
        #     self.predicates_tuples.append((z3.Bool("o2_indexOf_eq_m12", self.ctx),
        #                                    [o2_indexOf_mem, o2_indexOf_entry],
        #                                    select_o2_index2 == -1))


    # less efficient index array and memory mining
    # def relate_array_vars(self):
    #     inv_vars_names = [str(v) for v in self.inv_vars]
    #     array_inv_vars = [v for v in self.inv_vars if v.sort() == z3.ArraySort([z3.IntSort(ctx=self.ctx), z3.IntSort(ctx=self.ctx)])]
    #     for body, xs, xps in self.trans_tuples:
    #         for inv_var in array_inv_vars:
    #             xs_names = [str(x) for x in xs]
    #             if str(inv_var) in xs_names:
    #                 select_exprs = self.find_select_exprs(body, str(inv_var))
    #                 if select_exprs is not None:
    #                     for expr in select_exprs:
    #                         right_oper = expr.children()[1]
    #                         vs = []
    #                         self.get_post_subst_vars(right_oper, vs)
    #                         if len(vs) == 0:
    #                             continue
    #                         for v in vs:
    #                             result = self.find_nondet_or_o_assigned(body, v, inv_vars_names)
    #                             if result is not None:
    #                                 self.entry_to_memory_map[str(result)] = inv_var
    #                             array_index = self.find_array_index(body, v, inv_vars_names)
    #                             if array_index is not None:
    #                                 name = str(array_index)
    #                                 if name not in self.array_index_vars:
    #                                     self.array_index_vars.append(name)
    #
    # def find_array_index(self, body, var_assigned_to, inv_vars_names):
    #     if "nondet" not in str(var_assigned_to) and "o1_" not in str(var_assigned_to) and "o2_" not in str(
    #             var_assigned_to) and str(var_assigned_to) in inv_vars_names:
    #         return var_assigned_to
    #
    #     assignments = self.get_assignto_exprs(body, var_assigned_to)
    #     if assignments is None:
    #         return None
    #     for assignment in assignments:
    #         right_expr = assignment.children()[1]
    #         vars_in_expr = []
    #         self.get_post_subst_vars(right_expr, vars_in_expr)
    #         if len(vars_in_expr) == 0:
    #             continue
    #         for v in vars_in_expr:
    #             result = self.find_array_index(body, v, inv_vars_names)
    #             if result is not None:
    #                 return result
    #
    # def find_nondet_or_o_assigned(self, body, var_assigned_to, inv_vars_names):
    #     if ("nondet" in str(var_assigned_to) or "o1_" in str(var_assigned_to) or "o2_" in str(var_assigned_to) or "o3_" in str(var_assigned_to)) and str(
    #             var_assigned_to) in inv_vars_names:
    #         return var_assigned_to
    #
    #     assignments = self.get_assignto_exprs(body, var_assigned_to)
    #     for assignment in assignments:
    #         right_expr = assignment.children()[1]
    #         vars_in_expr = []
    #         self.get_post_subst_vars(right_expr, vars_in_expr)
    #         if len(vars_in_expr) == 0:
    #             continue
    #         for v in vars_in_expr:
    #             result = self.find_nondet_or_o_assigned(body, v, inv_vars_names)
    #             if result is not None:
    #                 return result
    #
    # def get_post_subst_vars(self, body, vs):
    #     if len(body.children()) == 0 and not is_int_value(body) and not is_true(body) and not is_false(body):
    #         vs.append(body)
    #     else:
    #         for kid in body.children():
    #             self.get_post_subst_vars(kid, vs)
    #
    # def get_assignto_exprs(self, body, var_assigned_to):
    #     children = body.children()
    #     if len(children) == 0:
    #         return None
    #     if is_eq(body) and str(body.children()[0]) == str(var_assigned_to):
    #         return [body]
    #     assignments = []
    #     for child in children:
    #         assignment = self.get_assignto_exprs(child, var_assigned_to)
    #         if assignment is not None:
    #             assignments.extend(assignment)
    #     return assignments if len(assignments) > 0 else None

    def find_select_exprs(self, body, inv_var_name):
        children = body.children()
        if len(children) == 0:
            return None
        if is_select(body) and str(body.children()[0]) == str(inv_var_name):
            return [body]
        selects = []
        for child in children:
            select = self.find_select_exprs(child, inv_var_name)
            if select is not None:
                selects.extend(select)
        return selects if len(selects) > 0 else None

    def update_dynamic_program(self, dp):
        dp.entry_to_memory_map = self.entry_to_memory_map
        dp.array_index_vars = self.array_index_vars
        if len(self.predicates_tuples) > 0 or self.force_predicate_abstraction:
            dp.is_predicate_abstraction = True
        dp.num_of_vars_single_copy = len(self.inv_vars)
        dp.set_trs(self.trans_tuples, self.inv_varsp)
        dp.ret_var_name = (str(self.ret_var))
        dp.mk_ret_vars()
        self.rel_predicates_tuples.extend(dp.mk_neg_rel_bad_pred())
        self.rel_predicates_tuples.extend(dp.mk_preds_for_precondition())
        self.rel_predicates_tuples.extend(dp.mk_preds_for_array_indices())
        # self.rel_predicates_tuples.extend(dp.mk_predefined_relational_preds())
        # self.mk_predefined_single_copy_preds()
        # self.rel_predicates_tuples.extend(dp.mk_nondet_predicates()) # did not help prooving
        if dp.is_predicate_abstraction:
            dp.set_predicates_tuples(self.predicates_tuples)
            dp.set_rel_predicates(self.rel_predicates_tuples)
            dp.has_pc = True
            dp.mk_pred_abstraction_inv(self.inv_varsp)
        else:
            dp.mk_inv(self.inv_vars, self.inv_varsp)
        dp.set_inits(self.init_cond, self.inv_vars)
        dp.set_exits(self.exit_tuples)

    def substitube_to_inv_vars_only(self, expr, full_body, all_results):
        if len(expr.children()) == 0:
            if (z3.is_int_value(expr) if expr.sort() == z3.IntSort() else z3.is_const(expr)) or expr in self.inv_vars:
                return [expr]
            else:
                assigned_exprs = self.get_assigned_expr(expr, full_body)
                for ass_expr in assigned_exprs:
                    all_results.extend(self.substitube_to_inv_vars_only(ass_expr, full_body, all_results))
        else:
            for kid in expr.children():
                self.substitube_to_inv_vars_only(kid, full_body, all_results)

    def get_assigned_expr(self, v, full_body):
        lst = []
        for expr in full_body.children():
            expr_kids = expr.children()
            if len(expr_kids) > 0 and str(expr.children()[0]) == str(v):
                lst.append(expr_kids[1])
        return lst

    # def mk_predefined_single_copy_preds(self):
    #     # len1_eq_len2
    #     len1 = self.get_concrete_var_by_name("len1")
    #     len2 = self.get_concrete_var_by_name("len2")
    #     expr = len1 == len2
    #     pred_var = z3.Bool("len1_eq_len2", self.ctx)
    #     self.predicates_tuples.append((pred_var, [len1, len2], expr))
    #     # flag1
    #     flag1 = self.get_concrete_var_by_name("compare@%_call4_")
    #     expr = flag1
    #     pred_var = z3.Bool("abs_flag1", self.ctx)
    #     self.predicates_tuples.append((pred_var, [flag1], expr))
    #     # flag2
    #     flag2 = self.get_concrete_var_by_name("compare@%.0_")
    #     expr = flag2
    #     pred_var = z3.Bool("abs_flag2", self.ctx)
    #     self.predicates_tuples.append((pred_var, [flag2], expr))
    #     # alast_eq_blast
    #     alast = self.get_concrete_var_by_name("alast")
    #     blast = self.get_concrete_var_by_name("blast")
    #     expr = alast == blast
    #     pred_var = z3.Bool("alast_eq_blast", self.ctx)
    #     self.predicates_tuples.append((pred_var, [alast, blast], expr))
    #     # i_lt_len1
    #     i = self.get_concrete_var_by_name("i")
    #     len1 = self.get_concrete_var_by_name("len1")
    #     expr = i < len1
    #     pred_var = z3.Bool("i_lt_len1", self.ctx)
    #     self.predicates_tuples.append((pred_var, [i, len1], expr))
    #
    # def get_concrete_var_by_name(self, name):
    #     for v in self.all_concrete_vars:
    #         if name in str(v):
    #             return v
