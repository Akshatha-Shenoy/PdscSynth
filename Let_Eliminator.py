import argparse
import io
import tarfile 
import time 
from z3 import *
import datetime
import docker
import sys, traceback
import re
class LetEliminatorClass:
    def __init__(self,let_expr):
            print('hi')
            self.formula = re.sub('\s+',' ',let_expr.replace('\n',' ').replace('(',' ( ').replace(')',' ) '))
            self.paren_dict = self.paren_dict_func()  
            self.aux_vars = [] 
            self.aux_vars_first_occ = self.find_aux_vars_first_occ()                          
            self.aux_vars_dict = self.find_aux_vars_dict()            
            self.aux_vars_subs_dict = self.find_aux_vars_subs_dict()
            self.letless_formula = self.remove_lets_from_formula(self.formula)
            self.final_formula = self.find_final_formula()
            
            
    def paren_dict_func(self):
        test_strings = [str(self.formula)]
        for i, s in enumerate(test_strings, start=1):
            if(self.count_parentheses(s)):
                try:
                    parentheses_locs = self.create_parentheses_dict(s)
                except IndexError as e:
                    print(str(e))
        print('paren_dict',parentheses_locs)
        return parentheses_locs
    
        
    def create_parentheses_dict(self,s):
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
        
    def count_parentheses(self,s):
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
 
    
    def find_aux_vars_first_occ(self):            
            aux_vars_first_occ_dict = dict()
            lets_list = str(self.formula).split('let')                      
            for let_expr in lets_list:
                for term in let_expr.split(' '):
                    if  ((not(term.find('.') == -1)) or (not(term.find('!') == -1))):                       
                        if not(term in self.aux_vars):
                            self.aux_vars.append(term+' ')
                            aux_vars_first_occ_dict[term+' '] = self.formula.find(term+' ') 
            print('aux_vars_first_occ_dict',aux_vars_first_occ_dict) 
            return aux_vars_first_occ_dict             
             
    def find_aux_vars_dict(self):
            #self.aux_vars_dict[.cse21]= (<= (+ h_1 (- i_1)) 0), self.aux_vars_dict[.cse12] = "(ite .cse21 1 0)" 
            aux_vars_dict = dict()
            for i in range(len(self.aux_vars)):         
                aux_var = self.aux_vars[i]
                open_br_index = self.aux_vars_first_occ[aux_var] - 2
                close_br_index = self.paren_dict[open_br_index]
                defn = self.formula[open_br_index + 1 + len(aux_var) + 1 :close_br_index]     
                aux_vars_dict[aux_var] = defn
            print('aux_vars_dict',aux_vars_dict)                  
            return aux_vars_dict
                
    def find_aux_vars_subs_dict(self):            
            #self.aux_vars_dict[.cse12] = "(ite (<= (+ h_1 (- i_1)) 0) 1 0)"       
            aux_vars_subs_dict = dict() 
            for aux in self.aux_vars:    
                subst_defn = self.aux_vars_dict[aux]
                print('subs1',subst_defn)
                subst_defn = self.remove_lets_from_formula(subst_defn)
                print('subs2',subst_defn)
                for inner_aux in self.aux_vars:
                    indices = [m.start() for m in re.finditer(inner_aux, subst_defn)]                                       
                    reversed_indices = [ele for ele in reversed(indices)]                                        
                    if inner_aux in subst_defn:
                        print(inner_aux)
                        for i in reversed_indices:
                             print(i)
                             print('aux_vars_subs_dict',aux_vars_subs_dict) 
                             if inner_aux in aux_vars_subs_dict:
                                subst_defn = subst_defn[: i] + aux_vars_subs_dict[inner_aux] +  subst_defn[i + len(inner_aux):]
                             else:
                                subst_defn = subst_defn[: i] + self.aux_vars_dict[inner_aux] +  subst_defn[i + len(inner_aux):]
                    aux_vars_subs_dict[aux] = subst_defn  
            print('aux_vars_subs_dict ',aux_vars_subs_dict)                                               
            return aux_vars_subs_dict
                                  
    def remove_lets_from_formula(self,expr): 
        letless_formula = expr
        while(True):
            if not(letless_formula.find('let ') == -1):    
                let_index = letless_formula.find('let ')
                new_paren_dict = self.create_parentheses_dict(letless_formula)
                print(new_paren_dict)
                cl = new_paren_dict[let_index+4] 
                outer_cl = new_paren_dict[let_index -2]               
                letless_formula = letless_formula[0:let_index-2] + letless_formula[cl+1:outer_cl]+ letless_formula[outer_cl+1:]      
            else:
                break 
        print('remove lets from formula')
        return re.sub('('+'\s+'+')',' ',letless_formula) 
        
    def find_final_formula(self):
        final_formula = self.letless_formula
        print('final_formula',final_formula)
        for aux in self.aux_vars:
            final_formula = final_formula.replace(aux,self.aux_vars_subs_dict[aux])
        return final_formula
   
    
    

        
        
