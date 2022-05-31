import tarfile
import time
from z3 import *
import datetime
import docker
import sys
from dynamic_sc_pdr_qe import DynamicSelfCompositionPDR_qe
from dynamic_sc_pdr_sygus import DynamicSelfCompositionPDR_sygus
from dynamic_sc_pdr_msat import DynamicSelfCompositionPDR_msat
from dynamic_sc_pdr_msat_qe import DynamicSelfCompositionPDR_msat_qe

import os


class pdscAlgo:
    def __init__(self, args, loc_gen_folder_name,filename_sign):
        self.args = args
        self.num_new_preds = 0
        self.loc_gen_folder_name = loc_gen_folder_name
        self.filename_sign = filename_sign
        self.solver = None

    def copy_to_container(self, cont, artifact_file):
        with self.create_archive(artifact_file) as archive:
            cont.put_archive(path='/opt/seahorn', data=archive)

    def create_archive(self, artifact_file):
        pw_tarstream = io.BytesIO()
        pw_tar = tarfile.TarFile(fileobj=pw_tarstream, mode='w')
        file_data = open(artifact_file, 'rb').read()
        tarinfo = tarfile.TarInfo(name=os.path.basename(artifact_file))
        tarinfo.size = len(file_data)
        tarinfo.mtime = time.time()
        # tarinfo.mode = 0600
        try:
            pw_tar.addfile(tarinfo, io.BytesIO(file_data))
        except:
            print("Unexpected error:", sys.exc_info()[0])
        pw_tar.close()
        pw_tarstream.seek(0)
        return pw_tarstream

    def copy_from_container(self, cont, filename):
        bits, stat = cont.get_archive(path='/opt/seahorn/smt/' + filename)
        tar_path = '/tmp/temp.tar'
        temp_tar = open(tar_path, 'wb')
        for chunk in bits:
            temp_tar.write(chunk)
        temp_tar.flush()
        temp_tar.close()
        my_tar = tarfile.open(tar_path, mode='r')
        smt_file = my_tar.getmembers()[0]
        f = my_tar.extractfile(smt_file)
        content = f.read()
        out_file = open('/tmp/' + filename, 'wb')
        try:
            out_file.write(content)
        except:
            print("Unexpected error:", sys.exc_info()[0])
        my_tar.close()
        out_file.flush()
        out_file.close()
        return '/tmp/' + filename

    def get_smt2(self, c_file):
        print(c_file + ': Translating to smt2 with SeaHorn')
        client = docker.from_env()
        seahorn_container = None
        for container in client.containers.list(all=True):
            if 'seahorn' in str(container.image):
                seahorn_container = container
                print("working with " + container.id + " (" + str(container.image) + ")")
                break
        seahorn_container.start()
        self.copy_to_container(seahorn_container, c_file)
        seahorn_container.exec_run('bash run_seahorn.sh', workdir='/opt/seahorn')
        print('bash run_seahorn.sh')
        return self.copy_from_container(seahorn_container, os.path.basename(c_file)[:-1] + 'smt2')

    def pdsc_algo(self):
        global restart
        self.num_new_preds = self.num_new_preds + 1
        new_predicate = None
        print_table = False
        table = ""
        file_list = [self.args.file]
        for curr_file in file_list:
            try:
                filename = curr_file
                pp_delta = self.pre_processing(filename)
                start = datetime.datetime.now()
                msg, smt_count, num_preds, restart, new_predicates = self.solver.solve(self.num_new_preds)
                #print('',msg, smt_count, num_preds, restart, new_predicates)
                end = datetime.datetime.now()
                print(msg)
                delta = end - start
                table = self.print_stats(table,pp_delta,delta,num_preds,smt_count,msg,filename,new_predicates)
            except:
                #print("Unexpected error:", sys.exc_info()[0])
                table += curr_file + ";\t" + str(0) + ";\t" + str(0) + ";\t" + "F" + ";" + str(0) + ";" + str(0) + "\n"
                restart = False
                #print('in exception, restart = false')
        if print_table:
            print(table)
        return restart

    def add_new_pred_to_smt(self, new_predicates):
        fname = str(self.args.file).split('/')[-1]
        new_file = open(self.args.file, "r")
        original_lines = new_file.readlines()
        num_of_lines = len(original_lines)
        line_before = num_of_lines - 1
        line_after = num_of_lines - 1
        lines = ''.join(original_lines[:line_before])
        # for predic in new_predicates:
        if len(new_predicates) == 2:
            lines = lines + str(new_predicates[0]) + '\n' + str(new_predicates[1]) + '\n'
        else:
            lines = lines + str(new_predicates[0]) + '\n'
        lines = lines + ''.join(original_lines[line_after:])
        new_file.close()
        new_file = open(self.args.file, "w")
        # Append new_predicate at the end of file
        new_file.truncate(0)
        new_file.write(lines)
        new_file.close()
        print('Successfully added new predicate to input file. !')
        return True

    def pre_processing(self,filename):
        print("PDSC: Verifying " + filename)
        pp_start = datetime.datetime.now()
        print(self.args)
        if self.args.qe:
            self.solver = DynamicSelfCompositionPDR_qe(filename, force_predicate_abstraction=True,
                                                  is_comparator=False, method_name="compare", bmc="True",
                                                  explicit_conposition_function=True,
                                                  folder_name=self.loc_gen_folder_name, print_log=self.args.log,
                                                  prop=self.args.property)
        elif self.args.sygus:
            self.solver = DynamicSelfCompositionPDR_sygus(filename, force_predicate_abstraction=True,
                                                     is_comparator=False, method_name="compare", bmc="True",
                                                     explicit_conposition_function=True,
                                                     folder_name=self.loc_gen_folder_name,
                                                     print_log=self.args.log, prop=self.args.property)
        elif self.args.msat:
            print('In if ladder',self.args.msat)
            self.solver = DynamicSelfCompositionPDR_msat_qe(filename, force_predicate_abstraction=True,
                                                         is_comparator=False, method_name="compare", bmc="True",
                                                         explicit_conposition_function=True,
                                                         folder_name=self.loc_gen_folder_name, filename_sign = self.filename_sign,
                                                         print_log=self.args.log, prop=self.args.property)

        pp_end = datetime.datetime.now()
        pp_delta = pp_end - pp_start
        return pp_delta

    def print_stats(self,table,pp_delta,delta,num_preds,smt_count,msg,filename,new_predicates):
        print("Pre-processing time:\t" + str(pp_delta.total_seconds()) + " \nSolver time:\t" + str(
            delta.total_seconds()) + "\nTotal time:\t" + str(
            delta.total_seconds() + pp_delta.total_seconds()) + "\nIteration count:\t" + str(
            smt_count) + "\nPredicate count:\t" + str(num_preds))
        if "violated" in msg or "starvation" or "Real Cex" in msg:
            table += filename + ";\t" + str(delta.total_seconds()) + ";\t" + str(
                pp_delta.total_seconds() + delta.total_seconds()) + ";\t" + "N" + ";" + str(
                smt_count) + ";" + str(num_preds) + "\n"
            if not(str(new_predicates) == 'None'):
                self.add_new_pred_to_smt(new_predicates)
            else:
                exit(0)
        else:
            table += filename + ";\t" + str(delta.total_seconds()) + ";\t" + str(
                pp_delta.total_seconds() + delta.total_seconds()) + ";\t" + "Y" + ";" + str(
                smt_count) + ";" + str(num_preds) + "\n"

        return table