import time
import z3
import os
import re
import datetime
import time
from bitstring import BitArray
from comparator_program_transformer import comparator_transform
from program_transformer import transform
from collections import deque
from pathlib import Path

class DynamicSelfCompositionPDR_sygus:
    def __init__(self, program_path, force_predicate_abstraction, is_comparator, explicit_conposition_function,folder_name, method_name=None,concrete_array_vars=False,bmc=False,print_log=False,prop=None):
        #print('dy-sc-pdr,7.1')
        if prop is not None and prop == 1:
            prop=0
        #print('dy-sc-pdr,7.2')
        self.trc = None
        self.force_predicate_abstraction = force_predicate_abstraction
        self.bmc = bmc
        self.concrete_dp = None
        #print('dy-sc-pdr,7.3')
        self.dynamic_program = self.sc_program_from_file(program_path, is_comparator, method_name,concrete_array_vars,prop)
        #print('rel_init',self.dynamic_program.rel_init)
        #print('dy-sc-pdr,7.4')
        self.dynamic_program.use_explicit_conposition_function = explicit_conposition_function

        self.ctx = self.dynamic_program.ctx
        #print('dy-sc-pdr,7.5')
        self.smt_queries_count = 0
        self.lemmas = {}
        self.fp = None
        self.blocked_compositions = {}
        self.longest_abstract_trace = 0
        self.print_log=print_log
        #batch 5 : cex_trace_states
        self.cex_trace_states=[]
        #batch 6 : pred_string_dict
        self.pred_string_dict = dict()
        #list of trace's second coordinates which specify composition = 0,1,2 for its corresponding first coord state
        self.trace_second_coord=[]
        #counts the number of preds added
        #print('dy-sc-pdr,7.6')
        self.num_new_preds = None
        #print('dy-sc-pdr,7.7')
        #print('dy-sc-pdr,7.8')
        self.dict_in_order = dict()
        self.reason_to_add_to_bad = dict()
        #program path added as a field
        self.program_path = program_path
        
        #folder containing temporary files produced by the execution
        self.folder_name = str(folder_name)
        #print("folder_name",self.folder_name)
        self.folder_path = str(Path.cwd())+"/"+str(self.folder_name)+"/"
        #print("folder_path",self.folder_path)
       
	 
    def solve(self,num_new_preds):
        #print('self.dynamic_program.list_in_order',self.dynamic_program.list_in_order)
        self.get_dict()
        #print('solve,1')
        self.num_new_preds = num_new_preds
        num_preds = len(self.dynamic_program.abstract_var_names) if self.dynamic_program.is_predicate_abstraction else 0
        #print('rel_init',self.dynamic_program.rel_init)
        timeout = time.time() + 15
        #print('solve,2')
        trace = self.find_cex()
        if not( trace == None):
            #print('solve,3')
            self.trc = trace
        #print('solve,4')
        #batch 6 : pred_string_dict
        for l in self.dynamic_program.predicates:
                self.pred_string_dict[str(l)]=l
        #print(self.pred_string_dict)
        #print('rel_init',self.dynamic_program.rel_init)
        while trace is not None:
            print('Exploring new composition...\n\n')
            # if time.time() > timeout:
            #     return "Timeout reached",self.smt_queries_count
            #if self.print_log:
            print("Current composition gives an abstract counter-example trace:\n" + self.print_trace(trace))
           #batch 5 : cex_trace_states
            self.update_cex_trace_states(trace)
            #print('solve,8')
            #print("self.cex_trace_states : ",self.cex_trace_states)
            #print('rel_init',self.dynamic_program.rel_init)
            if self.bmc and self.longest_abstract_trace == 0 and len(trace)<4 and self.dynamic_program.k == 3:
                self.longest_abstract_trace = len(trace)
                if self.print_log:
                    print("running bmc of depth "+str(self.longest_abstract_trace))
                if self.run_bmc():
                    return "Counter-example found. Property is violated.", self.smt_queries_count,num_preds

            if not self.dynamic_program.is_predicate_abstraction:
                #print('solve,9')
                return "Counter-example found. Property is violated.",self.smt_queries_count,num_preds
            #print('solve,10')
            if self.dynamic_program.default_composition:
                self.dynamic_program.default_composition = False
                self.dynamic_program.sc_tr = None
                #print('solve,11')

            fixed = self.block_or_extend_bad(trace)
            #print('rel_init',self.dynamic_program.rel_init)
            #print('solve,12 ',fixed)
            #print("fixed = ",fixed)
            #print("self.cex_trace_states",self.cex_trace_states)
            if not fixed:
                #print('solve,13, in not fixed')
                self.print_statistics()
                #print('in not fixed block')
                #complete the trace

                self.trc = self.complete_trace(self.trc)



                #batch 13 : add check_spur bfore starvation
                spur,c_src,c_tgt,a_src,a_tgt,tr_formula,a_src_tr_pos = self.check_spur(self.trc)
                print('\n\n\nIs the abstract trace spurious?', spur)
                #print('a_src: ', a_src)
                #print('a_tgt: ', a_tgt)
                #print('c_src', c_src)
                #print('c_tgt ', c_tgt)
                #print('solve,14')
                #print('trace[a_src_tr_pos][1]',trace[a_src_tr_pos][1])
                #extract tr of the copy
                #print('15',self.trace_second_coord)
                #print('16',a_src_tr_pos)
                #print('17',self.trace_second_coord[a_src_tr_pos])
                tr_copy = self.dynamic_program.find_tr(self.trace_second_coord[a_src_tr_pos])
                #print('rel_init',self.dynamic_program.rel_init)
                #print('18,tr_copy',tr_copy)

                #print("Spuriousness checker returned : ", spur)
                #print("end of check_spur",spur,c_src)
                #batch 16
                if spur == True :
                    #print('solve,19')
                    new_pred_smt_format =  []
                    #print("Discovering new predicate using SyGuS..")
                    new_pred_disc = self.pred_disc(c_src,c_tgt,a_src,a_tgt,tr_formula)
                    if not(new_pred_disc == ['-1']):
                        new_pred_smt_format.append(new_pred_disc)
                    else:
                        print('No predicate discovered in the grammar. SyGuS technique cannot refine further, unable to prove the program safe/unsafe.')
                        exit(0)
                    return "Failed to find semantic self-composition. Either the property is violated or not enough predicates were supplied.",self.smt_queries_count,num_preds,spur,new_pred_smt_format
                    #print('rel_init',self.dynamic_program.rel_init)

                else:
                    #print('solve,21')
                    print("Real cex. Program is unsafe.")
                    #print('rel_init',self.dynamic_program.rel_init)
                    exit()
            trace = self.find_cex()
            #print('solve,22')
            if not(trace == None):
                #print('solve,23')
                #print('rel_init',self.dynamic_program.rel_init)
                self.trc = trace


        #print('solve,24')
        inv = self.get_invariant()
        #print('inv',inv)

        #print('solve,25')
        if self.dynamic_program.is_predicate_abstraction:
            #print('solve,26')
            if not self.check_starvation(inv):
                #print('rel_init',self.dynamic_program.rel_init)
                # invariant starves at least one copy
                #print('solve,27')
                self.print_statistics()
                '''
                print('solve,27.5',self.trace_second_coord)
                spur,c_src,c_tgt,a_src,a_tgt,tr_formula,a_src_tr_pos = self.check_spur(self.trc)
                print('solve,28',self.trace_second_coord)
                print('solve,29 ',a_src_tr_pos)
                print('solve,30 ',self.trace_second_coord[a_src_tr_pos])
                tr_copy = self.dynamic_program.find_tr(self.trace_second_coord[a_src_tr_pos])
                print('solve,31,tr_copy ',tr_copy)
                print('solve,32,spur ',spur)
                if spur == True:
                    print('solve,33,tr_copy')
                    print('rel_init',self.dynamic_program.rel_init)
                    print(tr_copy)
                    new_pred_smt_format = self.pred_disc(c_src,c_tgt,a_src,a_tgt,tr_formula)
                    print('rel_init',self.dynamic_program.rel_init)
                print('solve,34')
                '''


                return "Failed to prove (starvation detected)",self.smt_queries_count,num_preds,False,None
        self.print_statistics()
        #print('rel_init',self.dynamic_program.rel_init)
        return "Proved by invariant:\n" + str(inv),self.smt_queries_count,num_preds,False,None

    def update_cex_trace_states(self,trace):
        list_states = []
        self.cex_trace_states=[]
        for state, move in trace:
            list_states.append(state.pretty_print(self.dynamic_program))
        #print('solve,6')
        for st in list_states:
            st=st[1:-4]
            st = st.replace("\n", "")
            st = st.replace(" ","")
            st = st.split(',')
            #print('solve,7')
        #print(st)
            self.cex_trace_states.append(st)

    def complete_trace(self,trace):
        #print('before complete_trace:',self.print_trace(trace))
        #print('complete_trace 1')
        #print(self.print_trace(trace))
        final = trace[-1][0]

        last_item = trace.pop()
        #print(trace)
        final_as_formula = self.dynamic_program.abstract_state_to_cond(final)
        #print('complete_trace 2, final',final_as_formula)
        #---------check if final is first coordinate of any key in reason_to_add_to_bad-----------
        while True:
            #print('1')
            final_is_in_key = 0
            #print('2')
            for st_comp_pair in self.reason_to_add_to_bad:
                solver_key_is_final = z3.Solver(ctx = self.ctx)
                solver_key_is_final.add(z3.Not(final_as_formula))
                solver_key_is_final.add(st_comp_pair[0])
                if solver_key_is_final.check() == z3.unsat:
                    solver_key_is_final = z3.Solver(ctx = self.ctx)
                    solver_key_is_final.add(final_as_formula)
                    solver_key_is_final.add(z3.Not(st_comp_pair[0]))
                    if solver_key_is_final.check() == z3.unsat:
                        #st_comp_pair[0] is equivalent to bad_pred_reason_as_formula
                        final_is_in_key = 1
                        break
                #print('3')



            #-----------if final isn't in key or if comp_taken is -1, then final is really bad, no need to extend the trace further
            if final_is_in_key == 0 or st_comp_pair[1] == -1:
                #print('8')
                trace.append((final,-1))
                #print('9')
                self.update_cex_trace_states(trace)
                #print('10')
                #print('after complete_trace',self.print_trace(trace))
                #print('last state in trace',self.dynamic_program.abstract_state_to_cond(trace[-1][0]))
                #print('last state in trace',(self.dynamic_program.abstract_state_to_cond(trace[-1][0])).sexpr())
                #print('second last state in trace',self.dynamic_program.abstract_state_to_cond(trace[-2][0]))
                #print('second last state in trace',(self.dynamic_program.abstract_state_to_cond(trace[-2][0])).sexpr())
                return trace
            else:
                if final_is_in_key == 1:
                    comp_taken = st_comp_pair[1]

                    #print('6')
                    reason_as_formula =  self.reason_to_add_to_bad[st_comp_pair]
                        #print('7')
                #print the transition to be added
                #print('complete_trace 3  \n\n final: %s \n comp_taken : %s \n reason %s'%(final_as_formula,comp_taken,reason_as_formula))
                #last item in trace is of form (final,0/1/2), we remove it so that we can add the transition from final that we stored in dict

                #extending trace

                #initialise an abstract state object equivalent to z3 formula : reason_as_formula
                reason = self.dynamic_program.abstract_st_from_z3_st(reason_as_formula)
                #cross check the conversion
                #print(self.dynamic_program.abstract_state_to_cond(reason))
                #update the trace. Warning : comp_taken can be -1, though trace only usually has 0,1,2
                trace.append((final,comp_taken))
                #update the reason to the reason for the current last item in trace
                #update final to the current reason
                final_as_formula = reason_as_formula
                final = self.dynamic_program.abstract_st_from_z3_st(reason_as_formula)

        return trace

    def pred_disc_refine_bad(self,a_tgt):
        #print('----------------------pred_disc_refine_bad-------------------')
        #print('a_tgt',a_tgt)
        a_tgt_original = a_tgt
        #print('pred_disc,004',str(self.dynamic_program.h))
        h_list = (((str(self.dynamic_program.h)[4:])[:-1]).replace(' ','')).rsplit(',\n')
        pred_meaning = dict()

        #print('pred_disc,007')
        [(pred_meaning.update({i.split('==')[0] : ('' +('=='.join(i.split('==')[1:]))[0:]).replace('==','=')})) for i in h_list]
        #print('pred_disc,008')

        hp_list = (((str(self.dynamic_program.h_p)[4:])[:-1]).replace(' ','')).rsplit(',\n')
        #print('hp_list',hp_list)
        pred_meaning_p = dict()
        [(pred_meaning_p.update({i.split('==')[0] : ('' +('=='.join(i.split('==')[1:]))[0:]).replace('==','=')})) for i in hp_list]
        str_vars_list = []
        for v in self.dynamic_program.var_string_dict:
            str_vars_list.append(self.dynamic_program.var_string_dict[v])
        #print('str_vars_list',str_vars_list)
        str_varsp_list = []
        for v in self.dynamic_program.var_string_dict:
            str_varsp_list.append(str(self.dynamic_program.var_string_dict[v])[:-2]+'p'+str(self.dynamic_program.var_string_dict[v])[-2]+str(self.dynamic_program.var_string_dict[v])[-1])
        #print('str_varsp_list',str_varsp_list)
        #------------------------------------------
        vars_type_dict = dict()
        for v in self.dynamic_program.var_string_dict:
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                vars_type_dict[self.dynamic_program.var_string_dict[v]] = 'Int'
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                vars_type_dict[self.dynamic_program.var_string_dict[v]] = 'Bool'
        #print('vars_type_dict',vars_type_dict)
        #--------------------------------------------------------------------
        #------------------------------------------
        varsp_type_dict = dict()
        for v in self.dynamic_program.var_string_dict:
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                varsp_type_dict[str(self.dynamic_program.var_string_dict[v])[:-2]+'p'+str(self.dynamic_program.var_string_dict[v])[-2]+str(self.dynamic_program.var_string_dict[v])[-1]] = 'Int'
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                varsp_type_dict[str(self.dynamic_program.var_string_dict[v])[:-2]+'p'+str(self.dynamic_program.var_string_dict[v])[-2]+str(self.dynamic_program.var_string_dict[v])[-1]] = 'Bool'
        #print('varsp_type_dict',varsp_type_dict)
        #--------------------------------------------------------------------------
        #print(type(a_tgt))
        str_prefix_a_tgt= a_tgt.sexpr()
        if not(str_prefix_a_tgt.find('let') == -1):
            str_prefix_a_tgt = self.eliminate_let(str_prefix_a_tgt)
        #print('str_prefix',str_prefix_a_tgt,type(str_prefix_a_tgt))

        #------------------now collect tr_copy0-----------------

        vars_varsp_type_dict = dict()
        for v in self.dynamic_program.var_string_dict:
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                vars_varsp_type_dict[self.dynamic_program.var_string_dict[v]] = 'Int'
                vars_varsp_type_dict[str(self.dynamic_program.var_string_dict[v])[:-2]+'p'+str(self.dynamic_program.var_string_dict[v])[-2]+str(self.dynamic_program.var_string_dict[v])[-1]] = 'Int'
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                vars_varsp_type_dict[self.dynamic_program.var_string_dict[v]] = 'Bool'
                vars_varsp_type_dict[str(self.dynamic_program.var_string_dict[v])[:-2]+'p'+str(self.dynamic_program.var_string_dict[v])[-2]+str(self.dynamic_program.var_string_dict[v])[-1]] = 'Bool'
        #print('vars_varsp_type_dict',vars_varsp_type_dict)

        if self.dynamic_program.k == 2:
            #print('pp')
            copy0_prefix = self.dynamic_program.copy_0.sexpr()
            #print('copy0_prefix',copy0_prefix)
            if not(copy0_prefix.find('let') == -1):
                str_prefix_tr_copy0 = self.eliminate_let(copy0_prefix)
            #print('str_prefix_tr_copy0',str_prefix_tr_copy0)
            copy1_prefix = self.dynamic_program.copy_1.sexpr()
            #print('copy1_prefix',copy1_prefix)
            if not(copy1_prefix.find('let') == -1):
                str_prefix_tr_copy1 = self.eliminate_let(copy1_prefix)
            #print('str_prefix_tr_copy1',str_prefix_tr_copy1)
            copy2_prefix = self.dynamic_program.copy_2.sexpr()
            #print('copy2_prefix',copy2_prefix)
            if not(copy2_prefix.find('let') == -1):
                str_prefix_tr_copy2 = self.eliminate_let(copy2_prefix)
            #print('str_prefix_tr_copy2',str_prefix_tr_copy2)

            tr012 = '(and '+str_prefix_tr_copy0+' '+str_prefix_tr_copy1+' '+str_prefix_tr_copy2+')'
            #print('tr012',tr012)
        #------------------for bad_condp------------------------------
        #------Collecting necessary dictionaries and list to be addd to z3 file to substitute bad to badp--
        #var_str_string_Int : Unprimed Integer variables seperated by commas
        #var_str_string_Bool : Unprimed Bool variables seperated by commas
        var_str_string_Int =''
        var_str_string_Bool=''
        for v in self.dynamic_program.var_string_dict:
            #print(v,self.dynamic_program.var_string_dict[v])
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                var_str_string_Int =  var_str_string_Int + (str(v)+", ")
            elif not(str(type(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                var_str_string_Bool =  var_str_string_Bool + (str(v)+", ")
            else:
                print('Not a bool',v)
        if not(var_str_string_Int == ''):
            var_str_string_Int =  var_str_string_Int[:-2]
        if not(var_str_string_Bool == ''):
            var_str_string_Bool = var_str_string_Bool[:-2]
        #print('var_str_string_Int',var_str_string_Int)
        #print('var_str_string_Bool',var_str_string_Bool)
        #----------------------------------------------------------------
        #var_strp_string_Int : Primed Integer variables seperated by commas
        #var_strp_string_Bool : Primed Bool variables seperated by commas
        var_strp_string_Int =''
        var_strp_string_Bool = ''
        for v in self.dynamic_program.var_string_dict:
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                var_strp_string_Int =  var_strp_string_Int + (str(v)[:-2]+'p'+str(v)[-2]+str(v)[-1]+", ")
            elif not(str(type(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                var_strp_string_Bool =  var_strp_string_Bool + (str(v)[:-2]+'p'+str(v)[-2]+str(v)[-1]+", ")
            else:
                print('Not a bool',v)
        if not(var_strp_string_Int == ''):
            var_strp_string_Int =  var_strp_string_Int[:-1]
        if not(var_strp_string_Bool == ''):
            var_strp_string_Bool = var_strp_string_Bool[:-1]
            #print('var_strp_string_Bool',var_strp_string_Bool)
        #----------------------------------------------------------------
        #var_str_string_space_Int : Unprimed Integer variables seperated by spaces
        #var_str_string_space_Bool : Unprimed Bool variables seperated by spaces
        var_str_string_space_Int =''
        var_str_string_space_Bool=''
        for v in self.dynamic_program.var_string_dict:
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                var_str_string_space_Int =  var_str_string_space_Int + (str(v)+" ")
            elif not(type(str(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                var_str_string_space_Bool =  var_str_string_space_Bool + (str(v)+" ")
            else:
                print('Not a bool',v)
        if not(var_str_string_space_Int == ''):
            var_str_string_space_Int =  var_str_string_space_Int[:-1]
        if not(var_str_string_space_Bool == ''):
            var_str_string_space_Bool = var_str_string_space_Bool[:-1]
        #print('var_str_string_space_Bool',var_str_string_space_Bool)
        #print('var_str_string_space_Int',var_str_string_space_Int)
        #----------------------------------------------------------------
        #var_strp_string_Int : Primed Integer variables seperated by spaces
        #var_strp_string_Bool : Primed Bool variables seperated by spaces
        var_strp_string_space_Int =''
        var_strp_string_space_Bool = ''
        for v in self.dynamic_program.var_string_dict:
            if not(str(type(self.dynamic_program.var_string_dict[v])).find('Arith') == -1):
                var_strp_string_space_Int =  var_strp_string_space_Int + (str(v)[:-2]+'p'+str(v)[-2]+str(v)[-1]+" ")
            elif not(str(type(self.dynamic_program.var_string_dict[v])).find('Bool') == -1):
                var_strp_string_space_Bool =  var_strp_string_space_Bool + (str(v)[:-2]+'p'+str(v)[-2]+str(v)[-1]+" ")
            else:
                print('Not a bool',v)
        if not(var_strp_string_space_Int == ''):
            var_strp_string_space_Int =  var_strp_string_space_Int[:-1]
        if not(var_strp_string_space_Bool == ''):
            var_strp_string_space_Bool = var_strp_string_space_Bool[:-1]
        #print('var_strp_string_space_Int',var_strp_string_space_Int)
        #print('var_strp_string_space_Bool',var_strp_string_space_Bool)
        #----------------------------------------------------------------
        #print('start of creating not(badp)')
        f_badp = open(self.folder_path + "original_bad.py","w")
        f_badp.write("from z3 import *\n")
        if len(var_str_string_Int) > 1:
            f_badp.write(var_str_string_Int+"," + var_strp_string_Int+"= Ints(\'"+var_str_string_space_Int+' '+var_strp_string_space_Int+"\')\n")
        if len(var_str_string_Bool):
            f_badp.write(var_str_string_Bool+"," + var_strp_string_Bool+"= Bools(\'"+var_str_string_space_Bool+' '+var_strp_string_space_Bool+"\')\n")

        #formula = x - y < 2
        f_badp.write('formula = Not( And('+ str(self.dynamic_program.original_bad_cond).replace('\n','').replace('  ','')+'))\n')
        #substitute(formula, (x, z), (y, w))
        f_badp.write('print(substitute(formula, ')
        vars_str = ''
        for v in str_vars_list:

                vars_str =  vars_str + '('+str(v)+','+str(v)[:-2]+'p'+str(v)[-2]+str(v)[-1]+')'
                vars_str =  vars_str + ', '

        vars_str = vars_str[:-2]
        f_badp.write(vars_str +'))')
        f_badp.close()
        #end of atgt file.py
        #read the output from txt
        cmd = 'python3 ' + self.folder_path + 'original_bad.py > ' + self.folder_path + 'original.txt'
        os.system(cmd)
        #print('pred_disc,11')
        #print('Finished dumping orihinal to py file, now reading from txt....')
        #read the file
        f_txt = open(self.folder_path + 'original.txt','r')
        not_bad_subs = f_txt.read()
        #print('pred_disc,12')
        #print('not_bad_subs',not_bad_subs)
        #------------------------------------------------------
        #get prefix notation of not(bad) without let
        #print('vars_varsp_type_dict',vars_varsp_type_dict)
        #print('pred_meaning_p',pred_meaning_p)
        str_prefix_not_bad_subs=self.dump_to_z3_file(not_bad_subs,vars_varsp_type_dict,pred_meaning_p)
        #print('str_prefix',str_prefix_not_bad_subs,type(str_prefix_not_bad_subs))


        #Remove newlines
        str_prefix_not_bad_subs = str_prefix_not_bad_subs.replace('\n',' ').replace('  ','')
        str_prefix_not_bad_subs = str_prefix_not_bad_subs.replace('\n',' ').replace('  ','')
        #return the indices of the locations
        #print('not_bad_subs',str_prefix_not_bad_subs)


        #add queries to sl file
        new_pred_smt_format = self.dump_to_sl_file_refine2(str_prefix_a_tgt,str_prefix_not_bad_subs,vars_type_dict,varsp_type_dict,tr012,var_str_string_space_Int,var_str_string_space_Bool,var_strp_string_space_Int,var_strp_string_space_Bool)
        #print('new_pred_smt_format',new_pred_smt_format)
        return new_pred_smt_format

    def dump_to_sl_file_refine2(self,final,not_bad_prime,vars_type_dict,varsp_type_dict,tr012,str_unprimed_Int_vars,str_unprimed_Bool_vars,str_primed_Int_vars,str_primed_Bool_vars):
        #print("In dump_to_sl_file_refine2")

        filename ="refine"+str(self.num_new_preds)+".sl"
        f = open(self.folder_path + filename,"w")
        #print('file opened')
        #----------------grammar---------------------
        grammar = ';;grammar'+'\n'+'(set-logic LIA)'+'\n'+'(synth-fun p ('
        for x in vars_type_dict:
            grammar = grammar + '('+str(x)+ ' '+vars_type_dict[x]+')'
        #print('grammar1',grammar)
        grammar = grammar + ') Bool \n'+'           ((B Bool) (I Int)(C Int))\n'+'           ((B Bool ('
        #print('\n\n\n grammar2',grammar)
        for x in vars_type_dict:
            if vars_type_dict[x] == 'Bool':
                grammar = grammar +  str(x) + ' '
        #print('\n\n\n grammar3',grammar)
        grammar = grammar +'(and B B) (or B B) (not B) \n'+'                         (= I I) (<= I I) (>= I I)))\n'+'            (I Int ('
        #print(' \n\n grammar4',grammar)
        for x in vars_type_dict:
            if vars_type_dict[x] == 'Int':
                grammar = grammar + str(x) + ' '
        #print('\n\n\n grammar5',grammar)
        grammar = grammar + 'C \n'+'                      (+ I I) (* C I) (- I I)))\n'
        grammar = grammar + '\t\t\t\t\t\t(C Int ( 0 1 2 3 4 5 6 7 8 383 42 1009)))'+'\n\n)\n\n'
        f.write(grammar)
        #print('grammar',grammar)
        #-----------------define final function------------------------------------

        final_fun = '(define-fun final ('

        for x in vars_type_dict:
              final_fun = final_fun + '('+str(x)+' '+ str(vars_type_dict[x])+')'
        final_fun= final_fun+ ') Bool  '+ str(final).replace('\n','') +')\n\n'
        f.write(final_fun)
        #print('final_fun',final_fun)
        #--------------------define notBad func----------------------------------------------------------
        not_bad_fun = '(define-fun not_bad ('

        for x in varsp_type_dict:
              not_bad_fun = not_bad_fun + '('+str(x)+' '+ str(varsp_type_dict[x])+')'
        not_bad_fun= not_bad_fun+ ') Bool  '+ str(not_bad_prime).replace('\n','') +')\n\n'
        f.write(not_bad_fun)
        #---------------define tr function-------------------------------------------
        #define trans function
        trans_fun = '(define-fun trans('

        for x in vars_type_dict:
            trans_fun = trans_fun + '('+str(x)+ ' '+ str(vars_type_dict[x])+ ' )'
        #print('trans1',trans_fun)
        for x in varsp_type_dict:
            trans_fun = trans_fun + '('+str(x)+' '+ str(varsp_type_dict[x])+')'
        #print('\n\ntrans2',trans_fun)
        trans_fun= trans_fun + ') Bool  '+ tr012+')\n\n'
        f.write(trans_fun)
        #print('trans_fun',trans_fun)
        #-----------------------declare var-----------------------------------------------
        decl_var = ''
        for x in vars_type_dict:
            decl_var = decl_var + '(declare-var '+str(x)+' '+ str(vars_type_dict[x])+' )\n'
        #print('\n\ntrans3',trans_fun)
        for x in varsp_type_dict:
            decl_var = decl_var + '(declare-var '+str(x)+' '+ str(varsp_type_dict[x])+' )\n'
        decl_var = decl_var + '\n\n'
        f.write(decl_var)

        #print('decl_var',decl_var)

        #---------------------constraint--------------------------------------------------------
        constraint = '(constraint (=> (and (final '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+' ) (p '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+') (trans '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+str_primed_Int_vars+' '+str_primed_Bool_vars+')) (not_bad '+str_primed_Int_vars+' '+str_primed_Bool_vars+')))\n\n'

        f.write(constraint)
        constraint2 = '(constraint (exists ('
        for x in vars_type_dict:
            constraint2 = constraint2 + '('+str(x)+' '+ str(vars_type_dict[x])+' )'
        constraint2 = constraint2 + ')'+'(and (final '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+' ) (p '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+'))'
        constraint2 =constraint2 + '))\n\n\n'
        f.write(constraint2)


        constraint3 = '(constraint (exists ('
        for x in vars_type_dict:
            constraint3 = constraint3 + '('+str(x)+' '+ str(vars_type_dict[x])+' )'
        constraint3 = constraint3 + ')'+'(and (final '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+' ) (not (p '+str_unprimed_Int_vars+' '+str_unprimed_Bool_vars+')))'
        constraint3 =constraint3 + '))\n\n\n'
        f.write(constraint3)


        #----------------------------------------------------------------------------------------
        f.write('(check-synth)')
        f.close()
        #print('iihhih')
        #----run the refine_.sl file using cvc4, write the ouput to p_sol.txt and store the file contents in new_predicate--------------------
        filename = 'p_sol_'+str(self.num_new_preds)+'.txt'
        #cmd = './cvc4-1.8-x86_64-linux-opt  --sygus-active-gen=enum refine'+str(self.num_new_preds)+'.sl >'+ filename
        cmd = './cvc4-1.8-x86_64-linux-opt --sygus-active-gen=enum '+ self.folder_path +  'refine' +str(self.num_new_preds)+'.sl > '+ ''+self.folder_path+filename

        os.system(cmd)
        fd = open(self.folder_path + filename,"r")
        new_predicate = ''.join(fd.readlines()[1:])
        fd.close()


        #---------new_predicate = '(define-fun p ((h_1 Int) (l_0 Int) (count_0 Int) (h_0 Int) (count_1 Int) (l_1 Int)) Bool (and (= h_0 h_1) (= count_1 count_0)))----------------------'
        print('new predicate is '+str(new_predicate))
        if not(new_predicate.find('define') == -1):
            rule = self.add_new_predicate(new_predicate,'refine')
        else:
            exit()
            rule = 'unknown'

        return rule





    def get_dict(self):
         for i in self.dynamic_program.list_in_order:
             var_type = i[1:][:-1].split(',')
             self.dict_in_order[var_type[0]] = var_type[1]
             #print('dict_in_order',self.dict_in_order)

    def block_or_extend_bad(self, trace):
        if len(trace) <= 1:
            # Bad extended enough to intersect Init
            return False
        while True:

            #-------------rest of block_or_extend_bad-------------------------
            bad_predecessor = trace[-2][0]
            bad_predecessor_assignment = trace[-2][1]
            if bad_predecessor not in self.blocked_compositions:
                self.blocked_compositions[bad_predecessor] = []

            if len(self.blocked_compositions[bad_predecessor]) == (
                    self.dynamic_program.possible_assignments - 1) or self.check_possible_cutoff(bad_predecessor,
                                                                                                 bad_predecessor_assignment):
                if self.print_log:
                    print("Extending bad with state " + bad_predecessor.pretty_print(self.dynamic_program) + "\n")

                bad_predecessor_comp =  trace[-2][1]
                bad_pred_reason = trace[-1][0]
                #----------------convert abstract state objects to z3 formulas----------------------------------------
                bad_pred_as_formula = self.dynamic_program.abstract_state_to_cond(bad_predecessor)
                bad_pred_reason_as_formula = self.dynamic_program.abstract_state_to_cond(bad_pred_reason)
                #----------------update the dictionary with <z3 formula of pred,comp> -> z3 formula of reason_as_formula-----------
                self.reason_to_add_to_bad[(bad_pred_as_formula,bad_predecessor_comp)]=bad_pred_reason_as_formula
                #---------------<bad_pred_reason_as_formula, -1> = None, if not already part of a key, -1 to indicate its a real_bad--
                reason_already_in_dict= 0

                for st_comp_pair in self.reason_to_add_to_bad:
                    solver_to_check_reason_in_dict = z3.Solver(ctx = self.ctx)
                    #print('initialised solver')
                    solver_to_check_reason_in_dict.add(z3.Not(bad_pred_reason_as_formula))
                    #print('added not reason')
                    solver_to_check_reason_in_dict.add(st_comp_pair[0])
                    #print('added st_comp_pair')
                    if solver_to_check_reason_in_dict.check() == z3.unsat:
                        solver_to_check_reason_in_dict = z3.Solver(ctx = self.ctx)
                        solver_to_check_reason_in_dict.add(bad_pred_reason_as_formula)
                        solver_to_check_reason_in_dict.add(z3.Not(st_comp_pair[0]))
                        #print('initialisedsecod solver with formulas')
                        if solver_to_check_reason_in_dict.check() == z3.unsat:
                            #st_comp_pair[0] is equivalent to bad_pred_reason_as_formula
                            reason_already_in_dict = 1
                if reason_already_in_dict == 0:
                    self.reason_to_add_to_bad[(bad_pred_reason_as_formula,-1)] = None

                #print('reason_to_add_to_bad',self.reason_to_add_to_bad)

                self.dynamic_program.extend_bad(bad_predecessor)
                self.blocked_compositions.pop(bad_predecessor)
                trace = trace[:-1]
                if len(trace) <= 1:
                    return False
            else:
                print("Blocking composition assignment " + str(bad_predecessor_assignment) + " for state\n " + bad_predecessor.pretty_print(self.dynamic_program) + "\n")
                self.blocked_compositions[bad_predecessor].append(bad_predecessor_assignment)
                if self.dynamic_program.use_explicit_conposition_function:
                    self.dynamic_program.change_assignment(bad_predecessor, self.get_next_assignment(bad_predecessor))
                    self.dynamic_program.sc_tr = None
                else:
                    self.dynamic_program.block_assignment(bad_predecessor, bad_predecessor_assignment)
                    #print('asdfg')
                break
        #print('block_ext,1')
        self.dynamic_program.mk_dynamic_rules()

        #print('block_ext,2')
        return True

    def run_bmc(self):
        self.smt_queries_count += 1
        self.concrete_dp.mk_init_rule()
        self.init_bounded_fp(self.longest_abstract_trace+3,self.concrete_dp.ctx)
        self.load_dynamic_program_for_bmc()

        res = self.fp.query(self.concrete_dp.get_bad())
        if res == z3.sat:
            return True
        return False

    def find_cex(self):
        self.smt_queries_count += 1
        self.init_fp()
        #print('find cex,1')
        #self.import_lemmas()
        #print('find cex,2')
        self.load_dynamic_program()
        #print('find cex,3')

        res = self.fp.query(self.dynamic_program.get_bad())
        if not self.dynamic_program.default_composition:
            self.export_inv_lemmas()
            #print('find cex,4')
        if res == z3.unsat:
            #print('find cex,5')
            return None

        else:
            #print('find cex,6')
            answer = self.fp.get_ground_sat_answer()
            #print('find cex,7',answer)
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

    def init_bounded_fp(self,bound,ctx):
        # z3.enable_trace('spacer')
        fp = z3.Fixedpoint(ctx=ctx)  # fixpoint solver
        fp.set(engine='spacer')
        fp.set('spacer.max_level',bound)
        fp.set('spacer.eq_prop', False)
        fp.set('xform.slice', False)
        fp.set('xform.inline_linear', False)  # performance once there is no need for debuging
        fp.set('xform.inline_eager', False)
        fp.set('xform.tail_simplifier_pve', False)
        self.fp = fp

    def get_state_move_trace(self, answer):
        #print('get_state_move_trace,1')
        z3_states = self.get_z3_states(answer)
        #print('get_state_move_trace,2',z3_states)
        state_move_trace = []
        for z3_state in z3_states:
            state = self.dynamic_program.abstract_state_from_z3_state(z3_state)
            #print('get_state_move_trace,3',state)
            state_move_trace.append(
                (state, (7 if self.dynamic_program.k == 3 else 2) if self.dynamic_program.default_composition else z3_state.arg(0).as_long()))
        #print('get_state_move_trace,4',state_move_trace)
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
        #print('In print_trace')
        self.trace_second_coord = []
        ret = ""
        for state, move in trace:
            ret += state.pretty_print(self.dynamic_program) + "--->"

            a = "[" + (str(move) if not self.dynamic_program.default_composition else (str(7) if self.dynamic_program.k == 3 else str(2))) + "]\n\n"
            ret += a
            self.trace_second_coord.append((str(move) if not self.dynamic_program.default_composition else (str(7) if self.dynamic_program.k == 3 else str(2))))


        return ret

    def get_invariant(self):
        inv_decl = self.dynamic_program.get_inv_declaration()
        inv_rel = self.dynamic_program.get_inv_relation()
        val = self.fp.get_cover_delta(-1, inv_decl)
        val = z3.substitute_vars(val, *inv_rel.children())
        return val

    def load_dynamic_program(self):
        #print('load_dynamic_program,1')
        self.dynamic_program.mk_tr_rule()
        #print('load_dynamic_program,2')
        self.dynamic_program.mk_bad_rule()
        #print('load_dynamic_program,3')
        self.fp.declare_var(self.dynamic_program.get_vars_to_declare())
        #print('load_dynamic_program,4')
        self.fp.register_relation(self.dynamic_program.get_bad_declaration())
        #print('load_dynamic_program,5')
        self.fp.register_relation(self.dynamic_program.get_inv_declaration())
        #print('load_dynamic_program,6')
        for rule in self.dynamic_program.get_rules():
            if z3.is_app_of(rule, z3.Z3_OP_IMPLIES):
                self.fp.add_rule(rule.arg(1), rule.arg(0))
            else:
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

    def sc_program_from_file(self, program_path, is_comparator, method_name,concrete_array_vars,prop):
        #print('sc_pgm,1')
        if is_comparator:
            dp, entry_to_memory_map = comparator_transform(program_path, self.force_predicate_abstraction, method_name,prop)
            #print('sc_pgm,2')
            if self.bmc and self.force_predicate_abstraction:
                self.concrete_dp = comparator_transform(program_path, False, method_name,prop,entry_to_memory_map)[0]
        else:
            #print('sc_pgm,3')
            dp = transform(program_path, self.force_predicate_abstraction,concrete_array_vars)
            #print('sc_pgm,4')
        #print('rel_init',self.dynamic_program.rel_init)
        dp.mk_init_rule()
        #print('rel_init',dp.rel_init)
        #print('sc_pgm,5')
        return dp

    def check_possible_cutoff(self, state, assignment_to_disable):
        #return False-> no cutoff, return True -> extend bad
        if self.dynamic_program.k == 2:
            if assignment_to_disable == 2:
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
                copy_2_run = (assignment in [4,5,6])#b[0]
                copy_1_run = (assignment in [2,3,6])#b[1]
                copy_0_run = (assignment in [1,3,5])#b[2]
                if copy_0_run:
                    if not self.check_not_ended(state,0):
                        continue
                if copy_1_run:
                    if self.check_not_ended(state,1):
                        continue
                if copy_2_run:
                    if self.check_not_ended(state,2):
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

    #batch 6 : assign_prime_to_unprime
    def  assign_prime_to_unprime(self,model):
         values_dict = dict()
         #print('passed 1')
         for d in model.decls():
                     var_name = d.name()
                     #print('passed 2')
                     var_val = model[d]
                     #assumes number of copies < 10
                     last_letter = var_name[-3]
                     #print('passed 3 %s %s %s %s' %(last_letter,var_val,var_name,d))
                     len_of_var_name= len(var_name)
                     #print('passed 4')
                     if last_letter == 'p':

                        if len_of_var_name > 3:
                            #print('passed 4 %s %s' %(last_letter,d))
                            #print("hello")
                            except_p = var_name[0:-3] + var_name[-2:]
                            #print('passed 5 %s %s'%(d,except_p))
                            #print("",except_p,"=",var_val)
                            values_dict[except_p] = var_val
                            #print('passed 6 %s %s'%(values_dict,values_dict[except_p]))
         for d in model.decls():

                     var_name = d.name()
                     var_val = model[d]
                     #assumes number of copies < 10
                     last_letter = var_name[-3]
                     if not(last_letter == 'p'):
                        #print('var_name',var_name)
                        if not (var_name in values_dict):
                           values_dict[var_name]= var_val
         #del values_dict['composition']
         #print("values_dict",values_dict)
         return values_dict

    #batch 11 :
    def abs_st_as_formula(self, state_number_in_cex):
        pred_valuations_dict = dict()

        st_list=[]
        #print("a_list")
        for key,val in self.pred_string_dict.items():
                 #print("a_list")
                 #print("self.cex_trace_states : ",self.cex_trace_states)
                 #print("self.cex_trace_states[state_number_in_cex]",self.cex_trace_states[state_number_in_cex])
                 if key in self.cex_trace_states[state_number_in_cex]:
                        #add val = True
                        #print("a_list True")
                        st_list.append(val == True)

                 else:
                        #print("a_list False")
                        st_list.append(val == False)

        return st_list



    #batch 7 : check_spur1
    def check_spur(self,trace):
        print("-----------------check_spuriousness-------------------------------\n\n\n")

        #print("trace",trace)
        #print('trace',trace)
        #print('trace[-2][0]',self.dynamic_program.abstract_state_to_cond(trace[-2][0]))
        #print('trace[-1][0]',self.dynamic_program.abstract_state_to_cond(trace[-1][0]))
        len_trc = len(trace)
        #print('cs,1')
        #print("len_trc : ", len_trc)
        state_number_in_cex = 0
        #batch 14 : find first abstract state and assign to a_src
        a_list = self.abs_st_as_formula(state_number_in_cex)
        #print('a_list',a_list)
        #print('cs1.1',a_list)
        a_list.append(self.ctx)
        a_src = z3.And(*a_list)
        #print('1 a_src',a_src)
        s_find_next = z3.Solver(ctx = self.ctx)
        s_find_next.add(z3.And(self.dynamic_program.init_condition,self.ctx))
        s_find_next.add(a_src)
        s_find_next.add(self.dynamic_program.h)
        #print('rel_init',self.dynamic_program.rel_init)
        #print('cs,2, ',self.dynamic_program.var_string_dict)
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
        if s_find_next.check() == z3.unsat :
            #print('cs,3')

            print("No concrete initial state exists")
            return True,None,None,a_src,None,self.dynamic_program.sc_tr,state_number_in_cex
        else :
            #print('s_find_next',s_find_next)
            m = s_find_next.model()

            #print('1')
            #print('cs,2, ',self.dynamic_program.var_string_dict)
            #print('self.dynamic_program.var_string_dict',self.dynamic_program.var_string_dict(),type(self.dynamic_program.var_string_dict()))
            #print('str(self.dynamic_program.h)',str(self.dynamic_program.h))
            #print('str(self.dynamic_program.init_condition)',str(self.dynamic_program.init_condition))
            for v in self.dynamic_program.var_string_dict:
                if str(self.dynamic_program.h).find(v) == -1 and str(self.dynamic_program.init_condition).find(v) == -1 :
                    #print('here')
                    m.eval(self.dynamic_program.var_string_dict[v],model_completion = True)

                    #print('not here')

            #print('cs,4,mmmmmmmm',m)
            #print("got here")
            len_trc = len_trc - 1

            #print( 'A satisfying concrete initial state : ' , m)
            #print("len_trc : ", len_trc)
            #batch 12 : check if initial state is in bad
            values_dict = dict()

            for d in m.decls():
                #print(d.name(),m[d])
                ind = d.name()
                valuation = m[d]
                values_dict[ind]= valuation
            print('SEARCHING A CONCRETE CEX TRACE FROM ABOVE ABSTRACT CEX: ')
            print('--------------------------------------------------')
            print('Initial State',values_dict)
            print('\n')
            formula = []

            for key,val in values_dict.items():
                    #print(val,type(val))
                    #print(self.dynamic_program.var_string_dict.keys())
                    if key in self.dynamic_program.var_string_dict.keys():
                          actual_var = self.dynamic_program.var_string_dict[key]
                          formula.append(actual_var == val)
                    #print("formula",formula)

            formula.append(self.ctx)
            c_src = z3.And(*formula)
            c_tgt = None
            a_tgt = None
            s_find_next = z3.Solver(ctx = self.ctx)
            s_find_next.add(c_src)


            while len_trc > 0:
                #print ("sc_tr", self.dynamic_program.sc_tr)
                #create a formula to say composition var = trace_seond_coord[state_num_in_cex]
                #print(self.trace_second_coord[state_number_in_cex])
                tr = self.dynamic_program.find_tr(self.trace_second_coord[state_number_in_cex])
                list_for_tr =[]
                list_for_tr.append(tr)
                list_for_tr.append(self.ctx)
                tr_formula = z3.And(*list_for_tr)
                #print('passed list creation')
                s_find_next.add(tr_formula)
                if s_find_next.check() == z3.unsat:
                    print( 'No transition from the previous concrete state')
                    return True,c_src,c_tgt,a_src,a_tgt,tr_formula,state_number_in_cex
                else:
                    model = s_find_next.model()
                    #print("state : ",state_number_in_cex+2," is ",model)
                    len_trc = len_trc - 1
                    #print("len_trc : ", len_trc)
                    #print('pap ',model)
                    #batch 8 : assign_prime_to_unprime
                    values_dict = self.assign_prime_to_unprime(model)
                    print("Next concrete state :",values_dict)
                    print('\n')
                    solver_c_in_a = z3.Solver(ctx=self.ctx)
                    solver_c_in_a.add(self.dynamic_program.h)
                    state_number_in_cex = state_number_in_cex + 1
                    #print("state_number_in_cex",state_number_in_cex)

                    #batch 10 : add conc_st to solver
                    formula = []
                    for key,val in values_dict.items():
                            #print(val,type(val))
                            #print(self.dynamic_program.var_string_dict.keys())
                            if key in self.dynamic_program.var_string_dict.keys():
                                actual_var = self.dynamic_program.var_string_dict[key]
                                formula.append(actual_var == val)
                    #print("formula",formula)
                    formula.append(self.ctx)
                    c_tgt = z3.And(*formula)
                    solver_c_in_a.add(c_tgt)


                    #batch 11 : add a batch to add abs_ st
                    st_list = self.abs_st_as_formula(state_number_in_cex)

                    st_list.append(self.ctx)
                    a_tgt = z3.And(*st_list)
                    solver_c_in_a.add(a_tgt)

                    #batch 16
                    #check if c_src /\ sc_tr is unsat
                    not_hang_src = z3.Solver(ctx = self.ctx)
                    not_hang_src.add(c_src)
                    not_hang_src.add(z3.And(*list_for_tr))
                    if not_hang_src.check() == z3.unsat :
                            print(" concrete source is hanging")
                            self.hang = True
                            return True,c_src,c_tgt,a_src,a_tgt,tr_formula,state_number_in_cex-1

                    #batch 9 : finish it up WITHOUT adding formulas for abs st and conc st
                    if z3.unsat == solver_c_in_a.check():
                            #print("The concrete state is not in abstract state of trace")
                            #batch 15 : pred_disc1

                            #print("c_src : ",c_src)
                            #print("c_tgt : ",c_tgt)
                            #print("a_src : ",a_src)
                            #print("a_tgt : ",a_tgt)
                            #print("tr : ", )
                            #print("state_num_in_cex",state_number_in_cex)
                            self.hang = False



                            return True,c_src,c_tgt,a_src,a_tgt,tr_formula,state_number_in_cex-1
                    else:
                            s_find_next = z3.Solver(ctx = self.ctx)
                            s_find_next.add(z3.And(*formula))
                            #print("while loop iteration ended",len_trc)
                            c_src = c_tgt
                            a_src = a_tgt

            #batch 12 : check if final concrete state is in bad
            solver_bad = z3.Solver(ctx = self.ctx)
            #print('a_tgt is %s \n original_bad is %s'%(a_tgt,self.dynamic_program.original_bad_cond))
            solver_bad.add(z3.Not(self.dynamic_program.original_bad_cond))
            solver_bad.add(a_tgt)
            solver_bad.add(self.dynamic_program.h)
            #print("solver_bad",solver_bad, " is ", solver_bad.check())
            if solver_bad.check() == z3.unsat:
                #print("Trace is not spurious")
                return False,c_src,c_tgt,a_src,a_tgt,tr_formula,state_number_in_cex-1
            else:

                print( "Last concrete trace in the state is not in bad")
                return True,None,c_tgt,None,a_tgt,tr_formula,state_number_in_cex-1
        #return False,c_src,c_tgt,a_src,a_tgt,tr_formula,state_number_in_cex-1

    def make_var_to_var_true(self,formula,pred_meaning,pred_meaning_p):
            lines = formula.split('\n')
            #print('lines are',lines)
            set_of_op = ['=','<','>','+','-','*','/']
            for i in range(len(lines)):
                flag = 0
                #print('lololo')
                for op in set_of_op:
                    if not(lines[i].find(op) == -1) :
                        flag = 1
                #print('here')
                if flag == 0:
                    #print('here2')
                    for p,v in pred_meaning_p.items():
                        if not(lines[i].find(v) == -1):
                            lines[i]=lines[i].replace(v,'(= '+v+' true)')
                            #print('hhh',lines)
                    for p,v in pred_meaning.items():
                        if not(lines[i].find(v) == -1):
                            lines[i]=lines[i].replace(v,'(= '+v+' true)')
            #print('ihr',lines)
            s = '\n'
            line=s.join(lines)
            return line

    def pred_disc(self,c_src,c_tgt,a_src,a_tgt,tr):
            print('---------------pred_disc--------------')
            print('Discover predicate using a_src, a_tgt, c_src, c_tgt to eliminate the spurious cex.. ')
            #print('c_src,c_tgt,a_src,a_tgt',c_src,c_tgt,a_src,a_tgt)
            c_src_original = c_src
            c_tgt_original = c_tgt
            a_src_original = a_src
            a_tgt_original = a_tgt
            tr_original = tr
            #print('pred_disc,001')
            vars_in_c_src = dict()
            for key,val in self.dynamic_program.var_string_dict.items():
                if not(str(type(val)).find('Arith') == -1):
                    vars_in_c_src[key]='Int'
                elif  not(str(type(val)).find('Bool') == -1):
                    vars_in_c_src[key]='Bool'
                else:
                    vars_in_c_src[key]='Array'
            #print('pred_disc,002')
            vars_in_c_src_p=dict()
            #add p to last but third position
            for key_p,val in self.dynamic_program.var_string_dict.items():
                 key_p='_'.join(key_p.split('_')[:-1])+'p_'+'_'.join(key_p.split('_')[-1:])
                 if not(str(type(val)).find('Arith') == -1):
                    vars_in_c_src_p[key_p] ='Int'
                 elif  not(str(type(val)).find('Bool') == -1):
                    vars_in_c_src_p[key_p]='Bool'
                 else:
                    vars_in_c_src_p[key_p]='Array'
            #print('',vars_in_c_src_p)
            #print('pred_disc,003')
            #print('pred_disc,003.1',c_src)
            #print('pred_disc,003.2',c_tgt)
            c_src = c_src.sexpr()
            #print('pred_disc,003.1',c_src)
            c_tgt = c_tgt.sexpr()
            #print('pred_disc,003.2',c_tgt)
            #print('a_tgt',a_tgt)
            #print('pred_disc,004',str(self.dynamic_program.h))
            '''
            pr = z3.simplify(z3.And(a_src,self.dynamic_program.h,self.ctx))
            print('pr',pr)
            '''
            parentheses_locs = self.paren_dict_func(str(self.dynamic_program.h))
            #print('doneO')
            pred_meaning = dict()
            #print('predicate names',self.dynamic_program.predicates)
            #h_list is list of definitions of predicates of form c0_eq_c1 == 'c0 == c1' and pred_meaning dictionary maps pred to their definitions
            for preds in self.dynamic_program.predicates:
                if not(str(self.dynamic_program.h).find(str(preds)) == -1):
                    #next_paren has the diff of immediate paranthesis in h after pred name
                    if str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 4] == '(':
                        next_paren = 4
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 5] == '(':
                        next_paren = 5
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 6] == '(':
                        next_paren = 6
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 7] == '(':
                        next_paren = 7
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 8] == '(':
                        next_paren = 8
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 9] == '(':
                        next_paren = 9
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 10] == '(':
                        next_paren = 10
                    elif str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 11] == '(':
                        next_paren = 11
                    else:
                        #print(preds,self.dynamic_program.h)
                        print('no (')

                        next_paren = -1

                    #print('next_paren',next_paren)
                    #print('pred_index + pred_len + 11 < len(h) ',len(str(self.dynamic_program.h)) > str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 11)
                    #print('h[pred_index+4..11]',str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 4],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 5],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 6],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 7],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 8],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 9],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 10],str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + 11] )
                    if next_paren == -1:
                        endofpreddefn = str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)):].find(',')
                        pred_meaning[preds] = str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds)) + len(str(preds))+ 4:str(self.dynamic_program.h).find(str(preds)) + endofpreddefn ]
                    if next_paren > 0:
                        pred_meaning[preds] = (str(self.dynamic_program.h)[str(self.dynamic_program.h).find(str(preds))+len(str(preds))+4:parentheses_locs[str(self.dynamic_program.h).find(str(preds)) + len(str(preds)) + next_paren]+1]).replace('\n','').replace('  ','').replace('==','=')



            #print('pred_meaning',pred_meaning)
            #exit()


            #do the same for h_p
            parentheses_locs_p = self.paren_dict_func(str(self.dynamic_program.h_p))
            #print('doneO')
            pred_meaning_p = dict()
            predicates_p = []
            for p in self.dynamic_program.predicates:
                predicates_p.append(str(p) + 'p')
            #print('predicate_p names',predicates_p)
            #print('h_p',str(self.dynamic_program.h_p))

            #h_list is list of definitions of predicates of form c0_eq_c1 == 'c0 == c1' and pred_meaning dictionary maps pred to their definitions
            for preds_p in predicates_p:
                if not(str(self.dynamic_program.h_p).find(str(preds_p)) == -1):
                    #next_paren has the diff of immediate paranthesis in h after pred name
                    if str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 4] == '(':
                        next_paren = 4
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 5] == '(':
                        next_paren = 5
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 6] == '(':
                        next_paren = 6
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 7] == '(':
                        next_paren = 7
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 8] == '(':
                        next_paren = 8
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 9] == '(':
                        next_paren = 9
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 10] == '(':
                        next_paren = 10
                    elif str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + 11] == '(':
                        next_paren = 11
                    else:
                        #print('no (')
                        next_paren = -1


                    if next_paren == -1:
                        endofpreddefn = str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)):].find(',')
                        pred_meaning_p[preds_p] = str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p))+ 4:str(self.dynamic_program.h_p).find(str(preds_p)) + endofpreddefn ]
                    if next_paren > 0:
                        pred_meaning_p[preds_p] = (str(self.dynamic_program.h_p)[str(self.dynamic_program.h_p).find(str(preds_p))+len(str(preds_p))+4:parentheses_locs_p[str(self.dynamic_program.h_p).find(str(preds_p)) + len(str(preds_p)) + next_paren]+1]).replace('\n','').replace('  ','').replace('==','=')


            #print('pred_meaning_p',pred_meaning_p)
            '''
            #earlier approach for obtaining pred_meaning and pred_meaning_p
            h_list = (((str(self.dynamic_program.h)[4:])[:-1]).replace(' ','')).rsplit(',\n')
            pred_meaning = dict()
            [(pred_meaning.update({i.split('==')[0] : ('' +('=='.join(i.split('==')[1:]))[0:]).replace('==','=')})) for i in h_list]
            print('pred_disc,008')
            hp_list = (((str(self.dynamic_program.h_p)[4:])[:-1]).replace(' ','')).rsplit(',\n')
            print('hp_list',hp_list)
            pred_meaning_p = dict()
            [(pred_meaning_p.update({i.split('==')[0] : ('' +('=='.join(i.split('==')[1:]))[0:]).replace('==','=')})) for i in hp_list]
            '''



            str_prefix_a_src = self.dump_to_z3_file(a_src,0,vars_in_c_src,pred_meaning)
            #print('a_src_final3',str_prefix_a_src)

            #str_prefix_a_src = self.make_var_to_var_true(str_prefix_a_src,pred_meaning,pred_meaning_p)
            #print('returned str_prefix_a_src')

            str_prefix_a_tgt=self.dump_to_z3_file(a_tgt,1,vars_in_c_src,pred_meaning)
            #print('str_prefix',str_prefix_a_tgt,type(str_prefix_a_tgt))
            #str_prefix_a_tgt = self.make_var_to_var_true(str_prefix_a_tgt,pred_meaning,pred_meaning_p)

            #exit()
            f_a_tgt_next = open(self.folder_path+'a_tgt_next.py',"w")
            f_a_tgt_next.write("from z3 import *\n")
           # x, y, z, w = Ints('x y z w')

            for p in pred_meaning:
                f_a_tgt_next.write(str(p)+", ")
            predp_str = ''
            for pp in pred_meaning_p:
                predp_str =  predp_str + (str(pp)+", ")
            predp_str = predp_str[:-2]
            f_a_tgt_next.write(predp_str)
            f_a_tgt_next.write(' = ')
            f_a_tgt_next.write('Bools(\'')
            for p in pred_meaning:
                f_a_tgt_next.write(str(p)+" ")
            predp_str = ''
            for pp in pred_meaning_p:
                predp_str =  predp_str + (str(pp)+" ")
            predp_str = predp_str[:-1]
            f_a_tgt_next.write(predp_str)
            f_a_tgt_next.write('\')\n')
            #formula = x - y < 2
            f_a_tgt_next.write('formula = And('+ str(a_tgt).replace('\n','').replace('  ','')+')\n')
            #substitute(formula, (x, z), (y, w))
            f_a_tgt_next.write('print(substitute(formula, ')
            pred_str = ''
            for p in pred_meaning:

                    pred_str =  pred_str + '('+str(p)+','+str(p)+'p'+')'
                    pred_str =  pred_str + ', '

            pred_str = pred_str[:-2]
            f_a_tgt_next.write(pred_str +'))')


            f_a_tgt_next.close()
            #end of atgt file.py
            #read the output from txt
            cmd = 'python3 '+self.folder_path + 'a_tgt_next.py > '+ self.folder_path+ 'a_tgt.txt'
            os.system(cmd)
            #print('pred_disc,11')
            #print('Finished dumping atgt to py file, now reading from txt....')
            #read the file
            f_txt = open(self.folder_path + 'a_tgt.txt','r')
            a_tgt_subs = f_txt.read()
            #print('pred_disc,12')
            #print('atgtsubs',a_tgt_subs)

            str_prefix_a_tgt_subs=self.dump_to_z3_file(a_tgt_subs,2,vars_in_c_src_p,pred_meaning_p)
            #print('str_prefix',str_prefix_a_tgt_subs,type(str_prefix_a_tgt_subs))
            #str_prefix_a_tgt_subs = self.make_var_to_var_true(str_prefix_a_tgt_subs,pred_meaning,pred_meaning_p)
            #print('a_tgt2',a_tgt)

            #Remove newlines
            c_src = c_src.replace('\n',' ').replace('  ','')
            c_tgt = c_tgt.replace('\n',' ').replace('  ','')
            str_prefix_a_src = str_prefix_a_src.replace('\n',' ').replace('  ','')
            str_prefix_a_tgt = str_prefix_a_tgt.replace('\n',' ').replace('  ','')
            str_prefix_a_tgt_subs = str_prefix_a_tgt_subs.replace('\n',' ').replace('  ','')
            #return the indices of the locations
            #print('returned str_prefix_a_tgt')
            #print('==============================')
            #print('c_src',c_src)
            #print('c_tgt',c_tgt)
            #print('a_src',str_prefix_a_src)
            #print('a_tgt',str_prefix_a_tgt)

            tr_sexpr= str(tr.sexpr())
            #print('sl,1,tr_sexpr',tr_sexpr)

            tr_wo_let = self.eliminate_let(tr_sexpr)

            tr_wo_let = tr_wo_let.replace('\n','').replace('  ','')
            #print('tr_wo_let',tr_wo_let)
            #tr_wo_let = self.make_var_to_var_true(tr_wo_let,pred_meaning,pred_meaning_p)
            #print('tr_wo_let')
            #print('c_src is %s \n,c_tgt is %s,a_src is %s,a_tgt is %s,tr is %s,a_tgt_next is %s' % (c_src,c_tgt,str_prefix_a_src,str_prefix_a_tgt,tr_wo_let,str_prefix_a_tgt_subs))


            #add queries to sl file
            new_pred_smt_format = self.dump_to_sl_file(c_src,c_tgt,str_prefix_a_src,str_prefix_a_tgt,vars_in_c_src,vars_in_c_src_p,tr_wo_let)
            #print('new_pred_smt_format',new_pred_smt_format)
            '''
            if new_pred_smt_format == 'unknown':
                self.write_to_z3_file(c_src,c_tgt,str_prefix_a_src,str_prefix_a_tgt,vars_in_c_src,vars_in_c_src_p,tr_wo_let,str_prefix_a_tgt_subs)
            '''
            #self.write_to_smt2_file(c_src,c_tgt,str_prefix_a_src,str_prefix_a_tgt,vars_in_c_src,vars_in_c_src_p,tr_wo_let,str_prefix_a_tgt_subs,c_src_original,c_tgt_original,a_src_original,a_tgt_original,tr_original)
            #exit()
            return new_pred_smt_format

    def add_new_predicate(self,new_predicate,refine_type):
            #add the predicate to the original smt2 file
            #print('typo00')


            #print('new_predicate at start of add_new_predicate',new_predicate)
            #check if predicate has a 'not' in front


            #print('self.num_new_preds',self.num_new_preds)
            #type of vars is of form (Int Int Bool Int) when there are 4 variables in each copy that p depends on
            #All variables' type of one copy in list_types and variables in list_vars
            list_types = []
            list_vars = []
            for var in self.dict_in_order:
                list_types.append(self.dict_in_order[var])
                list_vars.append(var)

            #print('list_types',list_types)
            #print('list_vars',list_vars)

            signature = '(declare-rel pred_'+refine_type+'_'+str(self.num_new_preds)+' ('+ ' '.join(list_types) +'))'
            #print('reached sign')

            #We now have '(declare-rel p@i (Int Int Bool Int)). Now we describe the predicate.

            #predicate argument is of form (define-fun p ((h_1 Int) (l_0 Int) (h_0 Int)(l_1 Int)) Bool (and (= h_0 h_1) (= l_1 l_0))). We need to obtain the last part where predicate is defined. So find the last occurrence of Bool.
            pred_body = str(new_predicate)
            #print('new_predicate and pred_body',pred_body)
            index_pred_start = pred_body.rfind('Bool') + 5
            #print('pred_body1',pred_body,index_pred_start)
            #tricky with closing braces here
            pred_body = pred_body[index_pred_start:-2]
            #print('\n\n\n pred_body2',pred_body)
            #at this point pred_body has (and (= h_0 h_1) (= l_1 l_0))
            pred_body = pred_body.replace(')',' )').replace('(',' (')
            #print('pred_body3',pred_body)
            predicate_str_with_spaces = pred_body.split(' ')
            #print('pred_body4',predicate_str_with_spaces)
            variables = []
            for i in predicate_str_with_spaces:
                if not(i.find('_') == -1):
                    variables.append(str(i))
            #print('variables',variables,list(reversed(sorted(variables))),type(list(reversed(sorted(variables))))
            #print('variables list before sorting',variables)
            variables = list(sorted(variables))
            #print('variables list after sorting',variables)

            for i in variables:
                last_ = '_'.rfind(i)
                pred_body = pred_body.replace(i,'(rel '+ i[:last_ - 1]+' '+ i[last_:]+')')

            #print('pred_body4',pred_body)
            while not(pred_body.find(') )') == -1 ):
                #print('8.1',pred_body)
                pred_body = pred_body.replace(') )','))')
                pred_body = pred_body.replace('( (','((')
            if not(pred_body[0:5].find('not') == -1):
                pred_body = (pred_body[5:])[:-1]
            #print('pred_body5',pred_body)
            final = ' (pred_'+refine_type+'_'+str(self.num_new_preds)+' '+' '.join(list_vars) +')'
            #print(final)


            rule = '' + signature +'\n (rule (=> '+ pred_body + final+'))'
            #print('in add_new_pred',rule)
            #self.num_new_preds = self.num_new_preds + 1

            #predicate as a rule
            return rule

    def add_new_predicate(self,new_predicate,refine_type):
            #add the predicate to the original smt2 file
            #print('typo00')


            #print('new_predicate at start of add_new_predicate',new_predicate)
            #check if predicate has a 'not' in front


            #print('self.num_new_preds',self.num_new_preds)
            #type of vars is of form (Int Int Bool Int) when there are 4 variables in each copy that p depends on
            #All variables' type of one copy in list_types and variables in list_vars
            list_types = []
            list_vars = []
            for var in self.dict_in_order:
                list_types.append(self.dict_in_order[var])
                list_vars.append(var)

            #print('list_types',list_types)
            #print('list_vars',list_vars)

            signature = '(declare-rel p_'+refine_type+'_'+str(self.num_new_preds)+' ('+ ' '.join(list_types) +'))'
            #print('reached sign')

            #We now have '(declare-rel p@i (Int Int Bool Int)). Now we describe the predicate.

            #predicate argument is of form (define-fun p ((h_1 Int) (l_0 Int) (h_0 Int)(l_1 Int)) Bool (and (= h_0 h_1) (= l_1 l_0))). We need to obtain the last part where predicate is defined. So find the last occurrence of Bool.
            pred_body = str(new_predicate)
            #print('new_predicate and pred_body',pred_body)
            index_pred_start = pred_body.rfind('Bool') + 5
            #print('pred_body1',pred_body,index_pred_start)
            #tricky with closing braces here
            pred_body = pred_body[index_pred_start:-2]
            #print('\n\n\n pred_body2',pred_body)
            #at this point pred_body has (and (= h_0 h_1) (= l_1 l_0))
            pred_body = pred_body.replace(')',' )').replace('(',' (')
            #print('pred_body3',pred_body)
            predicate_str_with_spaces = pred_body.split(' ')
            #print('pred_body4',predicate_str_with_spaces)
            variables = []
            for i in predicate_str_with_spaces:
                if not(i.find('_') == -1):
                    variables.append(str(i))
            #print('variables',variables,list(reversed(sorted(variables))),type(list(reversed(sorted(variables))))
            #print('variables list before sorting',variables)
            variables = list(sorted(variables))
            #print('variables list after sorting',variables)

            for i in variables:
                last_ = '_'.rfind(i)
                pred_body = pred_body.replace(i,'(rel '+ i[:last_ - 1]+' '+ i[last_:]+')')

            #print('pred_body4',pred_body)
            while not(pred_body.find(') )') == -1 ):
                #print('8.1',pred_body)
                pred_body = pred_body.replace(') )','))')
                pred_body = pred_body.replace('( (','((')
            if not(pred_body[0:5].find('not') == -1):
                pred_body = (pred_body[5:])[:-1]
            #print('pred_body5',pred_body)
            final = ' (p_'+refine_type+'_'+str(self.num_new_preds)+' '+' '.join(list_vars) +')'
            #print(final)
            rule = '' + signature +'\n (rule (=> '+ pred_body + final+'))'
            #print('in add_new_pred',rule)
            #self.num_new_preds = self.num_new_preds + 1

            #predicate as a rule
            return rule

    def elements_of_list_as_string(self,lst):
       # print(lst,type(lst))
        for x in lst:
           str_lst = str_lst + str(x)+' '
           #print(str_lst)
        return str_lst


    def eliminate_let(self,formula):

            #print('formula',str(formula))
            formula = formula.replace('\n',' ')
            let_list = str(formula).replace('\n',' ').split('let')
            #print('sl,2,let_list',let_list)
            line = []
            for i in let_list:
                     line.append(re.sub('\s+',' ',i))
            #print('line : ',line)
            #print('sl,3,line')
            aux_vars = []
            for i in line:
                for j in i.split(' '):
                    if not(j.find('!') == -1):
                        v = j.replace('(','').replace(')','').replace('  ',' ')
                        if not(v in aux_vars):
                            aux_vars.append(v)
            #print('sl,4',aux_vars)
            aux_vars_dict = dict()
            rest_list = []
            #''+aux_var[i]+'.*'+aux_var[i+1]
            for i in range(len(aux_vars)):
                #print('------------'+str(i)+'----------')
                #print(i,aux_vars[i])
                a = formula.find(aux_vars[i])
                aux_var = aux_vars[i]
                #print(a,formula[a-1])
                #print('here')
                #print('a-1',a-1)
                #print('sl,5',aux_var)
                aux_vars_dict[aux_var], index_next_open_br,c = self.find_match_paren(str(formula),a-1)
                #print('sl,6',aux_vars_dict[aux_var], index_next_open_br)
                rest_list.append(index_next_open_br)
            #print('sl,7,rl',rest_list)
            #find index of opening parenthesis of the expression after lets, assumes )(
            #print('sl,8,aux_vars_dict',aux_vars_dict)
            #rev_aux_vars_dict = list(reversed(sorted(aux_vars_dict.keys())))
            #print('rev_aux_vars_dict',rev_aux_vars_dict)
            #print('000000000000000000')
            #print('dd',str(formula))
            count = 0

            while(count <= len(aux_vars)+1):
                for aux_var in aux_vars_dict:
                    i=0
                    formula =str(formula[:index_next_open_br])+  str(formula[index_next_open_br:]).replace(aux_var,aux_vars_dict[aux_var])
                    #print('dd',formula)
                    i += 1
                count +=1
            #print('sl,9,formula:', formula,formula.count('let'))
            num_brackets_after_tr =  formula.count('let') * -1
            #print('sl,10 num_brackets_after_tr',num_brackets_after_tr)
            formula = formula.rstrip()
            #and_ind=formula.find('(and')
            return(formula[index_next_open_br:num_brackets_after_tr])


    def check_parentheses(self,s):
        """ Return True if the parentheses in string s match, otherwise False. """
        j = 0
        for c in s:
            if c == ')':
                j -= 1
                if j < 0:
                    return False
            elif c == '(':
                j += 1
        return j == 0

    def find_parentheses(self,s):
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

    def paren_dict_func(self,formula):
        test_strings = [str(formula)]

        for i, s in enumerate(test_strings, start=1):
            #print('\ntest string {}:\n{}'.format(i, s))
            if(self.check_parentheses(s)):
                try:
                    #print(s)
                    parentheses_locs = self.find_parentheses(s)

                except IndexError as e:
                    print(str(e))
        return parentheses_locs

    def find_match_paren(self,formula,index):
        test_strings = [str(formula)]

        for i, s in enumerate(test_strings, start=1):
            #print('\ntest string {}:\n{}'.format(i, s))
            if(self.check_parentheses(s)):
                try:
                    #print(s)
                    parentheses_locs = self.find_parentheses(s)
                    #print(type(parentheses_locs))
                    #print('Parentheses locations:\n{}'.format(str(sorted([(k,v) for k, v in parentheses_locs.items()]))))
                    #print('\n s'+s+'\n\n\n ngirhdg')
                    '''
                    for k in sorted(parentheses_locs.keys()):
                        #print(k,parentheses_locs[k])
                        #print(s[k+1:k+4])
                        #print('--')
                        if s[k+1:k+4] == 'let':

                            print(s[k:parentheses_locs[k]])
                            print('\n')
                    '''
                    #print('hio',type(parantheses_locs))

                except IndexError as e:
                    print(str(e))

        min_after_index = len(str(formula)) - 1
        next_open_index = len(str(formula)) - 1
        #print(min_after_index,next_open_index,index)
        for open_br in parentheses_locs:
                        #print('in here')
                        if open_br > index and open_br < min_after_index:
                            min_after_index = open_br

        #print('aiai',str(formula)[min_after_index:parentheses_locs[min_after_index]+1])
        #print('aiaiai',str(formula)[min_after_index:parentheses_locs[min_after_index]])
        #print('min_after_index',min_after_index,str(formula)[min_after_index:parentheses_locs[min_after_index]+1])
        #exit()
        #print('a!i defn :',str(formula)[min_after_index:parentheses_locs[min_after_index]])
        #print('min_after_index',min_before_index)
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
        #print('index of the close_br',close_br)
        #print('a!i defn3 :',close_br_min_before_index,str(formula)[ close_br_min_before_index:])
        for open_br in parentheses_locs:
                        #print('in here')
                        if open_br > close_br and open_br < next_open_index:
                            next_open_index = open_br
        #print('next_open_index',next_open_index)
        #print('formula[next_open_ind:close]',str(formula)[next_open_index:parentheses_locs[next_open_index]+1])
        #print(';;;;;;;;;;;;;;;;;;;;;;;;')
        return(str(formula)[min_after_index:parentheses_locs[min_after_index]+1],next_open_index,parentheses_locs)

    #returns string which conjuncts the input clauses provided in infix notation
    def inf_to_pre(self,inf):
            operators = ['<=','>=','<','>','=']


            list_prefix=[]

            for eq in inf:
                for o in operators:
                    res = eq.find(o)
                    #print(res)
                    #print(eq)
                    if not(res == -1):
                        if o == '<=' or '>=':
                            list_prefix.append('('+ o + ' '+eq[0:res]+' '+eq[res+1:]+')')
                            break
                        else:
                            list_prefix.append('('+ o +' '+ eq[0:res]+' '+eq[res:]+')')
                            break
                if res == -1:
                    list_prefix.append(eq)
            return list_prefix
            '''
            str_prefix='and('
            for i in list_prefix:
                str_prefix = str_prefix + i
            str_prefix=str_prefix +')'
   '''         '''
    def dump_to_z3_file_p(self,formula,vars_dict,pred_meaning,pred_meaning_p):
            print("In dump_to_z3_file")
            f_sl.write('from z3 import *\n')
            for var in vars_dict:
                f_sl.write(str(var)+' = '+str(vars_dict[var])+'(\''+str(var)+'\')\n')
            for var in vars_dict:
                f_sl.write(str(var)[:-2]+'p'+str(var)[-2:]+' = '+str(vars_dict[var])+'(\''+str(var)[:-2]+'p'+str(var)[-2:]+'\')\n')
            f_sl.write('\n')
            print('1')
            for p in self.pred_string_dict:
                f_sl.write(str(p) + '=' + 'Bool(\''+str(p)+'\')\n')
            print('2')
            for p in self.pred_string_dict:
                f_sl.write(str(p)+'p' + '=' + 'Bool(\''+str(p)+'p'+'\')\n')
            print('3')
            f_sl.write('\n')

            print('4')
            #[ f_sl.write(str(clause).replace(' ','')) for clause in str(formula).split(',')]
            #f_sl.write('a_src_formula = Bool('+'\''+'a_src_formula'+'\''+')\n')
            #f_sl.write('a_src_formula = '+str(formula).replace('\n','')+'\n')
            f_sl.write('a=simplify(And('+str(formula).replace('\n','').replace('  ','')+'))\n')
            print('5')

            f_sl.write('g = Goal()\n')
            print('6')
            f_sl.write('g.add(a)\n')
            print('7')
            f_sl.write('t = Tactic(\'propagate-values\')\n')
            print('8')
            f_sl.write('op = t(g)\n')
            print('9')
            #f_sl.write('print(\'And(\'+str(op)[2:][:-2]+\')')
            #f_sl.write('print(simplify(And('+str(formula).replace('\n','')+','+a_str[:-1]+')).sexpr())')
            f_sl.write('print(\'And(\'+str(op.sexpr())[15:][:-1]+\')\')\n')
            f_sl.close()
            print('10')
            cmd = 'python3 a_src_tgt.py > a_src.txt'
            os.system(cmd)
            print('11')
            print('Finished dumping to sl file, now reading from txt....')
            #read the file
            f_txt = open('a_src.txt','r')
            str_prefix = f_txt.read()
            print('12')
            print('str_prefix',str_prefix)
            return str_prefix
    '''
    def dump_to_z3_file(self,formula,is_src_tgt_subs_bad,vars_dict,pred_meaning):

            #print("In dump_to_z3_file")
            #print(formula)
            if is_src_tgt_subs_bad == 0:
                f_sl = open(self.folder_path + "a_src.py","w")
            elif is_src_tgt_subs_bad == 1:
                f_sl = open(self.folder_path + "a_tgt.py","w")
            elif is_src_tgt_subs_bad == 2:
                f_sl = open(self.folder_path + "a_tgt_subs.py","w")
            elif is_src_tgt_subs_bad == 3:
                f_sl = open(self.folder_path + "a_not_bad.py","w")
            else:
                print('wrong z3 file')
                SystemExit()

            f_sl.write('from z3 import *\n')
            #print('vars_dict',vars_dict)
            for var in vars_dict:
                f_sl.write(str(var)+' = '+str(vars_dict[var])+'(\''+str(var)+'\')\n')
            f_sl.write('\n')
            for p in self.pred_string_dict:
                f_sl.write(str(p) + '=' + 'Bool(\''+str(p)+'\')\n')
            f_sl.write('\n')
            alist=[]
            #print('pred_meaning',pred_meaning)
            for pred in pred_meaning:

                f_sl.write(str(pred) + ' = ('+str(pred_meaning[pred]).replace('=','==').replace('>==','>=').replace('<==','<=')+')\n')
                alist.append(str(pred) + ' = '+str(pred_meaning[pred])+',')

            a_str = ''
            f_sl.write('\n')
            for a in alist:
                a_str = a_str + str(a).replace('=','==').replace('<==','<=').replace('>==','>=')
            #print('str(formula)',str(formula))
            #[ f_sl.write(str(clause).replace(' ','')) for clause in str(formula).split(',')]
            #f_sl.write('a_src_formula = Bool('+'\''+'a_src_formula'+'\''+')\n')
            #f_sl.write('a_src_formula = '+str(formula).replace('\n','')+'\n')
            #print('formula just before simplify statement',formula)
            f_sl.write('a=simplify(And('+str(formula).replace('\n','')+'))\n')

            f_sl.write('print(a.sexpr())\n')


            '''
            f_sl.write('g = Goal()\n')

            f_sl.write('g.add(a)\n')
            f_sl.write('t = Tactic(\'propagate-values\')\n')
            f_sl.write('op = t(g)\n')

            #f_sl.write('print(\'And(\'+str(op)[2:][:-2]+\')')
            #f_sl.write('print(simplify(And('+str(formula).replace('\n','')+','+a_str[:-1]+')).sexpr())')
            f_sl.write('print(\'And(\'+str(op.sexpr())[15:][:-1]+\')\')\n')
            '''
            f_sl.close()
            '''
            if is_src_tgt_subs_bad == 0:
                print('a-src')
            elif is_src_tgt_subs_bad == 1:
                print('a_tgt')
            elif is_src_tgt_subs_bad == 2:
                print('a_tgt_subs')
            elif is_src_tgt_subs_bad == 3:
                print('not_bad')
            else:
                print('wrong z3 file')
                SystemExit()
            '''
            if is_src_tgt_subs_bad == 0:
                f_a_src_tgt = open(self.folder_path + "a_src.py","r")
            elif is_src_tgt_subs_bad == 1:
                f_a_src_tgt = open(self.folder_path + "a_tgt.py","r")
            elif is_src_tgt_subs_bad == 2:
                f_a_src_tgt = open(self.folder_path + "a_tgt_subs.py","r")
            elif is_src_tgt_subs_bad == 3:
                f_a_src_tgt = open(self.folder_path + "a_not_bad.py","r")
            else:
                print('wrong z3 file')
                SystemExit()
            #print('\n'.join(f_a_src_tgt.readlines()))
            print('\n\n\n')
            if is_src_tgt_subs_bad == 0 :
                cmd = 'python3 ' + self.folder_path + 'a_src.py > '+ self.folder_path+'a_src.txt'
            elif is_src_tgt_subs_bad == 1:
                cmd = 'python3 ' + self.folder_path + 'a_tgt.py > '+ self.folder_path + 'a_tgt.txt'
            elif is_src_tgt_subs_bad == 2 :
                cmd = 'python3 ' + self.folder_path + 'a_tgt_subs.py > ' + self.folder_path +  'a_tgt_subs.txt'
            elif is_src_tgt_subs_bad == 3:
                cmd = 'python3 ' + self.folder_path + 'a_not_bad.py > '+ self.folder_path + 'a_not_bad.txt'
            else:
                SystemExit()
            os.system(cmd)
            #print('Finished dumping to sl file, now reading from txt....')
            #read the file
            if is_src_tgt_subs_bad == 0 :
                f_txt = open(self.folder_path + 'a_src.txt','r')
            elif is_src_tgt_subs_bad == 1:
                f_txt = open(self.folder_path + 'a_tgt.txt','r')
            elif is_src_tgt_subs_bad == 2:
                f_txt = open(self.folder_path + 'a_tgt_subs.txt','r')
            elif is_src_tgt_subs_bad == 3:
                f_txt = open(self.folder_path + 'a_not_bad.txt','r')
            else:
                SystemExit()
            str_prefix = f_txt.read()
            #print('str_prefix',str_prefix)
            if not(str_prefix.find('let') == -1):
                str_prefix = self.eliminate_let(str_prefix)
            #print('--------el----',el)
            #print('last of dump_to_z3_file',str_prefix)
            return str_prefix



    def dump_to_sl_file(self,c_src,c_tgt,a_src,a_tgt,vars_in_c_src,vars_in_c_src_p,tr):

            #preprocessing
            #print("In dump_to_sl_file")
            #print('yay',c_src,c_tgt,a_src,a_tgt,vars_in_c_src,vars_in_c_src_p,tr)
            #print(type(vars_in_c_src),type(vars_in_c_src_p))
            vars_in_c_src_str = ''
            for v in vars_in_c_src:
                vars_in_c_src_str = vars_in_c_src_str + ' '+v

            vars_in_c_src_str_for_p = ''
            for v in vars_in_c_src:
                if v.find('pc') == -1:
                    vars_in_c_src_str_for_p = vars_in_c_src_str_for_p + ' '+v
            #print('hereeeeeeeeeeeeeeeeeeeee',vars_in_c_src_str)

            vars_in_c_src_strp = ''
            #print('\n\n yay %s \n\n' %(a_src))
            for v in vars_in_c_src_p:
                vars_in_c_src_strp = vars_in_c_src_strp + ' '+v
            #print('hereee',vars_in_c_src_strp)
            comments = ';;c_src '+str(c_src).replace('\n',' ')+'\n'+';;c_tgt '+str(c_tgt).replace('\n',' ')+'\n'+';;a_src '+str(a_src).replace('\n',' ')+'\n'+';;a_tgt '+str(a_tgt).replace('\n',' ')+'\n'+';;tr '+str(tr).replace('\n',' ')+'\n\n'

            #tr without new line
            #print('tr',tr)
            tr_string = str(tr)
            #writing to file starts here
            filename = "query"+str(self.num_new_preds)+".sl"
            f= open(self.folder_path + filename,"w")



            grammar = ';;grammar'+'\n'+'(set-logic LIA)'+'\n'+'(synth-fun p ('
            for x in vars_in_c_src:
                if x.find('pc') == -1:
                    grammar = grammar + '('+str(x)+ ' '+vars_in_c_src[x]+')'
            grammar = grammar + ') Bool \n'+'           ((B Bool) (I Int)(C Int))\n'+'           ((B Bool ('
            for x in vars_in_c_src:
                if vars_in_c_src[x] == 'Bool':
                    grammar = grammar +  x + ' '
            grammar = grammar +'(and B B) (or B B) (not B) \n'+'                      (= I I) (< I I) (> I I)))\n'+'            (I Int ('
            for x in vars_in_c_src:
                if x.find('pc') == -1:
                    if vars_in_c_src[x] == 'Int':
                        grammar = grammar +  x + ' '
            grammar = grammar + 'C \n'+'                      (+ I I) (* C I) (- I I)))\n'
            grammar = grammar + '\t\t\t\t\t\t(C Int ( 0 1 2 3 4 5 6 7 8 42 383 1009)))'+'\n\n)\n\n'

            f.write(comments)
            f.write(grammar)

            #define c_src function
            c_src_fun = '(define-fun c_src ('

            for x in vars_in_c_src:
                c_src_fun = c_src_fun + '('+str(x)+' '+ str(vars_in_c_src[x])+')'
            c_src_fun= c_src_fun+ ') Bool '+ str(c_src).replace('\n','').replace('  ','') +')\n'
            f.write(c_src_fun)
            f.write('\n')
            #define a_src_final function
            a_src_fun = '(define-fun a_src ('
            for x in vars_in_c_src:
                a_src_fun = a_src_fun + '('+str(x)+' '+ str(vars_in_c_src[x])+')'
            a_src_fun= a_src_fun+ ') Bool  '+ str(a_src).replace('\n','').replace('  ','') +')\n'
            f.write(a_src_fun)
            f.write('\n')
            #define a_tgt function
            a_tgt_fun = '(define-fun a_tgt ('

            for x in vars_in_c_src:
                a_tgt_fun = a_tgt_fun + '('+str(x)+' '+ str(vars_in_c_src[x])+')'
            a_tgt_fun= a_tgt_fun+ ') Bool  '+ str(a_tgt).replace('\n','') +')\n'
            f.write(a_tgt_fun)

            f.write('\n')


            #define trans function
            trans_fun = '(define-fun trans('

            for x in vars_in_c_src:
                trans_fun = trans_fun + '('+str(x)+ ' '+ str(vars_in_c_src[x])+ ' )'

            for x in vars_in_c_src_p:
                trans_fun = trans_fun + '('+str(x)+' '+ str(vars_in_c_src_p[x])+')'

            trans_fun= trans_fun+ ') Bool  '+ tr+')\n\n'
            for x in vars_in_c_src:
                trans_fun = trans_fun + '(declare-var '+str(x)+' '+ str(vars_in_c_src[x])+' )\n'

            for x in vars_in_c_src_p:
                trans_fun = trans_fun + '(declare-var '+str(x)+' '+ str(vars_in_c_src_p[x])+' )\n'
            trans_fun = trans_fun + '\n'
            f.write(trans_fun)

            #print('trans_fun')

            #constraint 1
            constraints=[]


            constraints.append('(constraint (=> (c_src '+vars_in_c_src_str+')' +' (p '+vars_in_c_src_str_for_p +')))\n')
            constraints.append('(constraint (=> (and (a_src '+vars_in_c_src_str+') (p '+vars_in_c_src_str_for_p +') (trans '+vars_in_c_src_str+ vars_in_c_src_strp+')) (not (a_tgt '+vars_in_c_src_strp+'))))\n')
            '''
            constraints.append('(constraint (=> (p '+vars_in_c_src_str+') (a_src '+vars_in_c_src_str+')))\n')
            '''
            fourth = '(constraint (exists ('
            for x in vars_in_c_src:
                fourth = fourth + '('+x+' '+ str(vars_in_c_src[x])+' )'
            fourth = fourth + ')'+'(and (not (c_src '+vars_in_c_src_str+')) (p '+vars_in_c_src_str_for_p +'))))\n\n\n'
            constraints.append(fourth)
            for c in constraints:
                f.write(c)
            f.write('(check-synth)')
            f.close()
            #print('iihhih')
            filename = 'p_sol_'+str(self.num_new_preds)+'.txt'
            #cmd = './cvc4-1.8-x86_64-linux-opt  --sygus-active-gen=enum query'+str(self.num_new_preds)+'.sl >'+ filename
            cmd = './cvc4-1.8-x86_64-linux-opt --sygus-active-gen=enum '+self.folder_path+'query'+str(self.num_new_preds)+'.sl > ' + self.folder_path + filename


            os.system(cmd)
            p_sol_fd = open(self.folder_path + filename,"r")
            new_predicate = ''.join(p_sol_fd.readlines()[1:])
            p_sol_fd.close()


            #new_predicate = '(define-fun p ((h_1 Int) (l_0 Int) (count_0 Int) (h_0 Int) (count_1 Int) (l_1 Int)) Bool (and (= h_0 h_1) (= count_1 count_0)))'


            if not(new_predicate.find('define') == -1):
                print('new predicate is ' + str(new_predicate) + '')
                rule = self.add_new_predicate(new_predicate,'synth')
            else:
                return ['-1']
            return rule


    def write_to_z3_file(self,c_src,c_tgt,a_src,a_tgt,vars_in_c_src,vars_in_c_src_p,tr,a_tgt_subs):
            f_z3 = open(self.folder_path + "query_z3.smt2","w")
            f_z3.write(';c_src:'+str(c_src).replace('\n','').replace('  ','')+'\n')
            f_z3.write(';c_tgt:'+str(c_tgt).replace('\n','').replace('  ','')+'\n')
            f_z3.write(';a_src:'+str(a_src).replace('\n','').replace('  ','')+'\n')
            f_z3.write(';a_tgt:'+str(a_tgt).replace('\n','').replace('  ','')+'\n')
            f_z3.write(';tr:'+str(tr).replace('\n','').replace('  ','')+'\n')
            f_z3.write("(declare-rel p (")
            str_vars_type_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_type_in_c_src = str_vars_type_in_c_src + ''+ str(vars_in_c_src[var])+' '
            str_vars_type_in_c_src = str_vars_type_in_c_src[:-1]
            f_z3.write(str_vars_type_in_c_src+")) \n\n")

            f_z3.write("(assert (forall (")
            for var in vars_in_c_src:
                f_z3.write("("+str(var)+" "+str(vars_in_c_src[var])+")")
            f_z3.write(") ")
            f_z3.write("(=> ")
            f_z3.write(c_src)
            f_z3.write(" (p ")
            str_vars_in_c_src =''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_z3.write(str_vars_in_c_src+ '))))')
            f_z3.write('\n\n')

            f_z3.write("(assert (forall (")
            for var in vars_in_c_src:
                f_z3.write("("+str(var)+" "+str(vars_in_c_src[var])+")")
            for var in vars_in_c_src_p:
                f_z3.write("("+str(var)+" "+str(vars_in_c_src_p[var])+")")
            f_z3.write(") ")
            f_z3.write("(=> (and ")
            f_z3.write(a_src[:-1])
            f_z3.write(' (p ')
            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_z3.write(str_vars_in_c_src+') ')
            f_z3.write(tr[:-1])
            f_z3.write('))')

            f_z3.write('(not '+str(a_tgt_subs) +')))\n\n')

            #insert((atgt xp))
            '''
            f_z3.write('(assert (forall (')
            for var in vars_in_c_src:
                f_z3.write("("+str(var)+" "+str(vars_in_c_src[var])+")")
            f_z3.write(') ')
            f_z3.write('(=> (p ')
            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_z3.write(str_vars_in_c_src+') ')

            f_z3.write(a_src)
            f_z3.write('))\n\n')
            '''
            f_z3.write('(assert (exists (')
            for var in vars_in_c_src:
                f_z3.write("("+str(var)+" "+str(vars_in_c_src[var])+")")
            f_z3.write(') ')
            f_z3.write('(and (not ')
            f_z3.write(str(c_src))
            f_z3.write(') ')
            f_z3.write('(p ')
            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + ''+ str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]

            f_z3.write(str_vars_in_c_src+ '))))\n\n')

            f_z3.write('(check-sat)\n')
            f_z3.write('(get-model)')
            f_z3.close()

            cmd = 'z3 ' + self.folder_path + 'query_z3.smt2 > '+ self.folder_path + 'query_z3.txt'
            os.system(cmd)

            qz = open(self.folder_path + "query_z3.txt","r")
            new_pred_using_z3 = ''.join(qz.readlines())
            last_occ_Bool = new_pred_using_z3.rfind('Bool')
            print(new_pred_using_z3[last_occ_Bool+1:-1])

            return True


    def write_to_smt2_file(self,c_src,c_tgt,a_src,a_tgt,vars_in_c_src,vars_in_c_src_p,tr,a_tgt_subs,c_src_original,c_tgt_original,a_src_original,a_tgt_original,tr_original):
            f_smt = open(self.folder_path + "query_smt2.smt2","w")
            #print('before writing')
            #print('c_src-original',c_src_original)
            f_smt.write(";; c_src : "+ str(c_src_original).replace('\n','').replace('  ','') +"\n\n")
            f_smt.write(";; a_src : "+ str(a_src_original).replace('\n','').replace('  ','') +"\n\n")
            f_smt.write(";; a_tgt : "+ str(a_tgt_original).replace('\n','').replace('  ','') +"\n\n")
            f_smt.write(";; tr : "+ str(tr_original).replace('\n','').replace('  ','') +"\n\n")

            #print('afterwriting')

            f_smt.write("(declare-rel p (")

            str_vars_type_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_type_in_c_src = str_vars_type_in_c_src + ''+ str(vars_in_c_src[var])+' '
            str_vars_type_in_c_src = str_vars_type_in_c_src[:-1]
            f_smt.write(str_vars_type_in_c_src+")) \n")
            f_smt.write("(declare-rel fail () )\n")
            f_smt.write("(declare-rel l (")
            #print('hoi1')
            str_vars_type_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_type_in_c_src = str_vars_type_in_c_src + ''+ str(vars_in_c_src[var])+' '
            str_vars_type_in_c_src = str_vars_type_in_c_src[:-1]
            f_smt.write(str_vars_type_in_c_src+")) \n")
            for var in vars_in_c_src:
                f_smt.write("(declare-var "+str(var)+" "+str(vars_in_c_src[var])+")\n")
            for var in vars_in_c_src_p:
                f_smt.write("(declare-var "+str(var)+" "+str(vars_in_c_src_p[var])+")\n")
            f_smt.write('\n\n')
            f_smt.write('(rule (=> ')
            f_smt.write(c_src)
            f_smt.write(' (p ')

            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + ''+ str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_smt.write(str_vars_in_c_src+"))) \n\n")
            #second rule
            f_smt.write('(rule (=> (and ')
            f_smt.write(a_src[:-1])
            f_smt.write(' (p ')

            f_smt.write(str_vars_in_c_src+') ')
            f_smt.write(tr[:-1])
            f_smt.write('('+a_tgt_subs) #<---a_tgt(x_next)
            f_smt.write(') fail)) \n\n')
            '''
            #third_rule
            f_smt.write('(rule (=> (and (p ')
            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + ''+ str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_smt.write(str_vars_in_c_src+') ')
            f_smt.write('(not'+a_tgt+'')
            f_smt.write(') fail))\n\n')
            '''
            #fourth rule
            f_smt.write('(rule (=> (and (l ')
            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + ''+ str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_smt.write(str_vars_in_c_src+') ')
            f_smt.write('(not'+c_src+')) (p ')
            str_vars_in_c_src = ''
            for var in vars_in_c_src:
                str_vars_in_c_src = str_vars_in_c_src + ''+ str(var)+' '
            str_vars_in_c_src = str_vars_in_c_src[:-1]
            f_smt.write(str_vars_in_c_src+') ')
            f_smt.write('))\n')

            f_smt.write('(query fail:print-certificate true)')
            return True

