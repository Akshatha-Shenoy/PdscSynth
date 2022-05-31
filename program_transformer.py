from z3 import *
import re
import z3.z3printer
z3.z3printer._PP.max_lines=999999
z3.z3printer._Formatter.max_depth=999999
z3.z3printer._Formatter.max_args=999999
z3.z3printer._Formatter.max_visited=999999
# Simplistic (and fragile) converter from
# a class of Horn clauses corresponding to
# a transition system into a transition system
# representation as <init, trans, exit>
# It assumes it is given these forms of Horn clauses
#  (1) relational_init_cond(x) => RelInit(x)
#  (2) init_cond(x) => Inv(x)
#  (3) Inv(x) & TR(x,xp) => Inv(xp)
#  (4) Inv(x) & end_cond(x) => End
#  (5) relational_bad_cond(x) => RelBad(x)
#  (6) pred_cond(x) => Pred(x)
#  *******************************************
#  (1),(5) and (6) may contain relational variables- i.e. for variable y rel(y,i) denotes y in copy i
#  (1) and (6) are optional
from dynamic_program import DynamicProgram


def transform(file_path, force_predicate_abstraction,concrete_array_vars):
    return Transformer(force_predicate_abstraction,concrete_array_vars).parse(file_path)


class Transformer:
    def __init__(self, force_predicate_abstraction,concrete_array_vars):
        self.file_name = None
        self.ctx = z3.Context()
        self.dp = None
        self.fp = None
        self.trans_tuples = []
        self.var_id_to_normal_var = {}
        self.curr_rule = None
        self.init_cond = None
        self.end_tuples = None
        self.inv_vars = []
        self.inv_varsp = {}
        self.predicates_tuples = []
        self.try_again = []
        self.force_predicate_abstraction = force_predicate_abstraction
        self.quantified_vars = [z3.Int('x', self.ctx)]

        self.concrete_array_vars = concrete_array_vars
        self.vars_order= ''
        self.list_in_order = []

        self.rel_vars = {}
        self.rel_init = None
        self.rel_bad = None
        self.rel_predicates_tuples = []

    def parse(self, file_path):
        #print('parse1')
        self.file_name = file_path.split('/')[len(file_path.split('/')) - 1]
        #print('parse2')
        self.fp = Fixedpoint(ctx=self.ctx)
        #print('parse3')
        self.fp.parse_file(file_path)
        #print('after parse_file')
        dp = DynamicProgram(False, self.ctx)

        #print('in parse of program transformer',self.rel_init)
        for r in self.fp.get_rules():
            #print('r',r)
            self.curr_rule = r
            #print('curr_rule',self.curr_rule)
            if not is_quantifier(r):
                #print('not quantifier(r)')
                continue
            b = r.body()
            #print('b',b)
            if not is_implies(b):
                #print('not implies of b')
                continue
            f = b.arg(0)

            g = b.arg(1)
            #print('f,g',f,g)
            if self.try_init(f, g):
                #print('parse4',self.rel_init)
                continue
            if self.try_end(f, g):  # check if g is compare
                continue
            if self.try_transition(f, g):  # check that f,g has two compare_1
                continue
            if self.try_rel_init(f, g):
                #print('parse5',self.rel_init)
                continue
            if self.try_rel_bad(f, g):
                continue
            if self.try_predicate(f, g):
                continue
        for f, g in self.try_again:
            if self.try_rel_init(f, g):
                #print('parse6',self.rel_init)
                continue
            if self.try_rel_bad(f, g):
                continue
            if self.try_predicate(f, g):
                continue
        #print('list_in_order',self.list_in_order)
        self.update_dynamic_program(dp)  # dont forget to set "property to prove" to -1
        #print('end of parse',self.rel_init)
        return dp

    def is_pred(self, p, name):
        return is_app(p) and p.decl().name() == name

    def try_init(self, body, head):
        #print('in try_init')
        if not self.is_pred(head, "Inv") or self.is_pred(self.get_pred_from_body(body), "Inv"):
            return False
        body, body_xs = self.subst_vars(body)
        self.init_cond = body
        head , head_xs=  self.subst_vars(head)
        self.inv_vars.extend(head_xs)
        return True

    def try_end(self, body, head):
        body_pred = self.get_pred_from_body(body)
        if not self.is_pred(body_pred, "Inv") or not self.is_pred(head, "End"):
            return False
        body = z3.substitute(body, [(body_pred, z3.BoolVal(True, self.ctx))])
        body, body_xs = self.subst_vars(body)
        self.end_tuples = [(head, body, body_xs, [])]
        return True

    def subst_vars(self, body):
        if isinstance(body,QuantifierRef):
            subst = self.mk_subst(body.children()[0],True)
        else:
            subst = self.mk_subst(body)
        #str_vars_type = []
        for v, x in subst:
            if v.get_id() not in self.var_id_to_normal_var:
                self.var_id_to_normal_var[v.get_id()] = x
        '''
        if not(str(type(self.var_id_to_normal_var[v.get_id()])).find('Arith') == -1):
            str_vars_type.append('Int')
        elif not(str(type(self.var_id_to_normal_var[v.get_id()])).find('Bool') == -1):
                    str_vars_type.append('Bool')

        if not(self.var_id_to_normal_var == {}) and (self.vars_order == ''):
            self.vars_order = ( ((str(self.var_id_to_normal_var)[1:][:-1])).replace(' ','')).split(',')


            print('self.vars_order',self.vars_order)
            print('str_vars_type',str_vars_type)
            print(len(str_vars_type)==len(self.vars_order))
            dictionary_vars_out_of_order = dict()
            i=0
            for elements in self.vars_order:
                key_var =(elements).split(':')
                dictionary_vars_out_of_order[int(key_var[0])]= '('+ str(key_var[1])+','+str(str_vars_type[i])+')'
                i +=1
            print('dictionary_vars_out_of_order',dictionary_vars_out_of_order)
            list1 = [int(x) for x in dictionary_vars_out_of_order.keys()]

            list1 = reversed(sorted(list1))
            print('list1',list1)
            if self.list_in_order == []:
                for i in list1:
                    self.list_in_order.append(dictionary_vars_out_of_order[i])
        '''
        all_vars = [v for (k, v) in subst]
        #print('all_vars',all_vars)
        unique_vars_names = []
        unique_vars = []
        for v in all_vars:
            if str(v) not in unique_vars_names:
                unique_vars.append(v)
                unique_vars_names.append(str(v))
        #print('unique_vars,unique_var_names',unique_vars,unique_vars_names)
        if isinstance(body,QuantifierRef):
            return ForAll(self.quantified_vars[0],substitute(body.children()[0], subst)), unique_vars+self.quantified_vars
        return substitute(body, subst), unique_vars

    def mk_subst(self, body,quantified = False):
        vars_in_body = []
        self.get_pre_subst_vars(body, vars_in_body)
        total = self.curr_rule.num_vars() - 1
        if quantified:
            total += 1
        ret = []
        ret.extend([(f, self.mk_var(f, total)) for f in
                    vars_in_body])
        return ret

    def get_pre_subst_vars(self, body, vs):
        if len(body.children()) == 0 and "Var" in str(body):
            vs.append(body)
        for kid in body.children():
            if len(kid.children()) == 0 and "Var" in str(kid):
                vs.append(kid)
            else:
                self.get_pre_subst_vars(kid, vs)

    def mk_var(self, f, total):
        f_num = int(re.findall('\d+', str(f))[0])
        if total-f_num>= self.curr_rule.num_vars():
            return self.quantified_vars[0]
        if f.sort() == z3.IntSort(ctx=self.ctx):
            return Int("%s" % (self.curr_rule.var_name(total - f_num)), self.ctx)
        elif f.sort() == z3.BoolSort(ctx=self.ctx):
            return Bool("%s" % (self.curr_rule.var_name(total - f_num)), self.ctx)
        elif f.sort() == z3.ArraySort([z3.IntSort(ctx=self.ctx), z3.IntSort(ctx=self.ctx)]):
            return Array("%s" % (self.curr_rule.var_name(total - f_num)), IntSort(self.ctx), IntSort(self.ctx))
        else:
            print("unsupported variable sort. only Int, Bool, Array(Int Int) are supported.")
            return None

    def get_pred_from_body(self, body):
        if is_app(body) and not is_and(body):
            return body
        for child in body.children():
            pred = self.get_pred_from_body(child)
            if pred is not None:
                return child

    def try_transition(self, body, head):
        #print('in try_transition')
        body_pred = self.get_pred_from_body(body)
        if not (self.is_pred(body_pred, "Inv") and self.is_pred(head, "Inv")):
            return False
        body, xs = self.subst_vars(body)
        head, xps = self.subst_vars(head)

        # body without predicate
        body = z3.substitute(body, [(self.get_pred_from_body(body), z3.BoolVal(True, self.ctx))])

        self.trans_tuples.append(
            (z3.And(body, self.ctx), xs, xps))

        for xp in xps:
            for x in xs:
                if str(xp)[:-1] == str(x):
                    self.inv_varsp[x] = xp
                    break
        return True

    def try_rel_init(self, body, head):
        #print('In try_rel_init')
        if not self.is_pred(head, "RelInit"):
            return False
        if len(self.inv_vars) == 0:
            self.try_again.append((body, head))
            return True
        #print('try rel_init0',self.rel_init)
        body = self.subst_vars(body)[0]
        #print('try rel_init1',body)
        fmls = body.children()
        subst_body = body
        #print('try rel_init2',self.rel_init,subst_body)
        for f in fmls:
            subst = []
            self.subst_rel_vars(f, subst)
            subst_body = substitute(subst_body, subst)
        self.rel_init = subst_body
        #print('try rel_init3',self.rel_init)
        return True

    def try_rel_bad(self, body, head):
        #print('in try_rel_bad')
        if not self.is_pred(head, "RelBad"):
            return False
        if len(self.inv_vars) == 0:
            self.try_again.append((body, head))
            return True
        body = self.subst_vars(body)[0]
        fmls = body.children()
        subst = []
        subst_body = body
        self.subst_rel_vars(body, subst)
        for f in fmls:
            self.subst_rel_vars(f, subst)
            subst_body = substitute(subst_body, subst)
        self.rel_bad = subst_body
        return True

    def subst_rel_vars(self, pred, subst):
        for expr in pred.children():
            if str(expr) in [str(x) for x in self.inv_vars]:
                copy_id = pred.children()[
                    1]  # assuming that if we see a variable then its an expresion rel(v_id,copy_id)
                single_copy_var = self.get_inv_var_by_str(str(expr))
                var_name = str(single_copy_var) + "_" + str(copy_id)
                if var_name not in self.rel_vars:
                    new_var = None
                    if single_copy_var.sort() == z3.IntSort(self.ctx):
                        new_var = Int(var_name, self.ctx)
                    elif single_copy_var.sort() == z3.BoolSort(self.ctx):
                        new_var = Bool(var_name, self.ctx)
                    elif single_copy_var.sort() == z3.ArraySort([z3.IntSort(self.ctx), z3.IntSort(self.ctx)]):
                        new_var = Array(var_name, IntSort(self.ctx), IntSort(self.ctx))
                    else:
                        print("unsupported variable sort. only Int, Bool, Array(Int Int) are supported.")
                    self.rel_vars[var_name] = new_var
                subst.append((pred, self.rel_vars[var_name]))
            self.subst_rel_vars(expr, subst)

    def get_inv_var_by_str(self, s):
        for x in self.inv_vars:
            if str(x) == s:
                return x

    def try_predicate(self, body, head):
        #print('in try_predicate')
        if not is_app(head) or self.is_pred(head, "Inv") or self.is_pred(head, "RelInit") or self.is_pred(head,
                                                                                                          "End") or self.is_pred(
            head, "RelBad"):
            return False
        pred_name = head.decl().name()
        #print('bbody',body)
        if self.list_in_order == []:
            a,b = self.subst_vars(head)


            for el in b:
                if not(str(type(el)).find('Arith') == -1):
                    self.list_in_order.append('('+str(el)+','+'Int'+')')
                else:
                    self.list_in_order.append('('+str(el)+','+'Bool'+')')

                    #print('self.list_in_order',self.list_in_order)
        #print('hhead',head,a,b)
        if len(self.inv_vars) == 0:
            self.try_again.append((body, head))
            #print('self.try_again',self.try_again,body,head)
            return True
        relational = self.contains_rel(body)  # todo: check if relational
        #print('relational',relational)
        if relational:
            self.handle_rel_predicate(pred_name, body)
        else:
            self.handle_predicate(pred_name, body)
        return True

    def contains_rel(self, body):
        for expr in body.children():
            if is_app(expr):
                if "rel" in expr.decl().name():
                    return True
        for expr in body.children():
            if self.contains_rel(expr):
                return True
        return False

    def handle_rel_predicate(self, name, body):
        #print('body',body)
        subst_body = self.subst_vars(body)[0]
        #print('subst_body',subst_body)
        fmls = subst_body.children()
        subst = []
        for f in fmls:
            self.subst_rel_vars(f, subst)
        subst_body = substitute(subst_body, subst)
        rel_pred = subst_body
        pred_var = z3.Bool(name, self.ctx)
        self.rel_predicates_tuples.append((pred_var, [post_subst for pre_subst, post_subst in subst], rel_pred))

    def handle_predicate(self, pred_name, body):
        subst_body, xs = self.subst_vars(body)
        pred_var = z3.Bool(pred_name, self.ctx)
        self.predicates_tuples.append((pred_var, xs, subst_body))

    def get_array_vars(self):
        return [x for x in self.inv_vars if x.sort() ==z3.ArraySort([z3.IntSort(ctx=self.ctx), z3.IntSort(ctx=self.ctx)])]

    def update_dynamic_program(self, dp):
        if len(self.predicates_tuples) > 0 or self.force_predicate_abstraction:
            dp.is_predicate_abstraction = True
        dp.set_predefined_rel_vars(self.rel_vars)
        dp.num_of_vars_single_copy = len(self.inv_vars)
        dp.set_trs(self.trans_tuples, self.inv_varsp)
        if dp.is_predicate_abstraction:
            dp.set_predicates_tuples(self.predicates_tuples)
            dp.set_rel_predicates(self.rel_predicates_tuples)
            dp.has_pc = False
            dp.mk_pred_abstraction_inv(self.inv_varsp,self.get_array_vars() if self.concrete_array_vars else None)
        else:
            dp.mk_inv(self.inv_vars, self.inv_varsp)
        dp.set_rel_init(self.rel_init)
        dp.set_inits(self.init_cond, self.inv_vars)
        dp.set_exits(self.end_tuples)
        dp.set_rel_bad(self.rel_bad)
        dp.set_list_in_order(self.list_in_order)
