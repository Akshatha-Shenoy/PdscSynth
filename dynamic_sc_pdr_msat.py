import z3
import os
import re
import z3.z3printer
import time
from Let_Eliminator import LetEliminatorClass
from bitstring import BitArray
from comparator_program_transformer import comparator_transform
from program_transformer import transform
from pathlib import Path
#from dynamic_sc_pdr_qe import DynamicSelfCompositionPDR_qe


class DynamicSelfCompositionPDR_msat:
    def __init__(self, program_path, force_predicate_abstraction, is_comparator, explicit_conposition_function,
                 folder_name, method_name=None, concrete_array_vars=False, bmc=False, print_log=False, prop=None):
        if prop is not None and prop == 1:
            prop = 0
        self.trc = None
        self.force_predicate_abstraction = force_predicate_abstraction
        self.bmc = bmc
        self.concrete_dp = None
        self.dynamic_program = self.sc_program_from_file(program_path, is_comparator, method_name, concrete_array_vars,                                                         prop)
        self.dynamic_program.use_explicit_conposition_function = explicit_conposition_function
        self.ctx = self.dynamic_program.ctx
        self.smt_queries_count = 0
        self.lemmas = {}
        self.fp = None
        self.blocked_compositions = {}
        self.longest_abstract_trace = 0
        self.print_log = print_log
        self.cex_trace_states = []
        self.pred_string_dict = dict()
        # list of trace's second coordinates which specify composition = 0,1,2 for its corresponding first coord state
        self.trace_second_coord = []
        # counts the number of preds added
        self.num_new_preds = None
        self.new_pred_smt_format = None
        self.dict_in_order = dict()
        self.list_types = []
        self.list_vars = []

        self.reason_to_add_to_bad = dict()
        self.vars_in_c_src = dict()
        self.vars_in_c_src_p = dict()
        # self.vars_in_c_src_p = dict()
        # program path added as a field
        self.program_path = program_path
        self.pred_meaning = dict()
        self.pred_meaning_p = dict()
        # folder containing temporary files produced by the execution
        self.folder_name = str(folder_name)
        # print("folder_name",self.folder_name)
        # print('folder',type((str(self.folder_name))[4:((str(self.folder_name)).find('_qe_'))]))
        self.i_fname = (str(self.folder_name))[4:((str(self.folder_name)).find('_qe_'))]
        self.i_folder_path = str(Path.cwd()) + "/" + str("interpolants") + "/"
        self.folder_path = str(Path.cwd()) + "/" + str(self.folder_name) + "/"
        # print("folder_path",self.folder_path)
        print((self.dynamic_program.h).sexpr())

    def solve(self, num_new_preds):
        self.get_dict()
        for var in self.dict_in_order:
            self.list_types.append(self.dict_in_order[var])
            self.list_vars.append(var)
        self.num_new_preds = num_new_preds
        num_preds = len(self.dynamic_program.abstract_var_names) if self.dynamic_program.is_predicate_abstraction else 0
        timeout = time.time() + 15
        trace = self.find_cex()
        if not (trace == None):
            self.trc = trace
        # batch 6 : pred_string_dict
        for l in self.dynamic_program.predicates:
            self.pred_string_dict[str(l)] = l
        self.compute_vars_in_c_src()
        self.compute_pred_meaning()
        while trace is not None:
            print("Counter-example trace:\n" + self.print_trace(trace))
            # batch 5 : cex_trace_states
            self.update_cex_trace_states(trace)
            if self.bmc and self.longest_abstract_trace == 0 and len(trace) < 4 and self.dynamic_program.k == 3:
                self.longest_abstract_trace = len(trace)
                if self.print_log:
                    print("running bmc of depth " + str(self.longest_abstract_trace))
                if self.run_bmc():
                    return "Counter-example found. Property is violated.", self.smt_queries_count, num_preds
            if not self.dynamic_program.is_predicate_abstraction:
                # print('solve,9')
                return "Counter-example found. Property is violated.", self.smt_queries_count, num_preds
            if self.dynamic_program.default_composition:
                self.dynamic_program.default_composition = False
                self.dynamic_program.sc_tr = None
            fixed = self.block_or_extend_bad(trace)
            if not fixed:
                self.print_statistics()
                # complete the trace
                self.trc = self.complete_trace(self.trc)
                # batch 13 : add check_spur before starvation
                spur, c_src, c_tgt, a_src, a_tgt, tr_formula, a_src_tr_pos = self.check_spur(self.trc)
                tr_copy = self.dynamic_program.find_tr(self.trace_second_coord[a_src_tr_pos])
                if spur == True:
                    if self.num_new_preds < 20:
                        self.write_to_smtInt()
                        # self.write_to_iz3()
                        self.write_to_msat()
                        # exit()
                        new_pred_smt_format = self.post_iplt_simplify('msat')
                        print('new_pred_smt_format',new_pred_smt_format)

                        if new_pred_smt_format == ['-1']:
                            return "Real cex, program unsafe.", self.smt_queries_count, num_preds, spur, None
                        print(new_pred_smt_format)
                    else:
                        exit()
                else:
                    return "Real cex. Program Unsafe.",  self.smt_queries_count, num_preds, spur, None
                return "Failed to find semantic self-composition. Either the property is violated or not enough predicates were supplied.", self.smt_queries_count, num_preds, spur, new_pred_smt_format
            trace = self.find_cex()
            if not (trace == None):
                self.trc = trace
        inv = self.get_invariant()
        if self.dynamic_program.is_predicate_abstraction:
            if not self.check_starvation(inv):
                self.print_statistics()
                return "Failed to prove (starvation detected)", self.smt_queries_count, num_preds, False, None
        self.print_statistics()
        # print('rel_init',self.dynamic_program.rel_init)
        return "Proved by invariant:\n" + str(inv), self.smt_queries_count, num_preds, False, None

    def update_cex_trace_states(self, trace):
        list_states = []
        self.cex_trace_states = []
        for state, move in trace:
            list_states.append(state.pretty_print(self.dynamic_program))
        # print('solve,6')
        for st in list_states:
            st = st[1:-4]
            st = st.replace("\n", "")
            st = st.replace(" ", "")
            st = st.split(',')
            # print('solve,7')
            # print(st)
            self.cex_trace_states.append(st)

    def complete_trace(self, trace):
        print('before complete_trace:', self.print_trace(trace))
        # print('complete_trace 1')
        # print(self.print_trace(trace))
        final = trace[-1][0]
        last_item = trace.pop()
        # print(trace)
        final_as_formula = self.dynamic_program.abstract_state_to_cond(final)
        # print('complete_trace 2, final',final_as_formula)
        # ---------check if final is first coordinate of any key in reason_to_add_to_bad-----------
        while True:
            # print('1')
            final_is_in_key = 0
            # print('2')
            for st_comp_pair in self.reason_to_add_to_bad:
                solver_key_is_final = z3.Solver(ctx=self.ctx)
                solver_key_is_final.add(z3.Not(final_as_formula))
                solver_key_is_final.add(st_comp_pair[0])
                if solver_key_is_final.check() == z3.unsat:
                    solver_key_is_final = z3.Solver(ctx=self.ctx)
                    solver_key_is_final.add(final_as_formula)
                    solver_key_is_final.add(z3.Not(st_comp_pair[0]))
                    if solver_key_is_final.check() == z3.unsat:
                        # st_comp_pair[0] is equivalent to bad_pred_reason_as_formula
                        final_is_in_key = 1
                        break
            # -----------if final isn't in key or if comp_taken is -1, then final is really bad, no need to extend the trace further
            if final_is_in_key == 0 or st_comp_pair[1] == -1:
                trace.append((final, -1))
                self.update_cex_trace_states(trace)
                print('after complete_trace', self.print_trace(trace))
                return trace
            else:
                if final_is_in_key == 1:
                    comp_taken = st_comp_pair[1]

                    # print('6')
                    reason_as_formula = self.reason_to_add_to_bad[st_comp_pair]
                # last item in trace is of form (final,0/1/2), we remove it so that we can add the transition from final that we stored in dict
                # extending trace
                # initialise an abstract state object equivalent to z3 formula : reason_as_formula
                reason = self.dynamic_program.abstract_st_from_z3_st(reason_as_formula)
                # cross check the conversion
                # print(self.dynamic_program.abstract_state_to_cond(reason))
                # update the trace. Warning : comp_taken can be -1, though trace only usually has 0,1,2
                trace.append((final, comp_taken))
                # update the reason to the reason for the current last item in trace
                # update final to the current reason
                final_as_formula = reason_as_formula
                final = self.dynamic_program.abstract_st_from_z3_st(reason_as_formula)
        return trace

    def get_dict(self):
        for i in self.dynamic_program.list_in_order:
            var_type = i[1:][:-1].split(',')
            self.dict_in_order[var_type[0]] = var_type[1]
            # print('dict_in_order',self.dict_in_order)

    def block_or_extend_bad(self, trace):
        if len(trace) <= 1:
            # Bad extended enough to intersect Init
            return False
        while True:
            # -------------rest of block_or_extend_bad-------------------------
            bad_predecessor = trace[-2][0]
            # print("1.bad_predecessor",bad_predecessor)
            bad_predecessor_assignment = trace[-2][1]
            # print("2.bad_predecessor_assignment",bad_predecessor_assignment)
            if bad_predecessor not in self.blocked_compositions:
                self.blocked_compositions[bad_predecessor] = []
            # print("3.bad_compositions",self.bad_compositions)
            # print("4.bad_predecessor",bad_predecessor)

            if len(self.blocked_compositions[bad_predecessor]) == (
                    self.dynamic_program.possible_assignments - 1) or self.check_possible_cutoff(bad_predecessor,
                                                                                                 bad_predecessor_assignment):
                if self.print_log:
                    print("Extending bad with state " + bad_predecessor.pretty_print(self.dynamic_program) + "\n")

                bad_predecessor_comp = trace[-2][1]
                bad_pred_reason = trace[-1][0]
                # print("5.bad_predecessor_comp",trace[-2][1])
                # print("6.bad_pred_reason",trace[-1][0])
                # ----------------convert abstract state objects to z3 formulas----------------------------------------
                bad_pred_as_formula = self.dynamic_program.abstract_state_to_cond(bad_predecessor)
                # print("7.bad_pred_as_formula",bad_pred_as_formula)
                bad_pred_reason_as_formula = self.dynamic_program.abstract_state_to_cond(bad_pred_reason)
                # print("8.bad_pred_reason_as_formula",bad_pred_reason_as_formula)
                # ----------------update the dictionary with <z3 formula of pred,comp> -> z3 formula of reason_as_formula-----------
                self.reason_to_add_to_bad[(bad_pred_as_formula, bad_predecessor_comp)] = bad_pred_reason_as_formula
                # print("9.reason_to_add_to_bad",self.reason_to_add_to_bad)
                # ---------------<bad_pred_reason_as_formula, -1> = None, if not already part of a key, -1 to indicate its a real_bad--
                reason_already_in_dict = 0

                for st_comp_pair in self.reason_to_add_to_bad:
                    solver_to_check_reason_in_dict = z3.Solver(ctx=self.ctx)
                    # print('initialised solver')
                    solver_to_check_reason_in_dict.add(z3.Not(bad_pred_reason_as_formula))
                    # print('added not reason')
                    solver_to_check_reason_in_dict.add(st_comp_pair[0])
                    # print('added st_comp_pair')
                    if solver_to_check_reason_in_dict.check() == z3.unsat:
                        solver_to_check_reason_in_dict = z3.Solver(ctx=self.ctx)
                        solver_to_check_reason_in_dict.add(bad_pred_reason_as_formula)
                        solver_to_check_reason_in_dict.add(z3.Not(st_comp_pair[0]))
                        # print('initialisedsecod solver with formulas')
                        if solver_to_check_reason_in_dict.check() == z3.unsat:
                            # st_comp_pair[0] is equivalent to bad_pred_reason_as_formula
                            reason_already_in_dict = 1
                if reason_already_in_dict == 0:
                    self.reason_to_add_to_bad[(bad_pred_reason_as_formula, -1)] = None

                # print('reason_to_add_to_bad',self.reason_to_add_to_bad)

                self.dynamic_program.extend_bad(bad_predecessor)
                self.blocked_compositions.pop(bad_predecessor)
                trace = trace[:-1]
                if len(trace) <= 1:
                    return False
            else:
                if self.print_log:
                    # print('Xbad_predecessor',bad_predecessor)
                    print("Blocking composition assignment " + str(
                        bad_predecessor_assignment) + " for state\n " + bad_predecessor.pretty_print(
                        self.dynamic_program) + "\n")
                self.blocked_compositions[bad_predecessor].append(bad_predecessor_assignment)
                if self.dynamic_program.use_explicit_conposition_function:
                    self.dynamic_program.change_assignment(bad_predecessor, self.get_next_assignment(bad_predecessor))
                    self.dynamic_program.sc_tr = None
                else:
                    self.dynamic_program.block_assignment(bad_predecessor, bad_predecessor_assignment)
                    # print('asdfg')
                break
        # print('block_ext,1')
        self.dynamic_program.mk_dynamic_rules()

        # print('block_ext,2')
        return True

    def run_bmc(self):
        self.smt_queries_count += 1
        self.concrete_dp.mk_init_rule()
        self.init_bounded_fp(self.longest_abstract_trace + 3, self.concrete_dp.ctx)
        self.load_dynamic_program_for_bmc()

        res = self.fp.query(self.concrete_dp.get_bad())
        if res == z3.sat:
            return True
        return False

    def find_cex(self):
        self.smt_queries_count += 1
        self.init_fp()
        # print('find cex,1')
        # self.import_lemmas()
        # print('find cex,2')
        self.load_dynamic_program()
        # print('find cex,3')

        res = self.fp.query(self.dynamic_program.get_bad())
        # print('res',res)
        # print('initial condition before solver',self.dynamic_program.init_rule)
        # print('tr before solver',self.dynamic_program.sc_tr_rule)
        # print('res',res)
        if not self.dynamic_program.default_composition:
            self.export_inv_lemmas()
            # print('find cex,4')
        if res == z3.unsat:
            # print('find cex,5')
            return None

        else:
            # print('find cex,6')
            answer = self.fp.get_ground_sat_answer()
            # print('answer',answer)
            # print('find cex,7',answer)
            return self.get_state_move_trace(answer)

    def print_statistics(self):
        print(str(self.smt_queries_count) + " SMT queries performed.")

    def export_inv_lemmas(self):
        level = 0
        while True:
            cover_delta = self.fp.get_cover_delta(level, self.dynamic_program.get_inv_declaration())
            if z3.is_true(cover_delta):
                break
            self.lemmas[level] = cover_delta
            level += 1
        # print('self.lemmas',self.lemmas)

    def import_lemmas(self):
        inv_decl = self.dynamic_program.get_inv_declaration()
        for level, prop in self.lemmas.items():
            self.fp.add_cover(level, inv_decl, prop)

    def init_fp(self):
        z3.enable_trace('spacer')
        fp = z3.Fixedpoint(ctx=self.ctx)  # fixpoint solver
        fp.set(engine='spacer')
        fp.set('spacer.eq_prop', False)
        fp.set('xform.slice', False)
        fp.set('xform.inline_linear', False)  # performance once there is no need for debuging
        fp.set('xform.inline_eager', False)
        fp.set('xform.tail_simplifier_pve', False)
        self.fp = fp

    def init_bounded_fp(self, bound, ctx):
        # z3.enable_trace('spacer')
        fp = z3.Fixedpoint(ctx=ctx)  # fixpoint solver
        fp.set(engine='spacer')
        fp.set('spacer.max_level', bound)
        fp.set('spacer.eq_prop', False)
        fp.set('xform.slice', False)
        fp.set('xform.inline_linear', False)  # performance once there is no need for debuging
        fp.set('xform.inline_eager', False)
        fp.set('xform.tail_simplifier_pve', False)
        self.fp = fp

    def get_state_move_trace(self, answer):
        # print('In get_state_move_trace')
        z3_states = self.get_z3_states(answer)
        # print('get_state_move_trace,2, TTRACE z3_states variable',z3_states)
        state_move_trace = []
        for z3_state in z3_states:
            state = self.dynamic_program.abstract_state_from_z3_state(z3_state)
            # print('get_state_move_trace,3,TTRACE ',state)
            state_move_trace.append(
                (state, (
                    7 if self.dynamic_program.k == 3 else 2) if self.dynamic_program.default_composition else z3_state.arg(
                    0).as_long()))
        # print('get_state_move_trace,4,TTRACE, state_move_trace list',state_move_trace)
        state_move_trace.reverse()
        return state_move_trace

    @staticmethod
    def get_z3_states(answer):
        i = 1
        states = []
        while i < len(answer.children()):
            states.append(answer.arg(i))
            i += 1
        return states

    def print_trace(self, trace):
        # print('In print_trace')
        self.trace_second_coord = []
        ret = ""
        for state, move in trace:
            ret += state.pretty_print(self.dynamic_program) + "--->"

            a = "[" + (str(move) if not self.dynamic_program.default_composition else (
                str(7) if self.dynamic_program.k == 3 else str(2))) + "]\n\n"
            ret += a
            self.trace_second_coord.append((str(move) if not self.dynamic_program.default_composition else (
                str(7) if self.dynamic_program.k == 3 else str(2))))

        return ret

    def get_invariant(self):
        inv_decl = self.dynamic_program.get_inv_declaration()
        inv_rel = self.dynamic_program.get_inv_relation()
        val = self.fp.get_cover_delta(-1, inv_decl)
        val = z3.substitute_vars(val, *inv_rel.children())
        return val

    def load_dynamic_program(self):
        # print('load_dynamic_program,1')
        # print('a')

        self.dynamic_program.mk_tr_rule()
        # print('sc_tr',self.dynamic_program.sc_tr_rule)
        # print('b')
        # print('load_dynamic_program,2')
        self.dynamic_program.mk_bad_rule()
        # print('bad',self.dynamic_program.bad_rule)
        # print('load_dynamic_program,3')
        self.fp.declare_var(self.dynamic_program.get_vars_to_declare())
        # print('get_vars_to_declare',self.dynamic_program.get_vars_to_declare())
        # print('load_dynamic_program,4')
        self.fp.register_relation(self.dynamic_program.get_bad_declaration())
        # print('get_bad_declaration',self.dynamic_program.get_bad_declaration())
        # print('load_dynamic_program,5')
        self.fp.register_relation(self.dynamic_program.get_inv_declaration())
        # print('get_inv_declaration',self.dynamic_program.get_inv_declaration())
        # print('load_dynamic_program,6')
        # print('init_rule',self.dynamic_program.init_rule)
        for rule in self.dynamic_program.get_rules():
            if z3.is_app_of(rule, z3.Z3_OP_IMPLIES):
                # print('rule',rule)
                # print('is_app_of')
                self.fp.add_rule(rule.arg(1), rule.arg(0))
            else:
                # print('rule',rule)
                # print('not is_app_of')
                self.fp.add_rule(rule)

    def load_dynamic_program_for_bmc(self):
        self.concrete_dp.mk_tr_rule()
        self.concrete_dp.mk_bad_rule()
        self.fp.declare_var(self.concrete_dp.get_vars_to_declare())
        self.fp.register_relation(self.concrete_dp.get_bad_declaration())
        self.fp.register_relation(self.concrete_dp.get_inv_declaration())
        for rule in self.concrete_dp.get_rules():
            if z3.is_app_of(rule, z3.Z3_OP_IMPLIES):
                self.fp.add_rule(rule.arg(1), rule.arg(0))
            else:
                self.fp.add_rule(rule)

    def check_starvation(self, inv):
        solver = z3.Solver(ctx=self.ctx)
        solver.add(self.dynamic_program.subst_predicates(inv))
        solver.add(self.dynamic_program.subst_predicates(self.dynamic_program.get_all_end()))
        if z3.unsat == solver.check():
            return False
        return True

    def sc_program_from_file(self, program_path, is_comparator, method_name, concrete_array_vars, prop):
        # print('sc_pgm,1')
        if is_comparator:
            dp, entry_to_memory_map = comparator_transform(program_path, self.force_predicate_abstraction, method_name,
                                                           prop)
            # print('sc_pgm,2')
            if self.bmc and self.force_predicate_abstraction:
                self.concrete_dp = comparator_transform(program_path, False, method_name, prop, entry_to_memory_map)[0]
        else:
            # print('sc_pgm,3')
            dp = transform(program_path, self.force_predicate_abstraction, concrete_array_vars)
            # print('sc_pgm,4')
        # print('rel_init',self.dynamic_program.rel_init)
        dp.mk_init_rule()
        # print('rel_init',dp.rel_init)
        # print('sc_pgm,5')
        return dp

    def check_possible_cutoff(self, state, assignment_to_disable):
        # return False-> no cutoff, return True -> extend bad
        if self.dynamic_program.k == 2:
            if assignment_to_disable is 2:
                if state in self.blocked_compositions and len(self.blocked_compositions[state]) > 0:
                    copy_to_check = 1 - self.blocked_compositions[state][0]
                else:
                    return False
            elif 2 in self.blocked_compositions[state]:
                copy_to_check = 1 - assignment_to_disable
            else:
                return False
            return not self.check_not_ended(state, copy_to_check)
        if self.dynamic_program.k == 3:
            assignments_left = range(1, 8)
            assignments_left.remove(assignment_to_disable)
            if state in self.blocked_compositions:
                for assignment in self.blocked_compositions[state]:
                    assignments_left.remove(assignment)
            for assignment in assignments_left:
                b = BitArray(uint=assignment, length=3)
                copy_2_run = (assignment in [4, 5, 6])  # b[0]
                copy_1_run = (assignment in [2, 3, 6])  # b[1]
                copy_0_run = (assignment in [1, 3, 5])  # b[2]
                if copy_0_run:
                    if not self.check_not_ended(state, 0):
                        continue
                if copy_1_run:
                    if self.check_not_ended(state, 1):
                        continue
                if copy_2_run:
                    if self.check_not_ended(state, 2):
                        continue
                return False
            return True

    def check_not_ended(self, state, copy_to_check):
        # return True-> copy did not exit yet in the state-> OK assignment
        solver = z3.Solver(ctx=self.ctx)
        solver.add(self.dynamic_program.exits[copy_to_check])
        solver.add(self.dynamic_program.subst_predicates(self.dynamic_program.abstract_state_to_cond(state)))
        return z3.unsat == solver.check()

    def get_next_assignment(self, state):
        # todo: improve performance- do not allow copies that ended to run, this will result in less compositions
        if self.dynamic_program.k == 2:
            # at this point we know there is some possible composition for state that is not starving
            for next in range(self.dynamic_program.possible_assignments):
                if next not in self.blocked_compositions[state]:
                    if next == 2:
                        return 2
                    if self.check_not_ended(state, next):
                        return next
        if self.dynamic_program.k == 3:
            for next in range(self.dynamic_program.possible_assignments):
                if next not in self.blocked_compositions[state]:
                    if next == 7:
                        return 7
                    b = BitArray(uint=next, length=3)
                    copy_2_run = (next in [4, 5, 6])  # b[0]
                    copy_1_run = (next in [2, 3, 6])  # b[1]
                    copy_0_run = (next in [1, 3, 5])  # b[2]
                    if copy_0_run:
                        if not self.check_not_ended(state, 0):
                            self.blocked_compositions[state].append(next)
                            continue
                    if copy_1_run:
                        if self.check_not_ended(state, 1):
                            self.blocked_compositions[state].append(next)
                            continue
                    if copy_2_run:
                        if self.check_not_ended(state, 2):
                            self.blocked_compositions[state].append(next)
                            continue
                    return next

    # batch 6 : assign_prime_to_unprime
    def assign_prime_to_unprime(self, model):
        values_dict = dict()
        # print('passed 1')
        for d in model.decls():
            var_name = d.name()
            # print('passed 2')
            var_val = model[d]
            # assumes number of copies < 10
            last_letter = var_name[-3]
            # print('passed 3 %s %s %s %s' %(last_letter,var_val,var_name,d))
            len_of_var_name = len(var_name)
            # print('passed 4')
            if last_letter == 'p':

                if len_of_var_name > 3:
                    # print('passed 4 %s %s' %(last_letter,d))
                    # print("hello")
                    except_p = var_name[0:-3] + var_name[-2:]
                    # print('passed 5 %s %s'%(d,except_p))
                    # print("",except_p,"=",var_val)
                    values_dict[except_p] = var_val
                    # print('passed 6 %s %s'%(values_dict,values_dict[except_p]))
        for d in model.decls():

            var_name = d.name()
            var_val = model[d]
            # assumes number of copies < 10
            last_letter = var_name[-3]
            if not (last_letter == 'p'):
                # print('var_name',var_name)
                if not (var_name in values_dict):
                    values_dict[var_name] = var_val
        # del values_dict['composition']
        # print("values_dict",values_dict)
        return values_dict

    # batch 11 :
    def abs_st_as_formula(self, state_number_in_cex):
        pred_valuations_dict = dict()
        st_list = []
        # print("a_list")
        for key, val in self.pred_string_dict.items():
            # print("a_list")
            # print("self.cex_trace_states : ",self.cex_trace_states)
            # print("self.cex_trace_states[state_number_in_cex]",self.cex_trace_states[state_number_in_cex])
            if key in self.cex_trace_states[state_number_in_cex]:
                # add val = True
                # print("a_list True")
                st_list.append(val == True)
            else:
                # print("a_list False")
                st_list.append(val == False)
        st_list.append(self.ctx)
        formula = z3.And(*st_list)
        return formula

    def compute_vars_in_c_src(self):
        for key, val in self.dynamic_program.var_string_dict.items():
            if not (str(type(val)).find('Arith') == -1):
                self.vars_in_c_src[key] = 'Int'
            elif not (str(type(val)).find('Bool') == -1):
                self.vars_in_c_src[key] = 'Bool'
            else:
                self.vars_in_c_src[key] = 'Array'
        # print('pred_disc,002')

        # add p to last but third position
        for key_p, val in self.dynamic_program.var_string_dict.items():
            key_p = '_'.join(key_p.split('_')[:-1]) + 'p_' + '_'.join(key_p.split('_')[-1:])
            if not (str(type(val)).find('Arith') == -1):
                self.vars_in_c_src_p[key_p] = 'Int'
            elif not (str(type(val)).find('Bool') == -1):
                self.vars_in_c_src_p[key_p] = 'Bool'
            else:
                self.vars_in_c_src_p[key_p] = 'Array'

    def compute_pred_meaning(self):
        parentheses_locs = self.paren_dict_func(str(self.dynamic_program.h))

        # print('predicate names',self.dynamic_program.predicates)
        # h_list is list of definitions of predicates of form c0_eq_c1 == 'c0 == c1' and self.pred_meaning dictionary maps pred to their definitions

        for preds in self.dynamic_program.predicates:
            if not (str(self.dynamic_program.h).find(str(preds)) == -1):
                # next_paren has the diff of immediate paranthesis in h after pred name
                if str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 4] == '(':
                    next_paren = 4
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 5] == '(':
                    next_paren = 5
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 6] == '(':
                    next_paren = 6
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 7] == '(':
                    next_paren = 7
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 8] == '(':
                    next_paren = 8
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 9] == '(':
                    next_paren = 9
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 10] == '(':
                    next_paren = 10
                elif str(self.dynamic_program.h)[
                    str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 11] == '(':
                    next_paren = 11
                else:
                    # print(preds,self.dynamic_program.h)
                    print('no (')

                    next_paren = -1

                # print('next_paren',next_paren)
                # print('pred_index + pred_len + 11 < len(h) ',len(str(self.dynamic_program.h)) > str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 11)
                # print('h[pred_index+4..11]',str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 4],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 5],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 6],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 7],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 8],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 9],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 10],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 11] )
                if next_paren == -1:
                    endofpreddefn = str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)):].find(',')
                    self.pred_meaning[preds] = str(self.dynamic_program.h)[
                                               str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 4:str(
                                                   self.dynamic_program.h).find(str(preds)) + endofpreddefn]
                if next_paren > 0:
                    self.pred_meaning[preds] = (str(self.dynamic_program.h)[
                                                str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 4:
                                                parentheses_locs[str(self.dynamic_program.h).find(str(preds)) + len(
                                                    str(preds)) + next_paren] + 1]).replace('\n', '').replace('  ',
                                                                                                              '').replace(
                        '==', '=')

        # do the same for h_p
        parentheses_locs_p = self.paren_dict_func(str(self.dynamic_program.h_p))

        predicates_p = []
        for p in self.dynamic_program.predicates:
            predicates_p.append(str(p) + 'p')

        # h_list is list of definitions of predicates of form c0_eq_c1 == 'c0 == c1' and self.pred_meaning dictionary maps pred to their definitions
        for preds_p in predicates_p:
            if not (str(self.dynamic_program.h_p).find(str(preds_p)) == -1):
                # next_paren has the diff of immediate paranthesis in h after pred name
                if str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 4] == '(':
                    next_paren = 4
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 5] == '(':
                    next_paren = 5
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 6] == '(':
                    next_paren = 6
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 7] == '(':
                    next_paren = 7
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 8] == '(':
                    next_paren = 8
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 9] == '(':
                    next_paren = 9
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 10] == '(':
                    next_paren = 10
                elif str(self.dynamic_program.h_p)[
                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 11] == '(':
                    next_paren = 11
                else:
                    print('no (')
                    next_paren = -1

                if next_paren == -1:
                    endofpreddefn = str(self.dynamic_program.h_p)[
                                    str(self.dynamic_program.h_p).find(str(preds_p)):].find(',')
                    self.pred_meaning_p[preds_p] = str(self.dynamic_program.h_p)[
                                                   str(self.dynamic_program.h_p).find(str(preds_p)) + len(
                                                       str(preds_p)) + 4:str(self.dynamic_program.h_p).find(
                                                       str(preds_p)) + endofpreddefn]
                if next_paren > 0:
                    self.pred_meaning_p[preds_p] = (str(self.dynamic_program.h_p)[
                                                    str(self.dynamic_program.h_p).find(str(preds_p)) + len(
                                                        str(preds_p)) + 4:parentheses_locs_p[
                                                                              str(self.dynamic_program.h_p).find(
                                                                                  str(preds_p)) + len(
                                                                                  str(preds_p)) + next_paren] + 1]).replace(
                        '\n', '').replace('  ', '').replace('==', '=')

    # batch 7 : check_spur1
    def check_spur(self, trace):
        # print("-----------------------------------check_spur-------------------------------")

        # print("trace",trace)
        # print('trace',trace)
        # print('trace[-2][0]',self.dynamic_program.abstract_state_to_cond(trace[-2][0]))
        # print('trace[-1][0]',self.dynamic_program.abstract_state_to_cond(trace[-1][0]))
        len_trc = len(trace)
        # print('cs,1')
        # print("len_trc : ", len_trc)
        state_number_in_cex = 0
        # batch 14 : find first abstract state and assign to a_src
        a_src = self.abs_st_as_formula(state_number_in_cex)
        # print('a_list',a_list)
        # print('cs1.1',a_list)
        '''
        a_list.append(self.ctx)
        a_src = z3.And(*a_list)
        '''

        # print('1 a_src',a_src)
        s_find_next = z3.Solver(ctx=self.ctx)
        print("final init cond", self.dynamic_program.init_condition)
        s_find_next.add(z3.And(self.dynamic_program.init_condition, self.ctx))
        s_find_next.add(a_src)
        s_find_next.add(self.dynamic_program.h)
        # print('rel_init',self.dynamic_program.rel_init)
        # print('cs,2, ',self.dynamic_program.var_string_dict)
        '''
        init_as_str = str(self.dynamic_program.init_condition)
        print('2',init_as_str)
        for var in self.dynamic_program.var_string_dict:
            print('3')
            if init_as_str.find(var) == -1:
                print('4')
                print(self.dynamic_program.var_string_dict[var],type(self.dynamic_program.var_string_dict[var]))
                #vars_not_in_init.append(self.dynamic_program.var_string_dict[var])
                #print('4.1')
                #s_find_next.add(z3.And(self.dynamic_program.var_string_dict[var] == self.dynamic_program.var_string_dict[var]))
                #print('4.2')
        #exit()
        #print('vars_not_in_init',vars_not_in_init)
        #vars_not_in_init.append(self.ctx)
        s_find_next.add(z3.And(*vars_not_in_init))
        print('5')
        '''
        if s_find_next.check() == z3.unsat:
            # print('cs,3')
            # print("No concrete initial state exists")
            return True, None, None, a_src, None, self.dynamic_program.sc_tr, state_number_in_cex
        else:
            # print('s_find_next',s_find_next)
            m = s_find_next.model()
            # print('1')
            # print('cs,2, ',self.dynamic_program.var_string_dict)
            # print('self.dynamic_program.var_string_dict',self.dynamic_program.var_string_dict(),type(self.dynamic_program.var_string_dict()))
            # print('str(self.dynamic_program.h)',str(self.dynamic_program.h))
            # print('str(self.dynamic_program.init_condition)',str(self.dynamic_program.init_condition))
            for v in self.dynamic_program.var_string_dict:
                if str(self.dynamic_program.h).find(v) == -1 and str(self.dynamic_program.init_condition).find(v) == -1:
                    # print('here')
                    m.eval(self.dynamic_program.var_string_dict[v], model_completion=True)
                    # print('not here')

            # print('cs,4,mmmmmmmm',m)
            # print("got here")
            len_trc = len_trc - 1

            # print( 'A satisfying concrete initial state : ' , m)
            # print("len_trc : ", len_trc)
            # batch 12 : check if initial state is in bad
            values_dict = dict()

            for d in m.decls():
                # print(d.name(),m[d])
                ind = d.name()
                valuation = m[d]
                values_dict[ind] = valuation
            # print(values_dict)

            formula = []

            for key, val in values_dict.items():
                # print(val,type(val))
                # print(self.dynamic_program.var_string_dict.keys())
                if key in self.dynamic_program.var_string_dict.keys():
                    actual_var = self.dynamic_program.var_string_dict[key]
                    formula.append(actual_var == val)
                # print("formula",formula)

            formula.append(self.ctx)
            c_src = z3.And(*formula)
            c_tgt = None
            a_tgt = None
            s_find_next = z3.Solver(ctx=self.ctx)
            s_find_next.add(c_src)

            while len_trc > 0:
                # print ("sc_tr", self.dynamic_program.sc_tr)
                # create a formula to say composition var = trace_seond_coord[state_num_in_cex]
                # print(self.trace_second_coord[state_number_in_cex])
                tr = self.dynamic_program.find_tr(self.trace_second_coord[state_number_in_cex])
                list_for_tr = []
                list_for_tr.append(tr)
                list_for_tr.append(self.ctx)
                tr_formula = z3.And(*list_for_tr)
                print("tr formula", tr_formula)
                # print('passed list creation')
                s_find_next.add(tr_formula)
                if s_find_next.check() == z3.unsat:
                    # print( 'No transition from the previous concrete state')
                    return True, c_src, c_tgt, a_src, a_tgt, tr_formula, state_number_in_cex
                else:
                    model = s_find_next.model()
                    # print("state : ",state_number_in_cex+2," is ",model)
                    len_trc = len_trc - 1
                    # print("len_trc : ", len_trc)
                    # print('pap ',model)
                    # batch 8 : assign_prime_to_unprime
                    values_dict = self.assign_prime_to_unprime(model)
                    # print("passed values_dict")
                    solver_c_in_a = z3.Solver(ctx=self.ctx)
                    solver_c_in_a.add(self.dynamic_program.h)
                    state_number_in_cex = state_number_in_cex + 1
                    # print("state_number_in_cex",state_number_in_cex)

                    # batch 10 : add conc_st to solver
                    formula = []
                    for key, val in values_dict.items():
                        # print(val,type(val))
                        # print(self.dynamic_program.var_string_dict.keys())
                        if key in self.dynamic_program.var_string_dict.keys():
                            actual_var = self.dynamic_program.var_string_dict[key]
                            formula.append(actual_var == val)
                    # print("formula",formula)
                    formula.append(self.ctx)
                    c_tgt = z3.And(*formula)
                    solver_c_in_a.add(c_tgt)

                    # batch 11 : add a batch to add abs_ st
                    a_tgt = self.abs_st_as_formula(state_number_in_cex)
                    '''
                    st_list.append(self.ctx)
                    a_tgt = z3.And(*st_list)
                    '''
                    solver_c_in_a.add(a_tgt)

                    # batch 16
                    # check if c_src /\ sc_tr is unsat
                    not_hang_src = z3.Solver(ctx=self.ctx)
                    not_hang_src.add(c_src)
                    not_hang_src.add(z3.And(*list_for_tr))
                    if not_hang_src.check() == z3.unsat:
                        # print(" concrete source is hanging")
                        self.hang = True
                        return True, c_src, c_tgt, a_src, a_tgt, tr_formula, state_number_in_cex - 1

                    # batch 9 : finish it up WITHOUT adding formulas for abs st and conc st
                    if z3.unsat == solver_c_in_a.check():
                        # print("The concrete state is not in abstract state of trace")
                        # batch 15 : pred_disc1

                        # print("c_src : ",c_src)
                        # print("c_tgt : ",c_tgt)
                        # print("a_src : ",a_src)
                        # print("a_tgt : ",a_tgt)
                        # print("tr : ", )
                        # print("state_num_in_cex",state_number_in_cex)
                        self.hang = False

                        return True, c_src, c_tgt, a_src, a_tgt, tr_formula, state_number_in_cex - 1
                    else:
                        s_find_next = z3.Solver(ctx=self.ctx)
                        s_find_next.add(z3.And(*formula))
                        # print("while loop iteration ended",len_trc)
                        c_src = c_tgt
                        a_src = a_tgt

            # batch 12 : check if final concrete state is in bad
            solver_bad = z3.Solver(ctx=self.ctx)
            # print('a_tgt is %s \n original_bad is %s'%(a_tgt,self.dynamic_program.original_bad_cond))
            solver_bad.add(z3.Not(self.dynamic_program.original_bad_cond))
            solver_bad.add(a_tgt)
            solver_bad.add(self.dynamic_program.h)
            # print("solver_bad",solver_bad, " is ", solver_bad.check())
            if solver_bad.check() == z3.unsat:
                print("Trace is not spurious")
                return False, c_src, c_tgt, a_src, a_tgt, tr_formula, state_number_in_cex - 1
            else:

                print("Last concrete trace in the state is not in bad")
                return True, None, c_tgt, None, a_tgt, tr_formula, state_number_in_cex - 1
        # return False,c_src,c_tgt,a_src,a_tgt,tr_formula,state_number_in_cex-1

    def pred_disc(self, c_src, c_tgt, a_src, a_tgt, tr):
        print('----------------------pred_disc-------------------')
        # print('c_src,c_tgt,a_src,a_tgt',c_src,c_tgt,a_src,a_tgt)
        c_src_original = c_src
        c_tgt_original = c_tgt
        a_src_original = a_src
        a_tgt_original = a_tgt
        tr_original = tr
        # print('pred_disc,001')

        '''
        pr = z3.simplify(z3.And(a_src,self.dynamic_program.h,self.ctx))
        print('pr',pr)
        '''
        c_src = c_src.sexpr()
        c_tgt = c_tgt.sexpr()

        print('pred meaning', self.pred_meaning)
        print('pred meaning_p ', self.pred_meaning_p)
        print('a_src ', a_src)
        str_prefix_a_src = self.elim_pred_in_formula(a_src, str(0), self.vars_in_c_src, self.pred_meaning)
        print('str_prefix_a_src ', str_prefix_a_src)
        str_prefix_a_tgt = self.elim_pred_in_formula(a_tgt, str(1), self.vars_in_c_src, self.pred_meaning)

        f_a_tgt_next = open(self.folder_path + "a_tgt_next.py", "w")
        f_a_tgt_next.write("from z3 import *\n")
        # x, y, z, w = Ints('x y z w')

        for p in self.pred_meaning:
            f_a_tgt_next.write(str(p) + ", ")
        predp_str = ''
        for pp in self.pred_meaning_p:
            predp_str = predp_str + (str(pp) + ", ")
        predp_str = predp_str[:-2]
        f_a_tgt_next.write(predp_str)
        f_a_tgt_next.write(' = ')
        f_a_tgt_next.write('Bools(\'')
        for p in self.pred_meaning:
            f_a_tgt_next.write(str(p) + " ")
        predp_str = ''
        for pp in self.pred_meaning_p:
            predp_str = predp_str + (str(pp) + " ")
        predp_str = predp_str[:-1]
        f_a_tgt_next.write(predp_str)
        f_a_tgt_next.write('\')\n')
        # formula = x - y < 2
        f_a_tgt_next.write('formula = And(' + str(a_tgt).replace('\n', '').replace('  ', '') + ')\n')
        # substitute(formula, (x, z), (y, w))
        f_a_tgt_next.write('print(substitute(formula, ')
        pred_str = ''
        for p in self.pred_meaning:
            pred_str = pred_str + '(' + str(p) + ',' + str(p) + 'p' + ')'
            pred_str = pred_str + ', '

        pred_str = pred_str[:-2]
        f_a_tgt_next.write(pred_str + '))')

        f_a_tgt_next.close()
        # end of atgt file.py
        # read the output from txt
        cmd = 'python3 ' + self.folder_path + 'a_tgt_next.py > ' + self.folder_path + 'a_tgt.txt'
        os.system(cmd)
        # print('pred_disc,11')
        # print('Finished dumping atgt to py file, now reading from txt....')
        # read the file
        f_txt = open(self.folder_path + 'a_tgt.txt', 'r')
        a_tgt_subs = f_txt.read()
        # print('pred_disc,12')
        # print('atgtsubs',a_tgt_subs)

        str_prefix_a_tgt_subs = self.elim_pred_in_formula(a_tgt_subs, 2, self.vars_in_c_src_p, self.pred_meaning_p)
        # print('str_prefix',str_prefix_a_tgt_subs,type(str_prefix_a_tgt_subs))

        # print('a_tgt2',a_tgt)

        # Remove newlines

        c_src = c_src.replace('\n', ' ').replace('  ', '')

        c_tgt = c_tgt.replace('\n', ' ').replace('  ', '')
        str_prefix_a_src = str_prefix_a_src.replace('\n', ' ').replace('  ', '')

        str_prefix_a_tgt = str_prefix_a_tgt.replace('\n', ' ').replace('  ', '')

        str_prefix_a_tgt_subs = str_prefix_a_tgt_subs.replace('\n', ' ').replace('  ', '')

        # return the indices of the locations
        # print('returned str_prefix_a_tgt')
        # print('==============================')
        # print('c_src',c_src)
        # print('c_tgt',c_tgt)
        # print('a_src',str_prefix_a_src)
        # print('a_tgt',str_prefix_a_tgt)

        tr_sexpr = str(tr.sexpr())
        # print('sl,1,tr_sexpr',tr_sexpr)

        tr_wo_let = self.eliminate_let(tr_sexpr)

        tr_wo_let = tr_wo_let.replace('\n', '').replace('  ', '')
        print('tr_wo_let', tr_wo_let, type(tr_wo_let))
        # print('tr_wo_let')
        # print('c_src is %s \n,c_tgt is %s,a_src is %s,a_tgt is %s,tr is %s,a_tgt_next is %s' % (c_src,c_tgt,str_prefix_a_src,str_prefix_a_tgt,tr_wo_let,str_prefix_a_tgt_subs))

        # add queries to sl file
        new_pred_smt_format = self.dump_to_smt_file(c_src, c_tgt, str_prefix_a_src, str_prefix_a_tgt, tr_wo_let)
        # print('new_pred_smt_format',new_pred_smt_format)
        # self.write_to_smt2_file(c_src,c_tgt,str_prefix_a_src,str_prefix_a_tgt,self.vars_in_c_src,self.vars_in_c_src_p,tr_wo_let,str_prefix_a_tgt_subs,c_src_original,c_tgt_original,a_src_original,a_tgt_original,tr_original)
        # exit()
        return new_pred_smt_format

    def add_new_predicate_smt(self, smt_predicate, refine_type):
        # add the predicate to the original smt2 file
        if smt_predicate.__contains__('let'):
            predicate_wo_let_maybe_with_not = (self.eliminate_let(smt_predicate)).replace('  ', '')
        else:
            predicate_wo_let_maybe_with_not = smt_predicate
        # type of vars is of form (Int Int Bool Int) when there are 4 variables in each copy that p depends on
        # All variables' type of one copy in list_types and variables in list_vars
        signature = '(declare-rel pred_' + refine_type + '_' + str(self.num_new_preds) + ' (' + ' '.join(
            self.list_types) + '))'

        # We now have '(declare-rel p@i (Int Int Bool Int)). Now we describe the predicate.
        # predicate argument is of form (define-fun p ((h_1 Int) (l_0 Int) (h_0 Int)(l_1 Int)) Bool (and (= h_0 h_1) (= l_1 l_0))). We need to obtain the last part where predicate is defined. So find the last occurrence of Bool.
        # at this point pred_body has (and (= h_0 h_1) (= l_1 l_0))
        pred_body = predicate_wo_let_maybe_with_not.replace(')', ' )').replace('(', ' (')
        predicate_str_with_spaces = pred_body.split(' ')
        variables = []
        for i in predicate_str_with_spaces:
            if not (i.find('_') == -1):
                variables.append(str(i))
        variables = list(sorted(variables))
        for i in variables:
            last_ = '_'.rfind(i)
            if not (last_ == '-1'):
                pred_body = pred_body.replace(i, '(rel ' + i[:last_ - 1] + ' ' + i[last_:] + ')')

        final = ' (pred_' + refine_type + '_' + str(self.num_new_preds) + ' ' + ' '.join(self.list_vars) + ')'
        if not (pred_body[0:5].find('not') == -1):
            pred_body = (pred_body[5:])[:-2]
        rule = '' + signature + '\n (rule (=> ' + pred_body + final + '))'
        return rule

    def elements_of_list_as_string(self, lst):
        # print(lst,type(lst))
        for x in lst:
            str_lst = str_lst + str(x) + ' '
            # print(str_lst)
        return str_lst

    def eliminate_let(self, formula):

        # print('formula',str(formula))
        formula = formula.replace('\n', ' ')
        let_list = str(formula).replace('\n', ' ').split('let')
        print('sl,2,let_list', let_list)
        line = []
        for i in let_list:
            line.append(re.sub('\s+', ' ', i))
        # print('line : ',line)
        # print('sl,3,line',line)
        aux_vars = []
        for i in line:
            for j in i.split(' '):
                if ((not (j.find('.') == -1)) or (not (j.find('!') == -1))):
                    v = j.replace('(', '').replace(')', '').replace('  ', ' ')
                    if not (v in aux_vars):
                        aux_vars.append(v)

        print('sl,4', aux_vars)
        aux_vars_dict = dict()
        rest_list = []
        # ''+aux_var[i]+'.*'+aux_var[i+1]
        for i in range(len(aux_vars)):
            # print('------------'+str(i)+'----------')
            # print(i,aux_vars[i])
            a = formula.find(aux_vars[i])
            aux_var = aux_vars[i]
            # print(a,formula[a-1])
            # print('here')
            # print('a-1',a-1)
            # print('sl,5',aux_var)
            # print('formula',formula)
            aux_vars_dict[aux_var], index_next_open_br, c = self.find_match_paren(str(formula), a - 1)
            # print('sl,6',aux_vars_dict[aux_var], index_next_open_br)
            rest_list.append(index_next_open_br)
        # print('sl,7,rl',rest_list)
        # find index of opening parenthesis of the expression after lets, assumes )(
        # print('sl,8,aux_vars_dict',aux_vars_dict)
        rev_aux_vars = list(reversed(sorted(aux_vars_dict.keys())))
        # print('rev_aux_vars_dict',rev_aux_vars_dict)
        # print('000000000000000000')
        # print('dd',str(formula))
        count = 0

        while (count <= len(aux_vars) + 1):
            for aux_var in rev_aux_vars:
                # i=0
                formula = str(formula[:index_next_open_br]) + str(formula[index_next_open_br:]).replace(aux_var,
                                                                                                        aux_vars_dict[
                                                                                                            aux_var])
                # print('dd',formula)
                # i += 1
            count += 1
        # print('sl,9,formula:', formula,formula.count('let'))
        num_brackets_after_tr = formula.count('let') * -1
        # print('sl,10 num_brackets_after_tr',num_brackets_after_tr)
        formula = formula.rstrip()
        # and_ind=formula.find('(and')
        return (formula[index_next_open_br:num_brackets_after_tr])

    def check_parentheses(self, s):
        """ Return True if the parentheses in string s match, otherwise False. """
        j = 0
        # print('check_par 1',c,j)
        for c in s:
            # print('check_par 2',c,j)
            if c == ')':
                # print('check_par 3',c,j)
                j -= 1
                # print('check_par 4',c,j)
                if j < 0:
                    # print('check_par 5',c,j)
                    return False
            elif c == '(':
                # print('check_par 6',c,j)
                j += 1
                # print('check_par 7',c,j)
        return j == 0

    def find_parentheses(self, s):
        """ Find and return the location of the matching parentheses pairs in s.

        Given a string, s, return a dictionary of start: end pairs giving the
        indexes of the matching parentheses in s. Suitable exceptions are
        raised if s contains unbalanced parentheses.

        """

        # The indexes of the open parentheses are stored in a stack, implemented
        # as a list

        stack = []
        parentheses_locs = {}

        for i, c in enumerate(s):
            if c == '(':
                stack.append(i)
            elif c == ')':
                try:
                    parentheses_locs[stack.pop()] = i
                except IndexError:
                    raise IndexError('Too many close parentheses at index {}'
                                     .format(i))
        if stack:
            raise IndexError('No matching close parenthesis to open parenthesis '
                             'at index {}'.format(stack.pop()))
        return parentheses_locs

    def paren_dict_func(self, formula):
        test_strings = [str(formula)]
        # print('paren_dict_func 1')
        for i, s in enumerate(test_strings, start=1):
            # print('paren_dict_func 2',s)
            '''
            fd = open('h.txt',"w")
            fd.write(s)
            fd.close()
            '''
            # print('\ntest string {}:\n{}'.format(i, s))
            if (self.check_parentheses(s)):
                # print('paren_dict_func 3')
                try:
                    # print('paren_dict_func 4',s)

                    parentheses_locs = self.find_parentheses(s)
                    # print('paren_dict_func 4',parantheses_locs)
                except IndexError as e:
                    print(str(e))

        return parentheses_locs

    def find_match_paren(self, formula, index):
        test_strings = [str(formula)]

        for i, s in enumerate(test_strings, start=1):
            # print('\ntest string {}:\n{}'.format(i, s))
            if (self.check_parentheses(s)):
                try:
                    # print(s)
                    parentheses_locs = self.find_parentheses(s)
                    # print(type(parentheses_locs))
                    # print('Parentheses locations:\n{}'.format(str(sorted([(k,v) for k, v in parentheses_locs.items()]))))
                    # print('\n s'+s+'\n\n\n ngirhdg')
                    '''
                    for k in sorted(parentheses_locs.keys()):
                        #print(k,parentheses_locs[k])
                        #print(s[k+1:k+4])
                        #print('--')
                        if s[k+1:k+4] == 'let':

                            print(s[k:parentheses_locs[k]])
                            print('\n')
                    '''
                    # print('hio',type(parantheses_locs))

                except IndexError as e:
                    print(str(e))

        min_after_index = len(str(formula)) - 1
        next_open_index = len(str(formula)) - 1
        # print(min_after_index,next_open_index,index)
        for open_br in parentheses_locs:
            # print('in here')
            if open_br > index and open_br < min_after_index:
                min_after_index = open_br

        # print('aiai',str(formula)[min_after_index:parentheses_locs[min_after_index]+1])
        # print('aiaiai',str(formula)[min_after_index:parentheses_locs[min_after_index]])
        # print('min_after_index',min_after_index,str(formula)[min_after_index:parentheses_locs[min_after_index]+1])
        # exit()
        # print('a!i defn :',str(formula)[min_after_index:parentheses_locs[min_after_index]])
        # print('min_after_index',min_before_index)
        '''
        min_before_index = 0
        for open_br in parentheses_locs:
                        #print('in here')
                        if open_br < index and open_br > min_before_index:
                            min_before_index = open_br
        print('min_before_index',min_before_index,str(formula)[min_before_index:parentheses_locs[min_before_index]])
        #print('a!i defn2 :',str(formula)[min_before_index:parentheses_locs[min_before_index]])
        '''
        close_br = parentheses_locs[min_after_index]
        # print('index of the close_br',close_br)
        # print('a!i defn3 :',close_br_min_before_index,str(formula)[ close_br_min_before_index:])
        for open_br in parentheses_locs:
            # print('in here')
            if open_br > close_br and open_br < next_open_index:
                next_open_index = open_br
        # print('next_open_index',next_open_index)
        # print('formula[next_open_ind:close]',str(formula)[next_open_index:parentheses_locs[next_open_index]+1])
        # print(';;;;;;;;;;;;;;;;;;;;;;;;')
        return (str(formula)[min_after_index:parentheses_locs[min_after_index] + 1], next_open_index, parentheses_locs)

    # returns string which conjuncts the input clauses provided in infix notation
    def inf_to_pre(self, inf):
        operators = ['<=', '>=', '<', '>', '=']

        list_prefix = []

        for eq in inf:
            for o in operators:
                res = eq.find(o)
                # print(res)
                # print(eq)
                if not (res == -1):
                    if o == '<=' or '>=':
                        list_prefix.append('(' + o + ' ' + eq[0:res] + ' ' + eq[res + 1:] + ')')
                        break
                    else:
                        list_prefix.append('(' + o + ' ' + eq[0:res] + ' ' + eq[res:] + ')')
                        break
            if res == -1:
                list_prefix.append(eq)
        return list_prefix

    def elim_pred_in_formula(self, formula, fname, vars_dict, pred_meaning):
        fd = open(self.folder_path + str(fname) + '.py', "w")

        fd.write('from z3 import *\n')
        for var in vars_dict:
            fd.write(str(var) + ' = ' + str(vars_dict[var]) + '(\'' + str(var) + '\')\n')
        fd.write('\n')
        for p in self.pred_string_dict:
            fd.write(str(p) + '=' + 'Bool(\'' + str(p) + '\')\n')
        fd.write('\n')
        alist = []
        # print('self.pred_meaning',self.pred_meaning)
        for pred in pred_meaning:
            fd.write(str(pred) + ' = (' + str(pred_meaning[pred]).replace('=', '==').replace('>==', '>=').replace('<==',
                                                                                                                  '<=') + ')\n')
            alist.append(str(pred) + ' = ' + str(pred_meaning[pred]) + ',')

        a_str = ''
        fd.write('\n')
        for a in alist:
            a_str = a_str + str(a).replace('=', '==').replace('<==', '<=').replace('>==', '>=')
        # print('str(formula)',str(formula))
        # [ f_sl.write(str(clause).replace(' ','')) for clause in str(formula).split(',')]
        # f_sl.write('a_src_formula = Bool('+'\''+'a_src_formula'+'\''+')\n')
        # f_sl.write('a_src_formula = '+str(formula).replace('\n','')+'\n')
        # print('formula just before simplify statement',formula)
        fd.write('a=simplify(And(' + str(formula).replace('\n', '') + '))\n')
        fd.write('print(a.sexpr())\n')
        fd.close()

        cmd = 'python3 ' + str(self.folder_path) + str(fname) + '.py > ' + str(self.folder_path) + str(fname) + '.txt'
        os.system(cmd)
        f_txt = open(self.folder_path + str(fname) + '.txt', "r")
        str_prefix = f_txt.read()
        if not (str_prefix.find('let') == -1):
            str_prefix = self.eliminate_let(str_prefix)
        return str_prefix

    def dump_to_smt_file(self, c_src, c_tgt, a_src, a_tgt, tr):

        # preprocessing
        # print("In dump_to_smt_file")
        # print("a_src",a_src)
        # print('yay',c_src,c_tgt,a_src,a_tgt,self.vars_in_c_src,self.vars_in_c_src_p,tr)
        # print(type(self.vars_in_c_src),type(self.vars_in_c_src_p))
        self.vars_in_c_src_str = ''
        for v in self.vars_in_c_src:
            self.vars_in_c_src_str = self.vars_in_c_src_str + ' ' + v

        self.vars_in_c_src_U_str = self.vars_in_c_src_str.replace('_', 'U')
        self.vars_in_c_src_str_for_p = ''
        for v in self.vars_in_c_src:
            if v.find('pc') == -1:
                self.vars_in_c_src_str_for_p = self.vars_in_c_src_str_for_p + ' ' + v

        # print('hereeeeeeeeeeeeeeeeeeeee',self.vars_in_c_src_str)
        self.vars_in_c_src_U_str_for_p = self.vars_in_c_src_str_for_p.replace('_', 'U')
        self.vars_in_c_src_strp = ''
        # print('\n\n yay %s \n\n' %(a_src))
        for v in self.vars_in_c_src_p:
            self.vars_in_c_src_strp = self.vars_in_c_src_strp + ' ' + v
        # print('hereee',self.vars_in_c_src_strp)
        self.vars_in_c_src_U_strp = self.vars_in_c_src_strp.replace('_', 'U')
        comments = ';;c_src ' + str(c_src).replace('\n', ' ') + '\n' + ';;c_tgt ' + str(c_tgt).replace('\n',
                                                                                                       ' ') + '\n' + ';;a_src ' + str(
            a_src).replace('\n', ' ') + '\n' + ';;a_tgt ' + str(a_tgt).replace('\n', ' ') + '\n' + ';;tr ' + str(
            tr).replace('\n', ' ') + '\n\n'

        # tr without new line
        # print('tr',tr)
        tr_string = str(tr)
        '''
        print("program_path",self.program_path)
        print((str(self.program_path).split('/')[-1])[:-5])
        exit(0)
        '''
        # writing to file starts here
        filename = (str(self.program_path).split('/')[-1])[:-5] + "_Query" + str(self.num_new_preds) + ".smt2"
        f = open(self.folder_path + filename, "w")

        f.write(comments)

        # define c_src function
        c_src_fun = '(define-fun c_src ('

        for x in self.vars_in_c_src:
            c_src_fun = c_src_fun + '(' + str(x) + ' ' + str(self.vars_in_c_src[x]) + ')'
        c_src_fun = c_src_fun + ') Bool ' + str(c_src).replace('\n', '').replace('  ', '') + ')\n'
        c_src_fun_U = c_src_fun.replace('_', 'U')
        f.write(c_src_fun_U)
        f.write('\n')
        # define a_src_final function
        a_src_fun = '(define-fun a_src ('
        for x in self.vars_in_c_src:
            a_src_fun = a_src_fun + '(' + str(x) + ' ' + str(self.vars_in_c_src[x]) + ')'
        a_src_fun = a_src_fun + ') Bool  ' + str(a_src).replace('\n', '').replace('  ', '') + ')\n'
        a_src_fun_U = a_src_fun.replace('_', 'U')
        f.write(a_src_fun_U)
        f.write('\n')
        # define a_tgt function
        a_tgt_fun = '(define-fun a_tgt ('

        for x in self.vars_in_c_src:
            a_tgt_fun = a_tgt_fun + '(' + str(x) + ' ' + str(self.vars_in_c_src[x]) + ')'
        a_tgt_fun = a_tgt_fun + ') Bool  ' + str(a_tgt).replace('\n', '') + ')\n'
        a_tgt_fun_U = a_tgt_fun.replace('_', 'U')
        f.write(a_tgt_fun_U)

        f.write('\n')

        # define trans function
        trans_fun = '(define-fun trans('

        for x in self.vars_in_c_src:
            trans_fun = trans_fun + '(' + str(x) + ' ' + str(self.vars_in_c_src[x]) + ' )'

        for x in self.vars_in_c_src_p:
            trans_fun = trans_fun + '(' + str(x) + ' ' + str(self.vars_in_c_src_p[x]) + ')'

        trans_fun = trans_fun + ') Bool  ' + tr + ')\n\n'
        for x in self.vars_in_c_src:
            trans_fun = trans_fun + '(declare-fun ' + str(x).replace('_', 'U') + '()  ' + str(
                self.vars_in_c_src[x]) + ' )\n'

        for x in self.vars_in_c_src_p:
            trans_fun = trans_fun + '(declare-fun ' + str(x).replace('_', 'U') + '()  ' + str(
                self.vars_in_c_src_p[x]) + ' )\n'
        trans_fun = trans_fun + '\n'
        trans_fun_U = trans_fun.replace('_', 'U')
        f.write(trans_fun_U)

        # constraint 1
        constraints = []

        # (assert (exists ((hpU1 Int)(lpU0 Int)(countpU0 Int)(hpU0 Int)(countpU1 Int)(lpU1 Int)) (and (aUsrc  hU1 lU0 countU0 hU0 countU1 lU1) (trans  hU1 lU0 countU0 hU0 countU1 lU1 hpU1 lpU0 countpU0 hpU0 countpU1 lpU1) (not (not (aUtgt  hpU1 lpU0 countpU0 hpU0 countpU1 lpU1))))))
        # print()
        one = '(assert (exists ('

        for x in self.vars_in_c_src:
            one = one + '(' + str(x).replace('_', 'pU') + ' ' + str(self.vars_in_c_src[x]) + ' )'

        one = one + ')(and (aUsrc ' + self.vars_in_c_src_U_str + ') (trans ' + self.vars_in_c_src_U_str + self.vars_in_c_src_U_strp + ') (not (not (aUtgt ' + self.vars_in_c_src_U_strp + '))))))\n'
        f.write(one)
        two = '(assert (aUsrc ' + self.vars_in_c_src_U_str + '))'
        f.write(two)
        f.write('\n(check-sat)')
        f.write('\n(get-model)')
        f.close()
        p_sol_filename = 'p_sol_' + str(self.num_new_preds) + '.txt'
        # print('before run.sh qe.cpp ',self.num_new_preds)
        cmd1 = "./run.sh qe.cpp " + self.folder_path + filename + " >" + self.folder_path + p_sol_filename
        # cmd2 ="./query"+str(self.num_new_preds)+" "+"query"+str(self.num_new_preds)+".smt2 >" + filename
        # cmd = './run.sh query'+str(self.num_new_preds)+'.smt2 >'+ filename
        # print('Running: '+cmd1)
        '''
        cmd = './cvc4-1.8-x86_64-linux-opt --sygus-active-gen=enum query'+str(self.num_new_preds)+'.sl >'+ filename
        '''
        os.system(cmd1)
        p_sol_fd = open(self.folder_path + p_sol_filename, "r")
        # print('writing to file '+p_sol_filename)
        # return part of file after 'after'
        datafile = p_sol_fd.readlines()
        p_sol_fd.close()
        # print('datafile',datafile)
        for line_no in range(len(datafile)):
            if datafile[line_no].__contains__('After'):
                # print("Contains")
                new_predicate = '\n'.join(datafile[line_no + 1:])
                break
        # print('new_predicate',new_predicate);

        # new_predicate = ''.join(p_sol_fd.readlines())

        # new_predicate = '(define-fun p ((h_1 Int) (l_0 Int) (count_0 Int) (h_0 Int) (count_1 Int) (l_1 Int)) Bool (and (= h_0 h_1) (= count_1 count_0)))'

        # print('new_predicate_is_'+str(new_predicate)+'_jnj')
        # print('new_predicate',new_predicate)
        if len(new_predicate) > 2:
            new_predicate = new_predicate.replace('U', '_')
            rule = self.add_new_predicate_smt(new_predicate, 'synth')
        else:
            exit()
            rule = 'unknown'
        print('rule', rule)
        # exit()
        return rule

    def add_p_to_vars_in_formula(self, formula, ktimes):
        space_seperated_list_of_formula = ((str(formula).replace('(', ' ( ')).replace(')', ' ) ')).split()
        # print('space_seperated_list ',space_seperated_list_of_formula)
        # print('self.vars_in_c_src',self.vars_in_c_src)
        for j in range(0, ktimes):
            for index in range(len(space_seperated_list_of_formula)):
                for concrete_var in self.vars_in_c_src:

                    if concrete_var[:-2] == (space_seperated_list_of_formula[index])[0:len(concrete_var) - 2] and (
                            ((space_seperated_list_of_formula[index])[-2]) == '_'):
                        space_seperated_list_of_formula[index] = (space_seperated_list_of_formula[index])[
                                                                 0:(len(concrete_var) - 2)] + 'p' + (
                                                                                                    space_seperated_list_of_formula[
                                                                                                        index])[
                                                                                                    len(concrete_var) - 2:]
                        break

        return ' '.join(space_seperated_list_of_formula)

    '''      
    def write_to_iz3(self):
        #declare variables

        print('self.i_folder_path',self.i_folder_path)
        print('self.i_fname',self.i_fname)
        print('length of trace', len(self.trc))
        print('var_string_dict', self.dynamic_program.var_string_dict)
        print('cinit', (self.dynamic_program.init_condition).sexpr())
        print('tr0',self.eliminate_let((self.dynamic_program.copy_0).sexpr()))
        print('after adding p to tr0 ', self.add_p_to_vars_in_formula(self.eliminate_let((self.dynamic_program.copy_0).sexpr()),2))
        print('tr1',self.eliminate_let((self.dynamic_program.copy_1).sexpr()))
        print('tr2',self.eliminate_let((self.dynamic_program.copy_2).sexpr()))
        print('cex trace states', self.cex_trace_states)
        print('self.pred_meaning',self.pred_meaning)
        for i in range(len(self.cex_trace_states)):
            print('abst as formula', self.abs_st_as_formula(i))
            print('after eliminating',self.elim_pred_in_formula(self.abs_st_as_formula(i),str(i+4),self.vars_in_c_src,self.pred_meaning))   
            print('after adding p',self.add_p_to_vars_in_formula(self.elim_pred_in_formula(self.abs_st_as_formula(i),str(i+4),self.vars_in_c_src,self.pred_meaning),2))     
        print('second coord list',self.trace_second_coord)
        print('h', (self.dynamic_program.h).sexpr())
        print('hp',(self.dynamic_program.h_p).sexpr())

        print('self.pred_meaning_p',self.pred_meaning_p)
        print(str(self.i_folder_path)+str(self.i_fname)+'.iz3')


        #create an iz3 file        
        f_iz3 = open(str(self.i_folder_path)+str(self.i_fname)+'_iz3'+'.smt2',"w") 

        for key,value in self.dynamic_program.var_string_dict.items():
            key_n_p = str(key)
            for index in (range(len(self.cex_trace_states))):
                f_iz3.write('(declare-const '+key_n_p+' Int )\n')
                key_n_p = str(key_n_p)[:-2]+'p'+str(key_n_p)[-2:]  
        f_iz3.write('(compute-interpolant \n')
        #abs_st0 = self.elim_pred_in_formula(self.abs_st_as_formula(0),str((len(self.cex_trace_states))+5),self.vars_in_c_src,self.pred_meaning)
        #f_iz3.write(''+abs_st0+'\n')
        f_iz3.write('       '+str((self.dynamic_program.init_condition).sexpr())+' \n')        
        tr = self.eliminate_let(self.dynamic_program.find_tr(self.trace_second_coord[0]).sexpr())
        f_iz3.write('       '+str(tr)+' \n')       
        for i in range(1, len(self.cex_trace_states)-1):                    
            #abs_st = self.elim_pred_in_formula(self.abs_st_as_formula(i),str(i+4),self.vars_in_c_src,self.pred_meaning)
            #abs_st_add_p_i_times = self.add_p_to_vars_in_formula(abs_st,i)
            #f_iz3.write('       '+abs_st_add_p_i_times+' \n')            
            tr = self.eliminate_let(self.dynamic_program.find_tr(self.trace_second_coord[i]).sexpr())
            tr_add_p_i_times = self.add_p_to_vars_in_formula(tr,i)
            f_iz3.write('       '+tr_add_p_i_times+' \n')
        abs_st = self.elim_pred_in_formula(self.abs_st_as_formula((len(self.cex_trace_states))-1),str((len(self.cex_trace_states))+4),self.vars_in_c_src,self.pred_meaning)
        abs_st_add_p_i_times = self.add_p_to_vars_in_formula(abs_st,(len(self.cex_trace_states))-1)
        f_iz3.write('       '+abs_st_add_p_i_times+')')                                                                
        f_iz3.close()

        iz3_cmd = './z3 '+str(self.i_folder_path)+str(self.i_fname)+'_iz3'+'.smt2 > '+str(self.i_folder_path)+str(self.i_fname)+'_iz3'+'.txt'
        os.system(iz3_cmd)
    '''

    def write_to_msat(self):
        # declare variables
        # create an msat file
        f_msat = open(str(self.i_folder_path) + str(self.i_fname) + '_msat' + '.smt2', "w")
        f_msat.write('(set-logic AUFLIA)\n')
        f_msat.write('(set-option :produce-interpolants true) \n\n')

        for key, value in self.dynamic_program.var_string_dict.items():
            key_n_p = str(key)
            for index in (range(len(self.cex_trace_states))):
                f_msat.write('(declare-fun ' + key_n_p + ' ()  Int )\n')
                key_n_p = str(key_n_p)[:-2] + 'p' + str(key_n_p)[-2:]
                # f_msat.write('(compute-interpolant \n')
        f_msat.write('(define-fun A_0 () Bool  ' + str((self.dynamic_program.init_condition).sexpr()) + ' )\n')

        tr = self.eliminate_let(self.dynamic_program.find_tr(self.trace_second_coord[0]).sexpr())
        f_msat.write('(define-fun A_1 () Bool  ' + str(tr) + ') \n')
        ip_i = 2
        if len(self.cex_trace_states) > 2:
            for i in range(1, len(self.cex_trace_states) - 1):
                f_msat.write('(define-fun A_' + str(ip_i) + ' () Bool  ')

                tr = self.eliminate_let(self.dynamic_program.find_tr(self.trace_second_coord[i]).sexpr())
                tr_add_p_i_times = self.add_p_to_vars_in_formula(tr, i)
                f_msat.write(' ' + tr_add_p_i_times + ' )\n')
                ip_i = ip_i + 1
        abs_st = self.elim_pred_in_formula(self.abs_st_as_formula((len(self.cex_trace_states)) - 1),
                                           str((len(self.cex_trace_states)) + 4), self.vars_in_c_src, self.pred_meaning)
        abs_st_add_p_i_times = self.add_p_to_vars_in_formula(abs_st, (len(self.cex_trace_states)) - 1)
        f_msat.write('(define-fun A_' + str(ip_i) + '() Bool      ' + abs_st_add_p_i_times + ')\n\n')
        for ind in range(0, ip_i + 1):
            f_msat.write('(assert ( ! A_' + str(ind) + ' :interpolation-group g' + str(ind) + '))\n')
        f_msat.write('( check-sat )\n')

        for ind in range(1, ip_i + 1):
            g_str = ''
            for ind2 in range(0, ind):
                g_str = g_str + ' g' + str(ind2)
            f_msat.write('( get-interpolant (' + g_str + '))\n')
        f_msat.write('(exit)')
        f_msat.close()
        # run it
        msat_cmd = './mathsat ' + str(self.i_folder_path) + str(self.i_fname) + '_msat' + '.smt2 > ' + str(
            self.i_folder_path) + str(self.i_fname) + '_msat' + '.txt'
        os.system(msat_cmd)

    def write_to_smtInt(self):
        # declare variables
        # create an smtInterpol file
        f_smtInt = open(str(self.i_folder_path) + str(self.i_fname) + '_smtInt' + '.smt2', "w")
        f_smtInt.write('(set-option :print-success false)\n(set-option :produce-proofs true)\n(set-logic QF_LIA)\n')
        for key, value in self.dynamic_program.var_string_dict.items():
            key_n_p = str(key)
            for index in (range(len(self.cex_trace_states))):
                f_smtInt.write('(declare-fun ' + key_n_p + ' () Int )\n')
                key_n_p = str(key_n_p)[:-2] + 'p' + str(key_n_p)[-2:]
                # f_smtInt.write('(compute-interpolant \n')
        f_smtInt.write('( assert (!  ' + str((self.dynamic_program.init_condition).sexpr()) + ' :named IP_0))\n')
        tr = self.eliminate_let(self.dynamic_program.find_tr(self.trace_second_coord[0]).sexpr())
        f_smtInt.write('( assert (!  ' + str(tr) + ' :named IP_1 )) \n')

        ip_i = 2

        for i in range(1, len(self.cex_trace_states) - 1):
            # abs_st = self.elim_pred_in_formula(self.abs_st_as_formula(i),str(i+4),self.vars_in_c_src,self.pred_meaning)
            # abs_st_add_p_i_times = self.add_p_to_vars_in_formula(abs_st,i)
            # f_smtInt.write('       '+abs_st_add_p_i_times+' \n')
            tr = self.eliminate_let(self.dynamic_program.find_tr(self.trace_second_coord[i]).sexpr())
            tr_add_p_i_times = self.add_p_to_vars_in_formula(tr, i)

            f_smtInt.write(' (assert (!  ' + tr_add_p_i_times + ' :named IP_' + str(ip_i) + ' )) \n')

            ip_i = ip_i + 1

        abs_st = self.elim_pred_in_formula(self.abs_st_as_formula((len(self.cex_trace_states)) - 1),
                                           str((len(self.cex_trace_states)) + 4), self.vars_in_c_src, self.pred_meaning)
        abs_st_add_p_i_times = self.add_p_to_vars_in_formula(abs_st, (len(self.cex_trace_states)) - 1)
        f_smtInt.write('(assert (! ' + abs_st_add_p_i_times + ' :named IP_' + str(ip_i) + '))\n')
        f_smtInt.write('(check-sat)\n')
        IP_str = ' '

        for i in range(0, ip_i + 1):
            IP_str = IP_str + 'IP_' + str(i) + ' '

        f_smtInt.write('(get-interpolants ' + IP_str + ')\n')
        f_smtInt.write('(exit)')
        f_smtInt.close()
        # run it
        smtInt_cmd = 'java -jar smtinterpol.jar ' + str(self.i_folder_path) + str(
            self.i_fname) + '_smtInt' + '.smt2 > ' + str(self.i_folder_path) + str(self.i_fname) + '_smtInt' + '.txt'
        os.system(smtInt_cmd)

    def match_paren_index(self, formula, index):
        # print(formula,index)
        paren_dic = self.find_parentheses(formula)
        # print(paren_dic)
        return paren_dic[index]

    def find_next_open_paren(self, formula, cl_index):
        if cl_index < len(formula) - 1:
            paren_dic = self.find_parentheses(formula)
            op_index = len(formula) - 1
            for i, val in paren_dic.items():
                if i > cl_index and i < op_index:
                    op_index = i
        else:
            op_index = -1
        return op_index

    def get_interpolants_from_file(self, solver_name):
        if solver_name == 'smtInt':
            f_smtInt = open(str(self.i_folder_path) + str(self.i_fname) + '_smtInt' + '.txt')
            # read inplts
            lines = f_smtInt.readlines()

            print('lines', lines)
            num_of_lines = len(lines)
            print('num_of_lines ', num_of_lines)
            if not (lines[1].find('UNSAT') == -1):
                return ['-1']
            f_smtInt.close()
            # if only 1 line, then unsat and no interpolants because (check-sat)'s output is in first line.
            if not (num_of_lines <= 1):
                # lines = ((inplt1)(inplt2)..(inpltn)) for smtInt
                # lines = (inplt1\n)(inplt2\n)..(inpltn\n) for msat
                lines[1] = lines[1].replace('\n', '')
                if (lines[1][-1] == ' '):
                    lines[1] = lines[1][:-1]
            interpolants = str(str(lines[1])[1:][:-1])
        else:
            f_msat = open(str(self.i_folder_path) + str(self.i_fname) + '_msat' + '.txt')
            # read inplts
            lines = f_msat.readlines()
            num_of_lines = len(lines)
            print('num_of_lines', num_of_lines)
            if not (lines[1].find('UNSAT') == -1):
                return ['-1']
            # if only 1 line, then unsat and no interpolants because (check-sat)'s outputis in first line.
            if not (num_of_lines <= 1):
                lines = [l.replace('\n', '') for l in lines]
                lines = lines[1:]
                interpolants = ' '.join(lines)
            print('lines', lines)
            f_msat.close()
        return interpolants

    def create_inplt_list(self, interpolants):
        open_ind = 0
        inplt_list = []
        while open_ind < len(interpolants) and open_ind >= 0:
            cl_ind = self.match_paren_index(interpolants, open_ind)
            # cl_ind = interpolant_let.paren_dict[open_ind]
            if interpolants[open_ind:cl_ind + 1].find('let') == -1:
                inplt_list = inplt_list + [interpolants[open_ind:cl_ind + 1]]
                # print(open_ind, interpolants[open_ind:cl_ind+1])
            else:
                inplt_let = LetEliminatorClass(interpolants[open_ind:cl_ind + 1])
                print([inplt_let.final_formula])

                inplt_list = inplt_list + [inplt_let.final_formula]
            open_ind = self.find_next_open_paren(interpolants, cl_ind)
        print('inplt_list_before', inplt_list)
        for i in range(len(inplt_list)):
            inplt_list[i] = re.sub('\s+', ' ',
                                   inplt_list[i].replace('pp', '').replace('p_', '_').replace('(', ' ( ').replace(')',
                                                                                                                  ' ) '))
        # print('1',inplt_list)
        return inplt_list

    def obtain_sub_formulas_from_inplt_list(self, inplt_list):
        # op_ind_inplt is indices of operands in inplt
        print('here')
        op = ['<=', '>=', '< ', ' > ', ' = ']
        sub_formulas = []
        for inplt in inplt_list:
            op_ind_inplt = []
            # print(op_ind_inplt)
            for o in op:
                res = [_.start() for _ in re.finditer(o, inplt)]
                if not (o == ' = ' or o == ' > '):
                    op_ind_inplt = op_ind_inplt + res
                else:
                    op_ind_inplt = op_ind_inplt + [x + 1 for x in res]
            print(op_ind_inplt)
            for j in op_ind_inplt:
                a = self.match_paren_index(inplt, j - 2)
                print('a', a)
                sub_formulas = sub_formulas + [inplt[j - 2:a + 1]]
            sub_formulas = sub_formulas
            print('sub_formulas', sub_formulas)

        '''                          
        length = 0
        for l in range(len(sub_formulas)): 

                     space_sep_sub_form= ((sub_formulas[l]).replace(')',' )').replace('(',' ( ')).split(' ')
                     #print('space_sep',space_sep_sub_form)
                     for ind2 in (range(len(space_sep_sub_form))):                                                            
                         if len(space_sep_sub_form[ind2]) > 2 and space_sep_sub_form[ind2][-3] == 'p' and space_sep_sub_form[ind2][-2] == '_':
                             space_sep_sub_form[ind2] = str(space_sep_sub_form[ind2])[:-3] +str(space_sep_sub_form[ind2])[-2:]
                         #elif len(space_sep_sub_form[ind2]) > 1 and not(space_sep_sub_form[ind2][-2] == '_') and  space_sep_sub_form[ind2][-1] == 'p':
                             #space_sep_sub_form[ind2] = str(space_sep_sub_form[ind2])[:-3] [:-1]
                         #else:
                             #m = True    
                     sub_formulas[l] = ' '.join(space_sep_sub_form)
                     print(sub_formulas[l])  
        '''
        # sub_formulas = sub_formulas))
        return sub_formulas

    def get_unique_subformulas(self, sub_formulas):
        unique_sub = []
        for i in range(len(sub_formulas)):
            if sub_formulas[i] not in unique_sub:
                unique_sub.append(sub_formulas[i])
        print(unique_sub)
        return unique_sub

    def post_iplt_simplify(self, solver_name):
        interpolants = self.get_interpolants_from_file(solver_name)
        if interpolants == ['-1']:
            return ['-1']
        inplt_list = self.create_inplt_list(interpolants)
        sub_formulas = self.obtain_sub_formulas_from_inplt_list(inplt_list)
        # print(sub_formulas)

        num = 0
        pred_list = []
        if (self.num_new_preds + 1) % 3 != 0:
            sub_formulas.sort(key=len, reverse=True)
        else:
            sub_formulas.sort(key=len)
        print(sub_formulas)
        sub_formulas = self.get_unique_subformulas(sub_formulas)
        sub_formulas = self.remove_subs_with_substrings(sub_formulas, ['int', 'real'])
        # exit()
        num = 0
        while num < len(sub_formulas):
            sub_formulas[num] = sub_formulas[num].replace('<= (', '= (')
            if not (sub_formulas[num].find('*') == -1) or not (sub_formulas[num].find('+') == -1):
                sub_formulas[num] = sub_formulas[num].replace('<=', '=')
            eq = self.check_eq_with_existing_pred(sub_formulas[num])
            print(sub_formulas[num])
            if str(eq) == 'False':
                print('neq')
                if not (self.check_weaker_than_existing_pred(sub_formulas[num])):
                    print('not weaker, add')
                    pred = self.add_new_predicate_smt(sub_formulas[num], '0_synth_msat')
                    pred_list.append(pred)
                    if len(re.findall('[a-zA-Z]+', sub_formulas[num])) == 2 and sub_formulas[num].find('+') == -1:
                        if not (self.check_eq_with_existing_pred(
                                sub_formulas[num].replace(' <=', ' <').replace('_0', '').replace('_1', ''))):
                            print(sub_formulas[num])
                            pred = self.add_new_predicate_smt(
                                sub_formulas[num].replace(' <=', ' <').replace('_0', '').replace('_1', ''), '1_synth_msat')
                            pred_list.append(pred)
                            return pred_list
                    print('6')
                    break
            print('eq')
            num = num + 1
        print('After first pass of sub_formulas', len(pred_list))
        num = 0
        if len(pred_list) == 0:
            while num < len(sub_formulas):
                sub_formulas[num] = sub_formulas[num].replace(' = (', ' <= (')
                eq = self.check_eq_with_existing_pred(sub_formulas[num])
                if str(eq) == 'False':
                    # if not(self.check_weaker_than_existing_pred(sub_formulas[num])):
                    pred = self.add_new_predicate_smt(sub_formulas[num], 'synth_msat')
                    pred_list.append(pred)
                    print('2')
                    break
                num = num + 1

        return pred_list

    def check_eq_with_existing_pred(self, formula):
        # given a formula, check if semantically equivalent to existing predicates
        f_z3 = open(self.folder_path + "eq_existing_z3.smt2", "w")
        for key, value in self.pred_meaning.items():
            f_z3.write(';' + str(value) + '\n')
        f_z3.write(';' + str(formula) + '\n')
        # declare vars
        for i in range(len(self.list_vars)):
            f_z3.write('(declare-const ' + str(self.list_vars[i]) + ' ' + str(self.list_types[i]) + ')\n')
            f_z3.write('(declare-const ' + str(self.list_vars[i]) + '_0 ' + str(self.list_types[i]) + ')\n')
            f_z3.write('(declare-const ' + str(self.list_vars[i]) + '_1 ' + str(self.list_types[i]) + ')\n')
        # declare predicates
        for k, v in self.pred_meaning.items():
            f_z3.write('(declare-const ' + str(k) + ' ' + 'Bool' + ')\n')
        f_z3.write('(push)\n')
        # check if the formula is satisfiable
        f_z3.write('(assert ' + str(formula) + ')\n')
        f_z3.write('(check-sat)\n')
        # f_z3.write('(get-model)\n')
        f_z3.write('(pop)\n')
        # check bijection of each predicate with formula.
        for key, value in self.pred_meaning.items():
            # print('key',type(key))

            f_z3.write('(push)\n')
            f_z3.write('(assert (and ' + str(formula) + ' (not ' + str(key) + ') ' + str(
                (self.dynamic_program.h).sexpr()) + '))\n')
            f_z3.write('(check-sat)\n')
            f_z3.write('(pop)\n')

            f_z3.write('(push)\n')
            f_z3.write('(assert (and (not ' + str(formula) + ') ' + str(key) + ' ' + str(
                (self.dynamic_program.h).sexpr()) + '))\n')
            f_z3.write('(check-sat)\n')
            f_z3.write('(pop)\n')
        f_z3.close()
        cmd = 'z3 ' + self.folder_path + 'eq_existing_z3.smt2 > ' + self.folder_path + 'eq_existing_z3.txt'
        os.system(cmd)
        f_eq = open(self.folder_path + "eq_existing_z3.txt", "r")
        lines = f_eq.readlines()
        f_eq.close()
        no_of_lines = len(lines)
        # check if pred /\ !formula is unsat and !pred /\ formula is unsat for some pred in predicates, if so then return true
        cnt = 0

        if str(lines[0]) == 'unsat\n':
            return True
        cnt = 1
        while cnt < (no_of_lines - 1):
            if str(lines[cnt]) == 'unsat\n' and str(lines[cnt + 1]) == 'unsat\n':
                return True
            else:
                # print(cnt)
                cnt = cnt + 2

        return False

    def check_weaker_than_existing_pred(self, formula):
        # given a formula, check if semantically equivalent to existing predicates
        f_z3 = open(self.folder_path + "eq_existing_z3.smt2", "w")
        for key, value in self.pred_meaning.items():
            f_z3.write(';' + str(value) + '\n')
        f_z3.write(';' + str(formula) + '\n')
        # declare vars
        for i in range(len(self.list_vars)):
            f_z3.write('(declare-const ' + str(self.list_vars[i]) + '_0 ' + str(self.list_types[i]) + ')\n')
            f_z3.write('(declare-const ' + str(self.list_vars[i]) + '_1 ' + str(self.list_types[i]) + ')\n')
        # declare predicates
        for k, v in self.pred_meaning.items():
            f_z3.write('(declare-const ' + str(k) + ' ' + 'Bool' + ')\n')

        # check bijection of each predicate with formula.
        for key, value in self.pred_meaning.items():
            # print('key',type(key))

            f_z3.write('(push)\n')
            f_z3.write('(assert (and ' + str(formula) + ' (not ' + str(key) + ') ' + str(
                (self.dynamic_program.h).sexpr()) + '))\n')

            f_z3.write('(check-sat)\n')
            f_z3.write('(pop)\n')

            f_z3.write('(push)\n')
            f_z3.write('(assert (and (not ' + str(formula) + ') ' + str(key) + ' ' + str(
                (self.dynamic_program.h).sexpr()) + '))\n')
            f_z3.write('(check-sat)\n')
            f_z3.write('(pop)\n')

        f_z3.close()
        cmd = 'z3 ' + self.folder_path + 'eq_existing_z3.smt2 > ' + self.folder_path + 'eq_existing_z3.txt'
        os.system(cmd)
        f_eq = open(self.folder_path + "eq_existing_z3.txt", "r")
        lines = f_eq.readlines()
        f_eq.close()
        no_of_lines = len(lines)
        # check if pred /\ !formula is unsat and !pred /\ formula is unsat for some pred in predicates, if so then return true
        cnt = 0
        while cnt < (no_of_lines - 1):
            if str(lines[cnt]) == 'unsat\n' and str(lines[cnt + 1]) == 'sat\n':
                return True
            else:
                # print(cnt)
                cnt = cnt + 2
        return False

    def remove_subs_with_substrings(self, sub_formulas, substring_list):
        sub_formulas_wo_substring = []
        for sub in sub_formulas:
            flag = 0
            for s in substring_list:
                if not (sub.find(s) == -1):
                    flag = 1
            if flag == 0:
                sub_formulas_wo_substring.append(sub)
        return sub_formulas_wo_substring

