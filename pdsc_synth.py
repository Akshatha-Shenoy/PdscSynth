import argparse
from z3 import *
import datetime
from pdsc import pdscAlgo
import sys
import z3.z3printer

z3.z3printer._PP.max_lines = 999999
z3.z3printer._Formatter.max_depth = 999999
z3.z3printer._Formatter.max_args = 999999
z3.z3printer._Formatter.max_visited = 999999


def is_valid_file(parser, arg):
    if not os.path.exists(arg):
        parser.error("Invalid file %s" % arg)
    else:
        return arg


def check_prop(value):
    ivalue = int(value)
    if ivalue not in [1, 2, 3]:
        raise argparse.ArgumentTypeError("invalid property: %s" % value)
    return ivalue


def initialise_cmd_args():
    parser = argparse.ArgumentParser("Property Directed Self Composition")
    input_type_group = parser.add_mutually_exclusive_group(required=True)
    input_type_group.add_argument('-qe', help="use Quantifier elimination using z3 in refinement loop",
                                  action="store_true")
    input_type_group.add_argument('-sygus', help="use SyGuS based solver in refinement loop", action="store_true")
    input_type_group.add_argument('-msat', help="use mathsat5 interpolant in refinement loop", action="store_true")
    #input_type_group.add_argument('-msat_qe', help="use mathsat5 interpolant in refinement loop", action="store_true")

    parser.add_argument('-f', '--file', required=True, help="path to input file",
                        type=lambda x: is_valid_file(parser, x))
    parser.add_argument('-p', '--property', help="property 1,2 or 3 of comparator", type=check_prop)
    parser.add_argument('-log', help='print traces', action="store_true")
    return parser


def remove_synth_preds(args):
    smt_fd_r = open(args.file, "r")
    lines = smt_fd_r.readlines()
    smt_fd_r.close()
    num_of_lines = len(lines)
    start_l_no_to_erase = 0
    for l_no in range(len(lines)):
        if lines[l_no].find("synth") != -1:
            start_l_no_to_erase = l_no
            break
    if start_l_no_to_erase != 0:
        smt_fd_w = open(args.file, "w")
        lines = ''.join(lines[:start_l_no_to_erase]) + '\n' + lines[-1]
        # smt_fd.truncate(0)
        smt_fd_w.write(lines)
        smt_fd_w.close()


def print_results(start_time,args):
    end_time = datetime.datetime.now()
    smt_fd_r = open(args.file, "r")
    lines = smt_fd_r.readlines()
    smt_fd_r.close()
    lines_str = ' '.join(lines)
    num_preds_discv = lines_str.count('synth')/2
    num_of_lines = len(lines)
    time_tkn = end_time - start_time
    print("Total time taken :", time_tkn.total_seconds())
    print("Number of predicates guessed:", num_preds_discv)


def process_args(args):
    if args.qe:
        solver_in_refinement = "qe"
        solver_in_refinement2 = "qe"
    elif args.sygus:
        solver_in_refinement = "SyGuS"
        solver_in_refinement2 = "SyGuS"
    elif args.msat:
        solver_in_refinement = "msat_qe"
        solver_in_refinement2 = "msat"
    #elif args.msat_qe:
    #    solver_in_refinement = "msat_qe"
    # create a directory to store all files generated in the execution
    time_stamp = datetime.datetime.now()
    loc_gen_folder_name = "tmp_REMOVE_DIR_" + (str(args.file).split('/')[-1])[:-5] + "_" + solver_in_refinement2 + "_" + str(time_stamp).replace(' ', '_')
    filename_sign= "tmp_" + (str(args.file).split('/')[-1])[:-4] + "_" + solver_in_refinement2+" ".replace(' ', '_')

    os.mkdir(loc_gen_folder_name)
    return loc_gen_folder_name,filename_sign


def main():
    parser = initialise_cmd_args()
    args = parser.parse_args()
    loc_gen_folder_name,filename_sign = process_args(args)
    # remove any synth predicates from previous executions of tool
    remove_synth_preds(args)
    start_time = datetime.datetime.now()
    # run one iteration of pdsc

    run = pdscAlgo(args, loc_gen_folder_name,filename_sign)
    restart = run.pdsc_algo()
    # count : Number of iterations of pdsc run until now
    count = 0
    while True:
        if restart:
            restart = run.pdsc_algo()
            print("Start next refinement loop:", restart)
            print('\n\n')
            count += 1
        else:
            print_results(start_time, args)
            break
    return True

if __name__ == '__main__':
    sys.exit(main())
