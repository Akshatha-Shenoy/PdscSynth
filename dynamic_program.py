import z3
import z3.z3printer
z3.z3printer._PP.max_lines=999999
z3.z3printer._Formatter.max_depth=999999
z3.z3printer._Formatter.max_args=999999
z3.z3printer._Formatter.max_visited=999999
from explicit_composition import ExplicitComposition


class DynamicProgram:
    def __init__(self, is_comparator, ctx,prop=None):
        self.ctx = ctx

        self.prop_to_prove = prop
        # 0- anti-symmetry
        # 1- non-deterministic
        # 2- transitivity
        # 3- the nameless property P3
        # 4- swap
        # 5- permutation
        self.k = 2
        if self.prop_to_prove in [2, 3, 5] and is_comparator:
            self.k = 3
        self.possible_assignments = (self.k ** 2) - 1
        self.first_time = True
        self.is_predicate_abstraction = False
        self.copy_id_to_concrete_vars = {}
        self.concrete_var_to_varp = None
        self.num_of_vars_single_copy = 0
        self.concrete_vars = []
        self.predefined_rel_vars = {}
        self.Inv = None
        self.inv_relation = None
        self.inv_vars = None
        self.inv_varsp = None
        self.copy_to_var_varp = {}
        self.bad_expr = None
        self.Bad = None
        self.rel_bad = None
        self.mk_bad_rel()
        self.bad_decl = self.Bad.decl()
        self.bad_rule = None
        self.all_end = None
        self.bad_extensions = []
        self.exits = None
        self.ret_var_name = None
        self.ret_0 = None
        self.ret_1 = None
        self.ret_2 = None
        self.init_rule = None
        self.inits = None
        self.rel_init = None
        self.rel_init_exprs = None
        self.trs = None
        self.sc_tr = None
        self.sc_tr_rule = None
        self.loops = None
        self.updated_trs_self_loop = False
        self.composition_var = z3.Int("composition", ctx)  # self composition directive
        self.composition_var_p = z3.Int("composition_p", ctx)
        self.declared_vars = [self.composition_var, self.composition_var_p]
        self.blocked_exprs = []
        self.abstract_var_to_cond_tuples = []
        self.abstract_var_p_to_cond_tuples = []
        self.predicate_tuples = None
        self.rel_predicate_tuples = None
        self.num_predicates_single_copy = None
        self.copy_id_to_abstract_vars = {}
        self.pred_id_to_predp_var = {}
        self.abstract_var_names = None
        self.copy_id_to_predicate_tuples = {}
        self.h_p = None
        self.h = None
        self.entry_to_memory_map = {}
        self.array_index_vars = []
        self.default_composition = True
        self.has_pc = None
        self.use_explicit_conposition_function = False
        self.composition_func = ExplicitComposition(self, self.ctx)
        self.quantified_vars = []
        self.concrete_array_indices = []
        #batch 1 : init_condition
        self.init_condition = None
        #batch 2 : bad_condition
        self.bad_condition = None
        self.original_bad_cond = None
        #batch 3 : predicates
        self.predicates = []
        #batch 4 : var_string_dict
        self.var_string_dict = dict()
        #order of variables as appears in predicates Argument
        self.list_in_order = []
        self.copy_0 = None
        self.copy_1 = None
        self.copy_2 = None
        self.copy1 = None
        self.copy2 = None
        self.copy3 = None
        self.copy4 = None
        self.copy5 = None
        self.copy6 = None
        self.copy7 = None

    def find_tr(self,copy):
        if self.k == 2:
            if str(copy)== str(0):
                return self.copy_0
            elif str(copy) == str(1):
                return self.copy_1
            else:
                return self.copy_2
        else:
            if str(copy)== str(1):
                return self.copy1
            elif str(copy)== str(2):
                return self.copy2
            elif str(copy)== str(3):
                return self.copy3
            elif str(copy)== str(4):
                return self.copy4
            elif str(copy)== str(5):
                return self.copy5
            elif str(copy)== str(6):
                return self.copy6
            else:
                return self.copy7

    def set_list_in_order(self,list_in_order):
        self.list_in_order = list_in_order


    def get_concrete_var_by_name(self, name, copy=None):
        for i in (range(self.k) if copy is None else [copy]):
            for v in self.copy_id_to_concrete_vars[i].values():
                if name in str(v):
                    return v

    def set_predefined_rel_vars(self, rel_vars):
        self.predefined_rel_vars = rel_vars

    def get_tr_vars_p_id(self, tr_vars_p, var_name):
        for v in tr_vars_p:
            if str(v) == var_name:
                return v.get_id()

    def get_var_p_for_duplicated_var(self, v, concrete_inv_varsp_map):
        names_map = self.to_str_map(concrete_inv_varsp_map)
        var_name = str(v)[:-2]
        varp_name = None
        if var_name in names_map.keys():
            varp_name = str(names_map[var_name])
        copy_id = int(str(v)[-1:])
        if varp_name is None:
            varp_name = var_name
        for x in self.copy_id_to_concrete_vars[copy_id].values():
            if str(x).startswith(varp_name) and str(x) != var_name:
                return x
        return v

    def to_str_map(self, concrete_inv_varsp_map):
        new_map = {}
        for k, v in concrete_inv_varsp_map.items():
            new_map[str(k)] = str(v)
        return new_map

    def get_copy_abstract_vars(self, copy_id):
        if copy_id not in self.copy_id_to_abstract_vars:
            self.copy_id_to_abstract_vars[copy_id] = []
            self.copy_id_to_predicate_tuples[copy_id] = []
            for pred_var, xs, fml in self.predicate_tuples:
                pred_id = pred_var.get_id()
                sc_pred = z3.Bool(str(pred_var) + "_" + str(copy_id), self.ctx)
                sc_predp = z3.Bool(str(pred_var) + "_" + str(copy_id) + "p", self.ctx)
                self.pred_id_to_predp_var[pred_id] = sc_predp
                self.copy_id_to_abstract_vars[copy_id].append(sc_pred)
                subst = self.get_copy_vars_subts(xs, copy_id, False)
                sc_vs = [sc_v for v, sc_v in subst]
                self.declared_vars.extend(sc_vs)
                self.concrete_vars.extend(sc_vs)
                self.declared_vars.append(sc_pred)
                self.declared_vars.append(sc_predp)
                subst_cond = z3.substitute(fml, subst)
                self.abstract_var_to_cond_tuples.append((sc_pred, subst_cond))
                self.copy_id_to_predicate_tuples[copy_id].append((sc_pred, sc_vs, subst_cond))
                xs_to_xps = [(x, self.concrete_var_to_varp[str(x)] if str(x) in self.concrete_var_to_varp.keys() else x)
                             for x in xs]
                fml = z3.substitute(fml, xs_to_xps)
                xps = [xp for x, xp in xs_to_xps]
                subst_cond_p = z3.substitute(fml, self.get_copy_vars_subts(xps, copy_id, False))
                self.abstract_var_p_to_cond_tuples.append((sc_predp, subst_cond_p))
        vars_copied = list(set(self.concrete_vars))
        for weird_id in vars_copied:
            if not(str(weird_id)[-3] == 'p'):
                self.var_string_dict[str(weird_id)] = weird_id
        return self.copy_id_to_abstract_vars[copy_id]


    def get_copy_vars_subts(self, param, copy_id, extend_concrete_vars=False):
        if copy_id not in self.copy_id_to_concrete_vars:
            self.copy_id_to_concrete_vars[copy_id] = {}
        ret = []
        for v in param:
            v_id = v.get_id()
            if v_id in self.copy_id_to_concrete_vars[copy_id]:
                ret.append((v, self.copy_id_to_concrete_vars[copy_id][v_id]))
                continue
            if v.sort() == z3.IntSort(self.ctx):
                sc_v = z3.Int(str(v) + "_" + str(copy_id), self.ctx)
            elif v.sort() == z3.BoolSort(self.ctx):
                sc_v = z3.Bool(str(v) + "_" + str(copy_id), self.ctx)
            elif v.sort() == z3.ArraySort([z3.IntSort(self.ctx), z3.IntSort(self.ctx)]):
                sc_v = z3.Array(str(v) + "_" + str(copy_id), z3.IntSort(self.ctx), z3.IntSort(self.ctx))
            else:
                print("unsupported sort: " + str(v.sort()))
                continue
            sc_v_name = str(sc_v)
            if sc_v_name in self.predefined_rel_vars.keys():
                sc_v = self.predefined_rel_vars[sc_v_name]
            self.copy_id_to_concrete_vars[copy_id][v_id] = sc_v
            ret.append((v, sc_v))
        if extend_concrete_vars:
            self.concrete_vars.extend([sc_v for v, sc_v in ret])
        return ret

    def set_predicates_tuples(self, tuples):
        self.predicate_tuples = tuples
        self.num_predicates_single_copy = len(self.predicate_tuples)

    def set_rel_predicates(self, rel_pred_tuples):
        self.rel_predicate_tuples = rel_pred_tuples
        for name,variables,value in rel_pred_tuples:
            self.predicates.append(name)

    def set_inits(self, init_cond, init_vars):
        self.inits = []
        for i in range(self.k):
            self.inits.append(z3.substitute(init_cond,
                                            self.get_copy_vars_subts(init_vars, i, False)))
        self.add_relational_pre()

    def set_rel_init(self, rel_init_expr):
        self.rel_init_exprs = [rel_init_expr]

    def add_relational_pre(self):
        exprs = list(self.rel_init_exprs)
        if len(exprs) == 1:
            self.rel_init = exprs[0]
        else:
            exprs.append(self.ctx)
            self.rel_init = z3.And(*exprs)

    def mk_preds_for_array_indices(self):
        preds = []
        for index in self.array_index_vars:
            i_0_name = index + "_0"
            i_0 = None
            i_1_name = index + "_1"
            i_1 = None
            for v in self.copy_id_to_concrete_vars[0].values():
                if str(v) == i_0_name:
                    i_0 = v
            for v in self.copy_id_to_concrete_vars[1].values():
                if str(v) == i_1_name:
                    i_1 = v
            eq = i_0 == i_1
            self.rel_init_exprs.append(eq)
            preds.append((z3.Bool(str(i_0) + "_eq_" + str(i_1), self.ctx), [i_0, i_1], eq))
            if self.k == 3:
                i_2_name = index + "_2"
                i_2 = None
                for v in self.copy_id_to_concrete_vars[2].values():
                    if str(v) == i_2_name:
                        i_2 = v
                eq = i_1 == i_2
                self.rel_init_exprs.append(eq)
                preds.append((z3.Bool(str(i_1) + "_eq_" + str(i_2), self.ctx), [i_1, i_2], eq))
        return preds

    def mk_preds_for_pre_prop_0(self):
        preds = []
        # 2 copies anti-symmetry
        self.rel_init_exprs = []
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            other_copy_vname = None
            if "o1" in vname:
                other_copy_vname = vname.replace("o1", "o2")[:-1] + "1"
            elif "o2" in vname:
                other_copy_vname = vname.replace("o2", "o1")[:-1] + "1"
            elif "nondet" in vname:
                other_copy_vname = vname[:-1] + "1"
            if other_copy_vname is None:
                continue  # other_copy_vname = vname[:-1] + "1"
            for other_v in self.copy_id_to_concrete_vars[1].values():
                if str(other_v) == other_copy_vname:
                    eq = other_v == v
                    self.rel_init_exprs.append(eq)
                    preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
            if vname[:-2] in self.entry_to_memory_map.keys():
                preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        return preds

    def mk_preds_for_pre_prop_1(self):
        preds = []
        self.rel_init_exprs = []
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            other_copy_vname = None
            if "o1" in vname:
                other_copy_vname = vname[:-1] + "1"
            elif "o2" in vname:
                other_copy_vname = vname[:-1] + "1"
            elif "nondet" in vname:
                other_copy_vname = vname[:-1] + "1"
            if other_copy_vname is None:
                continue  # other_copy_vname = vname[:-1] + "1"
            for other_v in self.copy_id_to_concrete_vars[1].values():
                if str(other_v) == other_copy_vname:
                    eq = other_v == v
                    self.rel_init_exprs.append(eq)
                    preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
            if vname[:-2] in self.entry_to_memory_map.keys():
                preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        return preds

    def mk_preds_for_pre_prop_2(self):
        preds = []
        self.rel_init_exprs = []
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o1" in vname:
                other_copy_vname = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname.replace("o2", "o1")[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[1].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 1, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "nondet" in vname:
                other_copy_vname_1 = vname[:-1] + "1"
                other_copy_vname_2 = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname_1:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname_2:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname_1[:-2], 1))
                    preds.append(
                        self.add_memory_eq_predicate(other_copy_vname_1[:-2], 1, other_copy_vname_2[:-2], 2))
        return preds

    def mk_preds_for_pre_prop_3(self):
        preds = []
        self.rel_init_exprs = []
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o1" in vname:
                other_copy_vname = vname[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname.replace("o2", "o1")[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[1].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 1, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "nondet" in vname:
                other_copy_vname_1 = vname[:-1] + "1"
                other_copy_vname_2 = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname_1:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname_2:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname_1[:-2], 1))
                    preds.append(
                        self.add_memory_eq_predicate(other_copy_vname_1[:-2], 1, other_copy_vname_2[:-2], 2))

        return preds

    def mk_preds_for_pre_prop_4(self):
        preds = []
        self.rel_init_exprs = []
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o1" in vname:
                other_copy_vname = vname.replace("o1", "o2")[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname.replace("o2", "o1")[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o3" in vname:
                other_copy_vname = vname[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "nondet" in vname:
                other_copy_vname_1 = vname[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname_1:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname_1[:-2], 1))
        return preds

    def mk_preds_for_pre_prop_5(self):
        preds = []
        self.rel_init_exprs = []
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o1" in vname:
                other_copy_vname = vname.replace("o1", "o2")[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname.replace("o2", "o1")[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o3" in vname:
                other_copy_vname = vname[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 1))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "nondet" in vname:
                other_copy_vname_1 = vname[:-1] + "1"
                for other_v in self.copy_id_to_concrete_vars[1].values():
                    if str(other_v) == other_copy_vname_1:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname_1[:-2], 1))
        # second conjunct
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o1" in vname:
                other_copy_vname = vname.replace("o1", "o3")[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o3" in vname:
                other_copy_vname = vname.replace("o3", "o1")[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "o2" in vname:
                other_copy_vname = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname[:-2], 2))
        for v in self.copy_id_to_concrete_vars[0].values():
            vname = str(v)
            if "nondet" in vname:
                other_copy_vname_1 = vname[:-1] + "2"
                for other_v in self.copy_id_to_concrete_vars[2].values():
                    if str(other_v) == other_copy_vname_1:
                        eq = other_v == v
                        self.rel_init_exprs.append(eq)
                        preds.append((z3.Bool(str(v) + "_eq_" + str(other_v), self.ctx), [v, other_v], eq))
                if vname[:-2] in self.entry_to_memory_map.keys():
                    preds.append(self.add_memory_eq_predicate(vname[:-2], 0, other_copy_vname_1[:-2], 2))
        return preds

    def mk_preds_assume_swap_perm(self):
        preds = []
        for i in range(self.k):
            o1id = self.get_concrete_var_by_name("o1_id_",i)
            o2id = self.get_concrete_var_by_name("o2_id_",i)
            o3id = self.get_concrete_var_by_name("o3_id_",i)
            o1min12 = self.get_concrete_var_by_name("o1_min12",i)
            o1min13 = self.get_concrete_var_by_name("o1_min13",i)
            o1min23 = self.get_concrete_var_by_name("o1_min23",i)
            o1min123 = self.get_concrete_var_by_name("o1_min123",i)

            self.rel_init_exprs.append(o1id != o2id)
            preds.append((z3.Bool(str(o1id) + "_neq_" + str(o2id), self.ctx), [o1id, o2id], o1id != o2id))
            self.rel_init_exprs.append(o1id != o3id)
            preds.append((z3.Bool(str(o1id) + "_neq_" + str(o3id), self.ctx), [o1id, o3id], o1id != o3id))
            self.rel_init_exprs.append(o2id != o3id)
            preds.append((z3.Bool(str(o2id) + "_neq_" + str(o3id), self.ctx), [o2id, o3id], o2id != o3id))

            expr = o1min12 == o1id
            preds.append((z3.Bool(str(o1id) + "lteq" + str(o2id), self.ctx), [o1id, o2id], o1id <= o2id))
            self.rel_init_exprs.append(z3.Implies(o1id <= o2id, expr, self.ctx))
            preds.append((z3.Bool(str(o1min12) + "_eq_" + str(o1id), self.ctx), [o1min12, o1id], expr))
            expr = o1min12 == o2id
            self.rel_init_exprs.append(z3.Implies(o1id > o2id, expr, self.ctx))
            preds.append((z3.Bool(str(o1min12) + "_eq_" + str(o2id), self.ctx), [o1min12, o2id], expr))

            expr = o1min13 == o1id
            preds.append((z3.Bool(str(o1id) + "_lteq_" + str(o3id), self.ctx), [o1id, o3id], o1id <= o3id))
            self.rel_init_exprs.append(z3.Implies(o1id <= o3id, expr, self.ctx))
            preds.append((z3.Bool(str(o1min13) + "_eq_" + str(o1id), self.ctx), [o1min12, o1id], expr))
            expr = o1min13 == o3id
            self.rel_init_exprs.append(z3.Implies(o1id > o3id, expr, self.ctx))
            preds.append((z3.Bool(str(o1min13) + "_eq_" + str(o3id), self.ctx), [o1min13, o3id], expr))
            expr = o1min23 == o2id
            preds.append((z3.Bool(str(o2id) + "_lteq_" + str(o3id), self.ctx), [o2id, o3id], o2id <= o3id))
            self.rel_init_exprs.append(z3.Implies(o2id <= o3id, expr, self.ctx))
            preds.append((z3.Bool(str(o1min23) + "_eq_" + str(o2id), self.ctx), [o1min23, o2id], expr))
            expr = o1min23 == o3id
            self.rel_init_exprs.append(z3.Implies(o2id > o3id, expr, self.ctx))
            preds.append((z3.Bool(str(o1min23) + "_eq_" + str(o3id), self.ctx), [o1min23, o3id], expr))
            expr = o1min123 == o1id
            preds.append((z3.Bool(str(o1id) + "_gteq_" + str(o1min23), self.ctx), [o1id, o1min23], o1id <= o1min23))
            self.rel_init_exprs.append(z3.Implies(o1id <= o1min23, expr, self.ctx))
            preds.append((z3.Bool(str(o1min123) + "_eq_" + str(o1id), self.ctx), [o1min123, o1id], expr))
            expr = o1min123 == o3id
            self.rel_init_exprs.append(z3.Implies(o1id > o1min23, expr, self.ctx))
            preds.append((z3.Bool(str(o1min123) + "_eq_" + str(o1min23), self.ctx), [o1min123, o1min23], expr))
        return preds

    def mk_preds_for_precondition(self):
        # 2 copies antisymmetry
        if self.prop_to_prove == 0:
            return self.mk_preds_for_pre_prop_0()
        # 2 copies deterministic
        if self.prop_to_prove == 1:
            return self.mk_preds_for_pre_prop_1()
        # 3 copies transitivity
        if self.prop_to_prove == 2:
            return self.mk_preds_for_pre_prop_2()
        # 3 copies nameless property
        if self.prop_to_prove == 3:
            return self.mk_preds_for_pre_prop_3()
        # 2 copies swap
        if self.prop_to_prove == 4:
            return self.mk_preds_for_pre_prop_4() + self.mk_preds_assume_swap_perm()
        # 2 copies swap
        if self.prop_to_prove == 5:
            return self.mk_preds_for_pre_prop_5() + self.mk_preds_assume_swap_perm()

    def add_memory_eq_predicate(self, first_entry, first_entry_copy, second_entry,
                                second_entry_copy):
        first_mem_name = str(self.entry_to_memory_map[first_entry]) + "_" + str(first_entry_copy)
        first_mem_var = None
        second_mem_name = str(self.entry_to_memory_map[second_entry]) + "_" + str(second_entry_copy)
        second_mem_var = None
        for v in self.copy_id_to_concrete_vars[first_entry_copy].values():
            if str(v) == first_mem_name:
                first_mem_var = v
                break

        for v in self.copy_id_to_concrete_vars[second_entry_copy].values():
            if str(v) == second_mem_name:
                second_mem_var = v
                break
        eq = first_mem_var == second_mem_var
        self.rel_init_exprs.append(eq)
        return (z3.Bool(first_mem_name + "_eq_" + second_mem_name, self.ctx), [first_mem_var, second_mem_var], eq)

    def mk_rel_bad(self):
        if self.prop_to_prove == 0:
            self.rel_bad = z3.Not(z3.Or(z3.And(self.ret_0 > 0, self.ret_1 < 0, self.ctx),
                                        z3.And(self.ret_0 < 0, self.ret_1 > 0, self.ctx),
                                        z3.And(self.ret_0 == 0, self.ret_1 == 0, self.ctx), self.ctx))
        if self.prop_to_prove == 1:
            self.rel_bad = z3.Not(z3.Or(z3.And(self.ret_0 > 0, self.ret_1 > 0, self.ctx),
                                        z3.And(self.ret_0 < 0, self.ret_1 < 0, self.ctx),
                                        z3.And(self.ret_0 == 0, self.ret_1 == 0, self.ctx), self.ctx))
        if self.prop_to_prove == 2:
            self.rel_bad = z3.And(self.ret_0 > 0, self.ret_1 > 0,self.ret_2 <= 0,self.ctx)
        if self.prop_to_prove == 3:
            self.rel_bad = z3.And(self.ret_0 == 0, z3.Not(
                z3.Or(z3.And(self.ret_1 > 0, self.ret_2 > 0, self.ctx),
                      z3.And(self.ret_1 < 0, self.ret_2 < 0, self.ctx),
                      z3.And(self.ret_1 == 0, self.ret_2 == 0, self.ctx), self.ctx)), self.ctx)
        if self.prop_to_prove == 4:
            self.rel_bad = z3.Not(self.ret_0 == self.ret_1)
        if self.prop_to_prove == 5:
            self.rel_bad = z3.Not(z3.And(self.ret_0 == self.ret_1, self.ret_0 == self.ret_2, self.ctx))
        return self.rel_bad

    def mk_neg_rel_bad_preds_0(self):
        return [(z3.Bool("sign(" + str(self.ret_0) + ")_eq_-sign(" + str(self.ret_1) + ")", self.ctx),
                 [self.ret_0, self.ret_1],
                 z3.Or(z3.And(self.ret_0 > 0, self.ret_1 < 0, self.ctx),
                       z3.And(self.ret_0 < 0, self.ret_1 > 0, self.ctx),
                       z3.And(self.ret_0 == 0, self.ret_1 == 0, self.ctx), self.ctx))]

    def mk_neg_rel_bad_preds_1(self):
        return [(z3.Bool("sign(" + str(self.ret_0) + ")_eq_sign(" + str(self.ret_1) + ")", self.ctx),
                 [self.ret_0, self.ret_1],
                 z3.Or(z3.And(self.ret_0 > 0, self.ret_1 > 0, self.ctx),
                       z3.And(self.ret_0 < 0, self.ret_1 < 0, self.ctx),
                       z3.And(self.ret_0 == 0, self.ret_1 == 0, self.ctx), self.ctx))]

    def mk_neg_rel_bad_preds_2(self):
        return [#(
            # z3.Bool(str(self.ret_0) + "_gt_0_And_" + str(self.ret_1) + "_gt_0_Imp_" + str(self.ret_2) + "_gt_0",
            #         self.ctx),
            # [self.ret_0, self.ret_1, self.ret_2],
            # z3.Implies(z3.And(self.ret_0 > 0, self.ret_1 > 0, self.ctx), self.ret_2 > 0, self.ctx)),
            (z3.Bool(str(self.ret_0) + "_gt_0",
                     self.ctx),
             [self.ret_0],
             self.ret_0 > 0),
            (z3.Bool(str(self.ret_1) + "_gt_0",
                     self.ctx),
             [self.ret_1],
             self.ret_1 > 0),
            (z3.Bool(str(self.ret_2) + "_gt_0",
                     self.ctx),
             [self.ret_2],
             self.ret_2 > 0)
        ]

    def mk_neg_rel_bad_preds_3(self):
        sign_eq = z3.Or(z3.And(self.ret_1 > 0, self.ret_2 > 0, self.ctx),
                        z3.And(self.ret_1 < 0, self.ret_2 < 0, self.ctx),
                        z3.And(self.ret_1 == 0, self.ret_2 == 0, self.ctx), self.ctx)
        return [(
            z3.Bool(str(self.ret_0) + "_eq_0_Imp_sign(" + str(self.ret_1) + ")_eq_sign(" + str(self.ret_2) + ")",
                    self.ctx),
            [self.ret_0, self.ret_1, self.ret_2],
            z3.Implies(self.ret_0 == 0, sign_eq, self.ctx)),
            (z3.Bool(str(self.ret_0) + "_eq_0",
                     self.ctx),
             [self.ret_0],
             self.ret_0 == 0),
            (z3.Bool(str(self.ret_1) + "_gt_0",
                     self.ctx),
             [self.ret_1],
             self.ret_1 > 0),
            (z3.Bool(str(self.ret_2) + "_gt_0",
                     self.ctx),
             [self.ret_2],
             self.ret_2 > 0),
            (z3.Bool(str(self.ret_1) + "_eq_0",
                     self.ctx),
             [self.ret_1],
             self.ret_1 == 0),
            (z3.Bool(str(self.ret_2) + "_eq_0",
                     self.ctx),
             [self.ret_2],
             self.ret_2 == 0)
        ]

    def mk_neg_rel_bad_preds_4(self):
        return [(
            z3.Bool(str(self.ret_0) + "_eq_" + str(self.ret_1),
                    self.ctx),
            [self.ret_0, self.ret_1],
            self.ret_0 == self.ret_1)
        ]

    def mk_neg_rel_bad_preds_5(self):
        return [(
            z3.Bool(str(self.ret_0) + "_eq_" + str(self.ret_1),
                    self.ctx),
            [self.ret_0, self.ret_1],
            self.ret_0 == self.ret_1),
            (
                z3.Bool(str(self.ret_0) + "_eq_" + str(self.ret_2),
                        self.ctx),
                [self.ret_0, self.ret_2],
                self.ret_0 == self.ret_2)
        ]

    def mk_ret_vars(self):
        for v in self.concrete_vars:
            if self.ret_var_name + "_0" == str(v):
                self.ret_0 = v
            if self.ret_var_name + "_1" == str(v):
                self.ret_1 = v
            if self.ret_var_name + "_2" == str(v):
                self.ret_2 = v

    def mk_neg_rel_bad_pred(self):
        if self.prop_to_prove == 0:
            return self.mk_neg_rel_bad_preds_0()
        if self.prop_to_prove == 1:
            return self.mk_neg_rel_bad_preds_1()
        if self.prop_to_prove == 2:
            return self.mk_neg_rel_bad_preds_2()
        if self.prop_to_prove == 3:
            return self.mk_neg_rel_bad_preds_3()
        if self.prop_to_prove == 4:
            return self.mk_neg_rel_bad_preds_4()
        if self.prop_to_prove == 5:
            return self.mk_neg_rel_bad_preds_5()

    def set_exits(self, exit_tuples):
        self.exits = []
        # ignore head which is the compare relation and use bodies for the Bad rule
        for head, body, xs, xps in exit_tuples:
            for i in range(self.k):
                exit_body = z3.substitute(body, self.get_copy_vars_subts(xs, i, False))
                self.exits.append(exit_body)
        temp_exits = list(self.exits)
        temp_exits.append(self.ctx)
        self.all_end = z3.And(*temp_exits)

    def set_trs(self, tr_tuples, inv_varsp):
        self.set_vars_to_varsp(inv_varsp)
        self.trs = {}
        first_time = len(self.concrete_vars) == 0
        for i in range(self.k):
            tr_list = []

            for tr_cond, xs, xps in tr_tuples:
                const = self.get_varp_constraints(xs, xps, inv_varsp)
                copy_vars_subts = self.get_copy_vars_subts(xs + list(inv_varsp.values()), i, first_time)

                sc_vs = [sc_v for v, sc_v in copy_vars_subts]
                self.declared_vars.extend(sc_vs)

                curr_tr = z3.substitute(z3.And(tr_cond, const, self.ctx) if const is not None else tr_cond,
                                        copy_vars_subts)
                tr_list.append(curr_tr)
            if len(tr_list) == 1:
                self.trs[i] = tr_list[0]
            else:
                tr_list.append(self.ctx)
                self.trs[i] = z3.Or(*tr_list)

    def set_vars_to_varsp(self, inv_varsp):
        self.concrete_var_to_varp = {}
        for x, xp in inv_varsp.items():
            self.concrete_var_to_varp[str(x)] = xp

    def get_varp_constraints(self, xs, xps, inv_varsp):
        fml = None
        xps_names = [str(v) for v in xps]
        # if primed var is not in the formula then add var=varp
        for v, vp in inv_varsp.items():
            if str(vp) not in xps_names:
                if fml is None:
                    fml = v == vp
                else:
                    fml = z3.And(fml, v == vp, self.ctx)
        return fml

    def mk_inv(self, inv_vars, inv_varsp):
        self.num_of_vars_single_copy = len(inv_vars)
        sig = [z3.IntSort(self.ctx)]  # for composition variable
        for i in range(self.k):
            for v in inv_vars:
                sig.append(v.sort())
        sig.append(z3.BoolSort(self.ctx))
        inv = z3.Function("Inv", *sig)
        self.Inv = inv
        duplicated_vars = []
        for i in range(self.k):
            duplicated_vars.extend([vi for v, vi in self.get_copy_vars_subts(inv_vars, i, False)])
        self.declared_vars.extend(duplicated_vars)
        self.inv_vars = self.extend_with_composition_var(duplicated_vars)
        self.inv_relation = self.Inv(*self.inv_vars)

        duplicated_vars = []
        for i in range(self.k):
            duplicated_vars.extend(
                [vi for v, vi in self.get_copy_vars_subts(self.extend_inv_varsp(inv_vars, inv_varsp), i, False)])
        self.declared_vars.extend(duplicated_vars)
        self.inv_varsp = self.extend_with_compositionp_var(duplicated_vars)
        return inv

    def mk_pred_abstraction_inv(self, concrete_inv_varsp_map, concrete_array_vars=None):
        #print("Batch 3 : mk_pred_abs_inv method")
        self.num_of_preds_single_copy = len(self.predicate_tuples)
        sig = [z3.IntSort(self.ctx)]  # for composition variable
        self.concrete_array_vars = concrete_array_vars
        for i in range(self.k):
            if self.has_pc:
                sig.append(z3.IntSort(self.ctx))  # for pc of that copy
            if concrete_array_vars is not None and len(concrete_array_vars) > 0:
                sig.extend([v.sort() for v in concrete_array_vars])
            sig.extend([z3.BoolSort(self.ctx)] * len(self.predicate_tuples))
        sig.extend([z3.BoolSort(self.ctx)] * len(self.rel_predicate_tuples))
        sig.append(z3.BoolSort(self.ctx))
        if concrete_array_vars is not None and len(concrete_array_vars) > 0:
            self.compute_array_indices(sig, concrete_array_vars[0].sort())
        inv = z3.Function("Inv", *sig)
        self.Inv = inv
        duplicated_preds = []
        self.inv_vars = [self.composition_var]
        for i in range(self.k):
            duplicated_preds_i = self.get_copy_abstract_vars(i)
            duplicated_preds.extend(duplicated_preds_i)
            if self.has_pc:
                self.inv_vars.append(self.get_pc_of_copy(i))
            if concrete_array_vars is not None and len(concrete_array_vars) > 0:
                self.inv_vars.extend([subst[1] for subst in self.get_copy_vars_subts(concrete_array_vars, i)])
            self.inv_vars.extend(duplicated_preds_i)
        rel_preds_vars = [rel_pred for rel_pred, xs, fml in self.rel_predicate_tuples]
        self.inv_vars.extend(rel_preds_vars)
        #batch 3 : predicates
        self.predicates = self.predicates + duplicated_preds
        #print("predicates:",self.predicates)


        self.declared_vars.extend(duplicated_preds + rel_preds_vars)
        self.inv_relation = self.Inv(*self.inv_vars)
        self.abstract_var_names = [str(v) for v in (duplicated_preds + rel_preds_vars)]

        duplicated_preds_p = []
        self.inv_varsp = [self.composition_var_p]
        for i in range(self.k):
            if self.has_pc:
                self.inv_varsp.append(self.get_pcp_of_copy(i))
            if concrete_array_vars is not None and len(concrete_array_vars) > 0:
                self.inv_varsp.extend([vi for v, vi in self.get_copy_vars_subts(
                    [v for k, v in concrete_inv_varsp_map.items() if k.sort() == concrete_array_vars[0].sort()], i)])
            self.inv_varsp.extend(
                self.mk_primed_predicates(concrete_inv_varsp_map, self.copy_id_to_predicate_tuples[i]))
        self.declared_vars.extend(duplicated_preds_p)
        #print('suplicated_preds_p',duplicated_preds_p)
        self.abstract_var_to_cond_tuples.extend([(pred, cond) for pred, xs, cond in self.rel_predicate_tuples])
        #print('self.abstract_var_to_cond_tuples',self.abstract_var_to_cond_tuples)
        self.inv_varsp.extend(self.mk_primed_predicates(concrete_inv_varsp_map, self.rel_predicate_tuples))

        return inv

    def mk_primed_predicates(self, concrete_inv_varsp_map, predicate_tuples):
        primed = []
        for pred, xs, fml in predicate_tuples:
            pred_p = z3.Bool(str(pred) + "p", self.ctx)
            xs_to_xps = [(x, self.get_var_p_for_duplicated_var(x, concrete_inv_varsp_map)) for x in xs]
            fml = z3.substitute(fml, xs_to_xps)
            xps = [xp for x, xp in xs_to_xps]
            tuple = (pred_p, xps, fml)
            primed.append(tuple)
        #print('primed pr',primed)
        predicate_tuples.extend(primed)
        self.abstract_var_p_to_cond_tuples.extend([(pred, cond) for pred, xs, cond in primed])
        preds = [pred for pred, xs, fml in primed]
        #print('preds',preds)
        self.declared_vars.extend(preds)
        return preds

    def get_pcp_of_copy(self, copy_id):
        for v in self.copy_id_to_concrete_vars[copy_id].values():
            if str(v) == "pc_p_" + str(copy_id):
                return v

    def get_pc_of_copy(self, copy_id):
        for v in self.copy_id_to_concrete_vars[copy_id].values():
            if str(v) == "pc_" + str(copy_id):
                return v

    def extend_inv_varsp(self, inv_vars, inv_varsp):
        ret = []
        for v in inv_vars:
            if v in inv_varsp:
                ret.append(inv_varsp[v])
            else:
                ret.append(v)
        return ret

    def mk_bad_rel(self):
        self.Bad = z3.Const('Bad', z3.BoolSort(self.ctx))
        return self.Bad

    def get_bad(self):
        return self.Bad

    def get_bad_declaration(self):
        return self.bad_decl

    def get_rules(self):
        rules = []
        rules.append(self.init_rule)
        rules.append(self.sc_tr_rule)
        rules.append(self.bad_rule)
        return rules

    def get_inv_declaration(self):
        return self.inv_relation.decl()

    def get_inv_relation(self):
        # this should be the signature of Inv applied on variables declaration
        return self.inv_relation

    def get_vars_to_declare(self):
        return self.declared_vars + self.quantified_vars

    def extend_with_composition_var(self, inv_vars):
        ret = [self.composition_var]
        ret.extend(inv_vars)
        return ret

    def extend_with_compositionp_var(self, inv_vars):
        ret = [self.composition_var_p]
        ret.extend(inv_vars)
        return ret

    def extend_inv_vars_p(self, inv_vars_p):
        ret = [self.composition_var_p]
        ret.extend(inv_vars_p)
        return ret

    def mk_init_rule(self):
        #print("Batch 1 : enters mk_init_rule")
        #print('mk-init,1,self.inits ',self.inits)
        temp = list(self.inits)
        #print('mk-init,2,self.rel_init',self.rel_init)
        temp.append(self.rel_init)
        #print('mk-init,3')
        if self.predicate_tuples is not None:
            #print('mk-init,4')
            temp.append(self.mk_h())
            #rint('mk-init,5')
        temp.append(self.ctx)
        #print('mk-init,6')
        left = z3.And(*temp)
        #print('mk-init,7')
        right = self.inv_relation
        #print('mk-init,8')
        self.init_rule = z3.Implies(left, right)
        #print('mk-init,9')
        #batch 1 : init_condition
        temp2 = list(self.inits)
        #print('mk-init,10')
        temp2.append(self.rel_init)
        #print('mk-init,11')
        temp2.append(self.ctx)
        #print('mk-init,12')
        self.init_condition = z3.And(*temp2)
        
        #print('mk-init,13,self.init_rule',len(str(self.init_rule)),self.init_rule)
        #print('\n init_condition',self.init_condition)

        return self.init_rule

    def mk_bad_rule(self):
        #print("Batch 2 : enteres mk_bad_rule")
        if self.rel_bad is None:
            self.rel_bad = self.mk_rel_bad()
        bad_left = z3.And(self.all_end, self.rel_bad,
                          self.ctx)
        for ext in self.bad_extensions:

            bad_left = z3.Or(ext, bad_left, self.ctx)

        #batch 2 : bad_condition
        self.bad_condition = bad_left

        #print("bad_condition",self.bad_condition)

        if  self.first_time == True:
            original_bad_left = z3.And(self.all_end, self.rel_bad,
                              self.ctx)
            for ext in self.bad_extensions:
                original_bad_left = z3.Or(ext, original_bad_left, self.ctx)
            self.original_bad_cond = original_bad_left
            self.first_time = False
        #print('mk-bad,1')
        if self.predicate_tuples is not None:
            bad_left = z3.And(self.inv_relation, self.mk_h(), bad_left, self.ctx)
            #print('mk-bad,2')
        else:
            bad_left = z3.And(self.inv_relation, bad_left, self.ctx)
            #print('mk-bad,3')

        self.bad_rule = z3.Implies(bad_left, self.Bad, self.ctx)
        #print('mk-bad,4',self.bad_rule)
        return self.bad_rule

    def get_all_end(self):
        return self.all_end

    def mk_tr_rule(self):
        #print('mk_tr_rule_1')
        left_inv = self.inv_relation
        #print('mk_tr_rule_2')
        right_inv = self.Inv(*self.inv_varsp)
        #print('mk_tr_rule_3')
        sc_tr = self.mk_sc_tr()
        #print('mk_tr_rule_4')
        for block_expr in self.blocked_exprs:
            #print('mk_tr_rule_5')
            sc_tr = z3.And(block_expr, sc_tr, self.ctx)
        #print('mk_tr_rule_6')
        if self.predicate_tuples is not None:
            #print('mk_tr_rule_7')
            left = z3.And(left_inv, self.mk_h(), sc_tr, self.mk_h_p(), self.ctx)
            #print('mk_tr_rule_8')
        else:
            #print('mk_tr_rule_9')
            left = z3.And(left_inv, sc_tr, self.ctx)
            #print('mk_tr_rule_10')
        #print('mk_tr_rule_11')
        self.sc_tr_rule = z3.Implies(left, right_inv, self.ctx)
        #print('mk_tr_rule',self.sc_tr_rule)
        return self.sc_tr_rule

    def mk_sc_tr(self):
        self.update_trs_with_self_loop()
        if self.sc_tr is None:
            if self.default_composition:
                if self.k == 2:
                    self.sc_tr = z3.And(self.trs[0], self.trs[1],
                                        self.ctx)
                if self.k == 3:
                    self.sc_tr = z3.And(self.trs[0], self.trs[1], self.trs[2],
                                        self.ctx)
            else:
                if self.k == 2:
                    # array_insert2 composition
                    # pc0 = self.get_concrete_var_by_name("pc_0")
                    # pc1 = self.get_concrete_var_by_name("pc_1")
                    # i0 = self.get_concrete_var_by_name("i_0")
                    # i1 = self.get_concrete_var_by_name("i_1")
                    # len0 = self.get_concrete_var_by_name("len_0")
                    # len1 = self.get_concrete_var_by_name("len_1")
                    # h0 = self.get_concrete_var_by_name("h_0")
                    # h1 = self.get_concrete_var_by_name("h_1")
                    # array0 = self.get_concrete_var_by_name("array_0")
                    # array1 = self.get_concrete_var_by_name("array_1")
                    # copy0_cond = z3.And(pc0<3,z3.Or(pc0!=0,z3.Or(i0==len0-1,h0>=z3.Select(array0,i0),self.ctx),self.ctx), z3.Or(z3.And(pc1==0,i1!=len1-1,h1<z3.Select(array1,i1),self.ctx),pc1==3,self.ctx),self.ctx)
                    # copy1_cond = z3.And(pc1<3,z3.Or(pc1!=0,z3.Or(i1==len1-1,h1>=z3.Select(array1,i1),self.ctx),self.ctx), z3.Or(z3.And(pc0==0,i0!=len0-1,h0<z3.Select(array0,i0),self.ctx),pc0==3,self.ctx),self.ctx)
                    # copy0 = z3.And(copy0_cond,self.trs[0], self.mk_self_loop(1), self.ctx)
                    # copy1 = z3.And(copy1_cond,self.trs[1], self.mk_self_loop(0), self.ctx)
                    # both = z3.And(z3.Not(copy0_cond),z3.Not(copy1_cond),self.trs[0],self.trs[1], self.ctx)
                    # gcd composition
                    # a_0 = self.get_concrete_var_by_name("a_0")
                    # a_1 = self.get_concrete_var_by_name("a_1")
                    # b_0 = self.get_concrete_var_by_name("b_0")
                    # copy0 = False
                    # copy1 = z3.And(a_0==a_1-b_0,self.trs[1], self.mk_self_loop(0), self.ctx)
                    # both = z3.And(z3.Not(a_0==a_1-b_0),self.trs[0],self.trs[1], self.ctx)
                    # array_insert composition
                    # pc0 = self.get_concrete_var_by_name("pc_0")
                    # pc1 = self.get_concrete_var_by_name("pc_1")
                    # i0 = self.get_concrete_var_by_name("i_0")
                    # i1 = self.get_concrete_var_by_name("i_1")
                    # len0 = self.get_concrete_var_by_name("len_0")
                    # len1 = self.get_concrete_var_by_name("len_1")
                    # h0 = self.get_concrete_var_by_name("h_0")
                    # h1 = self.get_concrete_var_by_name("h_1")
                    # array0 = self.get_concrete_var_by_name("array_0")
                    # array1 = self.get_concrete_var_by_name("array_1")
                    # copy0_cond = z3.And(pc0<3,z3.Or(pc0>0,z3.Or(i0>=len0,h0>=z3.Select(array0,i0),self.ctx),self.ctx), z3.Or(z3.And(pc1==0,i1<len1,h1<z3.Select(array1,i1),self.ctx),pc1==3,self.ctx),self.ctx)
                    # copy1_cond = z3.And(pc1<3,z3.Or(pc1>0,z3.Or(i1>=len1,h1>=z3.Select(array1,i1),self.ctx),self.ctx), z3.Or(z3.And(pc0==0,i0<len0,h0<z3.Select(array0,i0),self.ctx),pc0==3,self.ctx),self.ctx)
                    # copy0 = z3.And(copy0_cond,self.trs[0], self.mk_self_loop(1), self.ctx)
                    # copy1 = z3.And(copy1_cond,self.trs[1], self.mk_self_loop(0), self.ctx)
                    # both = z3.And(z3.Not(copy0_cond),z3.Not(copy1_cond),self.trs[0],self.trs[1], self.ctx)
                    # 2loops_pc composition
                    # pc0 = self.get_concrete_var_by_name("pc_0")
                    # pc1 = self.get_concrete_var_by_name("pc_1")
                    # copy0_cond = z3.And(pc0==1, z3.Or(pc1==0,pc1==2,self.ctx),self.ctx)
                    # copy1_cond = z3.And(pc1==1, z3.Or(pc0==0,pc0==2,self.ctx),self.ctx)
                    # copy0 = z3.And(copy0_cond,self.trs[0], self.mk_self_loop(1), self.ctx)
                    # copy1 = z3.And(copy1_cond,self.trs[1], self.mk_self_loop(0), self.ctx)
                    # both = z3.And(z3.Not(z3.Or(copy0_cond,copy1_cond,self.ctx)),self.trs[0],self.trs[1], self.ctx)
                    # squares sum composition
                    # a_0 = self.get_concrete_var_by_name("a_0")
                    # a_1 = self.get_concrete_var_by_name("a_1")
                    # copy0 = z3.And(a_0<a_1,self.trs[0], self.mk_self_loop(1), self.ctx)
                    # copy1 = False
                    # both = z3.And(z3.Not(a_0<a_1),self.trs[0],self.trs[1], self.ctx)
                    # shared array composition
                    # pc_0 = self.get_concrete_var_by_name("pc_0")
                    # pc_1 = self.get_concrete_var_by_name("pc_1")
                    # curr_0 = self.get_concrete_var_by_name("curr_0")
                    # toInsert_0 = self.get_concrete_var_by_name("toInsert_0")
                    # len_0 = self.get_concrete_var_by_name("len_0")
                    # j_0 = self.get_concrete_var_by_name("j_0")
                    # curr_1 = self.get_concrete_var_by_name("curr_1")
                    # toInsert_1 = self.get_concrete_var_by_name("toInsert_1")
                    # len_1 = self.get_concrete_var_by_name("len_1")
                    # j_1 = self.get_concrete_var_by_name("j_1")
                    # cond_0 = z3.And(pc_0 == 0,z3.Not(z3.And(curr_0 < toInsert_0, j_0 < len_0,self.ctx)),pc_1 == 0, curr_1 < toInsert_1, j_1 < len_1,self.ctx)
                    # cond_1 = z3.And(pc_1 == 0, z3.Not(z3.And(curr_1 < toInsert_1, j_1 < len_1, self.ctx)), pc_0 == 0,
                    #                 curr_0 < toInsert_0, j_0 < len_0, self.ctx)
                    # move_0 = z3.Or(z3.And(pc_0 == 1, pc_1 != 1,self.ctx),cond_0,self.ctx)
                    # move_1 = z3.Or(z3.And(pc_1 == 1, pc_0 != 1, self.ctx),cond_1,self.ctx)
                    #
                    # copy0 = z3.And(move_0, self.trs[0],
                    #                self.mk_self_loop(1), self.ctx)
                    # copy1 = z3.And(move_1, self.trs[1],
                    #                self.mk_self_loop(0), self.ctx)
                    # both = z3.And(z3.And(z3.Not(move_0), z3.Not(move_1), self.ctx), self.trs[0], self.trs[1],
                    #               self.ctx)
                    copy0 = z3.And(self.composition_var == 0, self.trs[0],
                                   self.mk_self_loop(1), self.ctx)
                    self.copy_0 = z3.And(self.trs[0],self.mk_self_loop(1), self.ctx)
                    #print('tr0',self.copy_0)
                    copy1 = z3.And(self.composition_var == 1, self.trs[1],
                                   self.mk_self_loop(0), self.ctx)
                    self.copy_1 = z3.And(self.trs[1],self.mk_self_loop(0), self.ctx)
                    #print('tr1',self.copy_1)
                    both = z3.And(self.composition_var == 2, self.trs[0], self.trs[1],
                                  self.ctx)
                    self.copy_2 = z3.And(self.trs[0], self.trs[1],self.ctx)
                    #print('tr2',self.copy_2)
                    self.sc_tr = z3.Or(copy0, copy1, both, self.ctx)
                    if self.use_explicit_conposition_function:
                        self.sc_tr = z3.And(self.composition_var == self.composition_func.as_formula(), self.sc_tr,self.ctx)
                if self.k == 3:  # bitwise its cpoy2|copy1|copy0
                    copy0 = z3.And(self.composition_var == 1, self.trs[0],
                                   self.mk_self_loop(1), self.mk_self_loop(2), self.ctx)
                    self.copy1 = z3.And(self.trs[0],self.mk_self_loop(1), self.mk_self_loop(2), self.ctx)
                    copy1 = z3.And(self.composition_var == 2, self.trs[1],
                                   self.mk_self_loop(0), self.mk_self_loop(2), self.ctx)
                    self.copy2 = z3.And( self.trs[1], self.mk_self_loop(0), self.mk_self_loop(2), self.ctx)
                    copy2 = z3.And(self.composition_var == 4, self.trs[2],
                                   self.mk_self_loop(0), self.mk_self_loop(1), self.ctx)
                    self.copy4 = z3.And(self.trs[2],self.mk_self_loop(0), self.mk_self_loop(1), self.ctx)
                    copies01 = z3.And(self.composition_var == 3, self.trs[0], self.trs[1],
                                      self.mk_self_loop(2), self.ctx)
                    self.copy3 = z3.And(self.trs[0], self.trs[1],self.mk_self_loop(2), self.ctx)
                    copies12 = z3.And(self.composition_var == 6, self.trs[1], self.trs[2],
                                      self.mk_self_loop(0), self.ctx)
                    self.copy6 =  z3.And(self.trs[1], self.trs[2],self.mk_self_loop(0), self.ctx)
                    copies02 = z3.And(self.composition_var == 5, self.trs[0], self.trs[2],
                                      self.mk_self_loop(1), self.ctx)
                    self.copy5 = z3.And(self.trs[0], self.trs[2],self.mk_self_loop(1), self.ctx)
                    all_copies = z3.And(self.composition_var == 7, self.trs[0], self.trs[1], self.trs[2],
                                        self.ctx)
                    self.copy7 = z3.And(self.trs[0], self.trs[1], self.trs[2],self.ctx)
                    self.sc_tr = z3.Or(copy0, copy1, copy2, copies01, copies12, copies02, all_copies, self.ctx)
                    if self.use_explicit_conposition_function:
                        self.sc_tr = z3.And(self.composition_var == self.composition_func.as_formula(), self.sc_tr,
                                            self.ctx)
        return self.sc_tr

    def update_trs_with_self_loop(self):
        if not self.updated_trs_self_loop:
            for i in range(0, self.k):
                loop = self.mk_self_loop(i)
                self.trs[i] = z3.Or(self.trs[i], z3.And(loop, self.exits[i], self.ctx), self.ctx)
            self.updated_trs_self_loop = True

    def mk_self_loop(self, copy_index):
        if self.loops is None:
            self.loops = {}
            if not self.is_predicate_abstraction:
                for i in range(0, self.k):
                    loop_exprs = []
                    j = self.num_of_vars_single_copy * i + 1
                    while j < self.num_of_vars_single_copy * (i + 1) + 1:
                        v = self.inv_vars[j]
                        vp = self.inv_varsp[j]
                        j += 1
                        if str(v) != str(vp):
                            loop_exprs.append(v == vp)
                    loop_exprs.append(self.ctx)
                    self.loops[i] = z3.And(*loop_exprs)
            else:
                for i in range(0, self.k):
                    loop_exprs = []
                    for v_name, vp in self.concrete_var_to_varp.items():
                        v = self.get_concrete_by_name(v_name + "_" + str(i), i)
                        vp = self.get_concrete_by_name(str(vp) + "_" + str(i), i)
                        loop_exprs.append(v == vp)
                    loop_exprs.append(self.ctx)
                    self.loops[i] = z3.And(*loop_exprs)
        return self.loops[copy_index]

    def get_concrete_by_name(self, name, copy_id):
        for v in self.copy_id_to_concrete_vars[copy_id].values():
            if str(v) == name:
                return v

    def set_rel_bad(self, rel_bad):
        self.rel_bad = rel_bad

    def block_assignment(self, state, composition):
        self.blocked_exprs.append(
            z3.Not(z3.And(self.abstract_state_to_cond(state), self.composition_var == composition, self.ctx)))

    def change_assignment(self, state, composition):
        self.composition_func.change_next_step(state, composition)

    def abstract_state_to_cond(self, state):
        #print('state : ',state,type(state))
        conjuncts = []
        i = 0
        pc_indices = self.get_pc_indices()
        #print('pc_indices : ',pc_indices)
        copy_id = 0
        while i < len(state.values):
            if i in pc_indices:
                conjuncts.append(self.get_pc_of_copy(copy_id) == state.values[i])
                copy_id += 1
            elif state.values[i]:
                conjuncts.append(self.abstract_var_to_cond_tuples[(i - copy_id) if self.has_pc else i][1])
            else:
                conjuncts.append(z3.Not(self.abstract_var_to_cond_tuples[(i - copy_id) if self.has_pc else i][1]))
            i += 1
        conjuncts.append(self.ctx)
        return z3.And(*conjuncts)

    def extend_bad(self, state):
        if self.use_explicit_conposition_function:
            self.composition_func.remove_stete(state)
        self.bad_extensions.append(self.abstract_state_to_cond(state))

    def mk_h(self):
        if self.h is None:
            conjuncts = [pred_var == (cond) for (pred_var, cond) in self.abstract_var_to_cond_tuples]
            conjuncts.append(self.ctx)
            self.h = z3.And(*conjuncts)
        return self.h

    def mk_h_p(self):
        if self.h_p is None:
            conjuncts = [pred_var_p == (cond) for (pred_var_p, cond) in self.abstract_var_p_to_cond_tuples]
            conjuncts.append(self.ctx)
            self.h_p = z3.And(*conjuncts)
        #print(self.h_p)

        return self.h_p

    def subst_predicates(self, expr):
        return z3.substitute(expr, self.abstract_var_to_cond_tuples)

    def abstract_state_from_z3_state(self, z3_state):
        if self.is_predicate_abstraction:
            i = 1
            arr = []
            pc_indices = [x + 1 for x in self.get_pc_indices()]
            #print('pc_indices',pc_indices)
            #print(self.concrete_array_indices)
            while i < len(z3_state.children()):
                #print(i)

                if i in pc_indices:  # skip pc variables
                    arr.append(z3_state.arg(i).as_long())
                elif i not in self.concrete_array_indices:
                    #print(arr,z3_state.arg(i),z3.is_true(z3_state.arg(i)))
                    arr.append(z3.is_true(z3_state.arg(i)))
                i += 1
        else:
            i = 1
            arr = []
            while i < len(z3_state.children()):
                v = z3_state.arg(i)
                arr.append(v.as_long() if z3.is_int(v) else str(v) if z3.is_array(v) else z3.is_true(v))
                i += 1
        return AbstractState(arr)

    def abstract_st_from_z3_st(self, z3_state):
        if self.is_predicate_abstraction:
            i = 0
            arr = []

            while i < len(z3_state.children()):
                #print(i)
                #print(arr,z3_state.arg(i),z3.is_true(z3_state.arg(i)))
                if not(str(z3_state.arg(i))[0:4].find('Not') == -1):
                    arr.append(False)
                else:
                    arr.append(True)
                i += 1
        else:
            exit()
        return AbstractState(arr)

    def mk_dynamic_rules(self):
        #print('dp-dyn-rules,1')
        self.mk_tr_rule()
        #print('dp-dyn-rules,2')
        self.mk_bad_rule()
        #print('dp-dyn-rules,3')


    def is_predicate_abstraction(self):
        return self.is_predicate_abstraction

    def get_pc_indices(self):
        return [x * (1 + len(self.predicate_tuples)) for x in range(self.k)] if self.has_pc else []

    def compute_array_indices(self, sig, arr_sort):
        i = 0
        for sort in sig:
            if sort == arr_sort:
                self.concrete_array_indices.append(i)
            i += 1


class AbstractState:
    def __init__(self, values):
        self.values = values

    def __eq__(self, other):
        if not isinstance(other, AbstractState):
            return False
        return self.values == other.values

    def __hash__(self):
        h = 1
        for val in self.values:
            h *= 10
            if val:
                h += 1
        return h

    def pretty_print(self, dynamic_program):
        if dynamic_program.is_predicate_abstraction:
            names = dynamic_program.abstract_var_names
            s = "["
            i = 0
            copy_id = 0
            pred_names_index = 0
            pc_indices = dynamic_program.get_pc_indices()
            #print('names',names)
            #print('self.values',self.values)
            while i < len(self.values):
                if i in pc_indices:  # pc variables
                    s += "pc_" + str(copy_id) + "=" + str(self.values[i]) + ", "
                    copy_id += 1
                else:
                    if self.values[i]:
                        s += names[pred_names_index] + ", "
                    pred_names_index += 1
                i += 1
                if i < len(self.values) and self.values[i]:
                    s += "\n"
            s += "]\n"
        else:
            names = [str(v) for v in dynamic_program.inv_vars[1:]]
            #print('2. names',names)
            #print('2. self.values',self.values)
            s = "["
            i = 0
            while i < len(self.values):
                s += names[i] + "=" + str(self.values[i]) + ", "
                i += 1
                if i < len(self.values):
                    s += "\n"
            s += "]\n"
        return s
