import argparse
from z3 import *
import datetime
import sys
import z3.z3printer


def initialise_cmd_args():
    parser = argparse.ArgumentParser("Property Directed Self Composition Automated")
    input_type_group = parser.add_mutually_exclusive_group(required=True)
    input_type_group.add_argument('-qe', help="use Quantifier elimination using z3 in refinement loop",
                                  action="store_true")
    input_type_group.add_argument('-sygus', help="use SyGuS based solver in refinement loop", action="store_true")
    input_type_group.add_argument('-msat', help="use mathsat5 interpolant in refinement loop", action="store_true")
    # input_type_group.add_argument('-msat_qe', help="use mathsat5 interpolant in refinement loop", action="store_true")
    parser.add_argument('-log', help='print traces', action="store_true")
    return parser


def main():
    parser = initialise_cmd_args()
    args = parser.parse_args()

    if args.qe:
        directory = 'Benchmarks_qe'
        for filename in os.listdir(directory):
            f = os.path.join(directory, filename)
            # checking if it is a file
            if os.path.isfile(f):
                print(f)
                fd_qe = open("qe_output.txt", "a+")
                start_time = datetime.datetime.now()
                os.system(
                    "timeout 12m python3 pdsc_synth.py " + "-qe " + "-f ./Benchmarks_qe/" + filename + " > " + "./logs/qe/" + filename[:-5] + ".txt")
                end_time = datetime.datetime.now()
                total_time = end_time - start_time
                total = (str(total_time).split(':'))[1]
                print('total time',total_time)
                print('total',total)
                fd_qe_op = open("./logs/qe/" + filename[:-5] + ".txt")
                lines = fd_qe_op.readlines()
                fd_qe_op.close()
                #print('lines[-1]',lines[-1])
                #print('lines[-2]',lines[-2])

                lines = '\n'.join(lines)
                print('total',total)

                if lines.find("Proved by invariant:") != -1:
                    lines_of_log = fd_qe.readlines()
                    lines_of_log = '\n'.join(lines_of_log)
                    count = lines[lines.rfind('guessed: ')+ 9:lines.rfind('guessed: ')+ 14]
                    lines_of_log = lines_of_log + str(filename) + "," + str(
                        total_time) + "," + "safe" + "," + str(count) + "\n"
                    fd_qe.write(lines_of_log)
                elif lines.find("Real cex") != -1:
                    lines_of_log = fd_qe.readlines()
                    lines_of_log = '\n'.join(lines_of_log)

                    count = lines[lines.rfind('guessed: ')+ 9:lines.rfind('guessed: ')+ 14]
                    lines_of_log = lines_of_log + str(filename) + "    " + str(
                        total_time) + "," + "unsafe" + "," + str(count) + "\n"
                    fd_qe.write(lines_of_log)
                else:
                    lines_of_log = fd_qe.readlines()
                    lines_of_log = '\n'.join(lines_of_log)
                    lines_of_log = lines_of_log + str(filename) + "," + "TIMEOUT" + "\n"
                    fd_qe.write(lines_of_log)
                fd_qe.close()
    elif args.msat:
        directory = 'Benchmarks_msat'
        for filename in os.listdir(directory):
            f = os.path.join(directory, filename)
            # checking if it is a file
            if os.path.isfile(f):
                print(f)

            fd_msat = open("msat_output.txt", "a+")
            start_time = datetime.datetime.now()

            os.system(
                "timeout 12m python3 pdsc_synth.py " + "-msat " + "-f ./Benchmarks_msat/" + filename + " > " + "./logs/msat/" + filename[
                                                                                                                                 :-5] + ".txt")
            end_time = datetime.datetime.now()
            total_time = end_time - start_time
            total = (str(total_time).split(':'))[1]
            fd_msat_op = open("./logs/msat/" + filename[:-5] + ".txt")
            lines = fd_msat_op.readlines()
            fd_msat_op.close()

            print('lines[-1]', lines[-1])
            print('lines[-2]', lines[-2])
            count = lines[-1].split(' ')[-1]
            lines = '\n'.join(lines)
            if int(total) > 11:
                lines_of_log = fd_msat.readlines()
                lines_of_log = '\n'.join(lines_of_log)
                lines_of_log = lines_of_log + str(filename) + "," + "TIMEOUT" + "\n"
                fd_msat.write(lines_of_log)
            elif lines.find("Proved by invariant:") != -1:
                lines_of_log = fd_msat.readlines()
                lines_of_log = '\n'.join(lines_of_log)
                lines_of_log = lines_of_log + str(filename) + "," + str(
                    total_time) + "," + "safe" + "," + str(count) + "\n"
                fd_msat.write(lines_of_log)
            else:
                lines_of_log = fd_msat.readlines()
                lines_of_log = '\n'.join(lines_of_log)
                lines_of_log = lines_of_log + str(filename) + "," + str(
                    total_time) + "," + "unsafe" + "," + str(count) + "\n"
                fd_msat.write(lines_of_log)
            fd_msat.close()
    else:
        directory = 'Benchmarks_sygus'
        for filename in os.listdir(directory):
            f = os.path.join(directory, filename)
            # checking if it is a file
            if os.path.isfile(f):
                print(f)
                fd_sygus = open("sygus_output.txt", "a+")
                start_time = datetime.datetime.now()
                os.system(
                    "timeout 12m python3 pdsc_synth.py " + "-sygus " + "-f ./Benchmarks_sygus/" + filename + " > " + "./logs/sygus/" + filename[:-5] + ".txt")
                end_time = datetime.datetime.now()
                total_time = end_time - start_time
                total = (str(total_time).split(':'))[1]
                print('total time',total_time)
                print('total',total)
                fd_sygus_op = open("./logs/sygus/" + filename[:-5] + ".txt")
                lines = fd_sygus_op.readlines()
                fd_sygus_op.close()
                #print('lines[-1]',lines[-1])
                #print('lines[-2]',lines[-2])

                lines = '\n'.join(lines)
                print('total',total)

                if lines.find("Proved by invariant:") != -1:
                    lines_of_log = fd_sygus.readlines()
                    lines_of_log = '\n'.join(lines_of_log)
                    count = lines[lines.rfind('guessed: ')+ 9:lines.rfind('guessed: ')+ 14]
                    lines_of_log = lines_of_log + str(filename) + "," + str(
                        total_time) + "," + "safe" + "," + str(count) + "\n"
                    fd_sygus.write(lines_of_log)
                elif lines.find("Real cex") != -1:
                    lines_of_log = fd_sygus.readlines()
                    lines_of_log = '\n'.join(lines_of_log)

                    count = lines[lines.rfind('guessed: ')+ 9:lines.rfind('guessed: ')+ 14]
                    lines_of_log = lines_of_log + str(filename) + "    " + str(
                        total_time) + "," + "unsafe" + "," + str(count) + "\n"
                    fd_sygus.write(lines_of_log)
                else:
                    lines_of_log = fd_sygus.readlines()
                    lines_of_log = '\n'.join(lines_of_log)
                    lines_of_log = lines_of_log + str(filename) + "," + "TIMEOUT" + "\n"
                    fd_sygus.write(lines_of_log)
                fd_sygus.close()
    return True


if __name__ == '__main__':
    sys.exit(main())

