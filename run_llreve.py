import argparse
from z3 import *
import datetime
import sys
import z3.z3printer


def initialise_cmd_args():
    parser = argparse.ArgumentParser("Run LLREVE on all benchmarks")
    input_type_group = parser.add_mutually_exclusive_group(required=True)
    input_type_group.add_argument('-z3', help="use Z3 solver", action="store_true")
    input_type_group.add_argument('-eld', help="use Eldarica solver", action="store_true")
    return parser


def main():
    parser = initialise_cmd_args()
    args = parser.parse_args()
    if args.z3:
        fd_z3 = open("z3_llreve.txt", "a+")
        fd_z3.truncate(0)
        fd_z3.close()
        directory = 'LLREVE_Input'
        for benchmark in os.listdir(directory): 
            print('benchmark',benchmark)          
            paths = []
            for filename in os.listdir(os.path.join(directory,benchmark)):
                print('filename',filename)
                p = os.path.join(benchmark, filename)
                print('p',p)
                # checking if it is a file
                paths.append(str(p))
            print('1')        
            fd_z3 = open("z3_llreve.txt", "a+")  
            output = fd_z3.readlines()
            output ='\n'.join(output)
            print('2',output)
            print('paths',paths)
            os.system("./llreve " + "./LLREVE_Input/" + paths[0] + " ./LLREVE_Input/"+paths[1] + " > ./LLREVE_Output/" + benchmark +".smt2")
                        
            start_time = datetime.datetime.now()
            os.system("timeout 1m z3 "+"./LLREVE_Output/" + benchmark +".smt2 >"+ "z3_llreve_log.txt")
            end_time = datetime.datetime.now()
            total_time = end_time - start_time
            total = (str(total_time).split(':'))[1]
            print('total time',total_time)
            print('total',total)
            
            fd_z3_log= open("z3_llreve_log.txt",)
            lines = fd_z3_log.readlines()            
            lines = '\n'.join(lines)
            if lines.find("unknown") != -1:
                    output = output + str(benchmark) + ", " + str(total_time) + "," + " unknown" + "\n"
                    fd_z3.write(output)
            elif lines.find("unsat") != -1:
                    output= fd_z3.readlines()
                    output = '\n'.join(output)
                    output = str(benchmark) + ", " + str(total_time) + "," + " unsat" + "\n"
                    fd_z3.write(output)
            elif lines.find("model"):
                    output = fd_z3.readlines()
                    output = '\n'.join(output)
                    output = output + str(benchmark) + ", " + str(total_time) +", model" + "\n"
                    fd_z3.write(output)
            else:
                    output = fd_z3.readlines()
                    output = '\n'.join(output)
                    output = output + str(benchmark) + ", " +"TIMEOUT" + "\n"
                    fd_z3.write(output)
            fd_z3.close()
    if args.eld:
        fd_eld = open("eld_llreve.txt", "a+")
        fd_eld.truncate(0)
        fd_eld.close()
        directory = 'LLREVE_Input'
        for benchmark in os.listdir(directory): 
            print('benchmark',benchmark)          
            paths = []
            for filename in os.listdir(os.path.join(directory,benchmark)):
                print('filename',filename)
                p = os.path.join(benchmark, filename)
                print('p',p)
                # checking if it is a file
                paths.append(str(p))
            print('1')        
            fd_eld = open("eld_llreve.txt", "a+")  
            output = fd_eld.readlines()
            output ='\n'.join(output)
            print('2',output)
            print('paths',paths)
            os.system("./llreve " + "./LLREVE_Input/" + paths[0] + " ./LLREVE_Input/"+paths[1] + " > ./LLREVE_Output/" + benchmark +".smt2")
                        
            start_time = datetime.datetime.now()
            os.system("timeout 1m ./eldarica/eld "+"./LLREVE_Output/" + benchmark +".smt2 >"+ "eld_llreve_log.txt")
            end_time = datetime.datetime.now()
            total_time = end_time - start_time
            total = (str(total_time).split(':'))[1]
            print('total time',total_time)
            print('total',total)
            
            fd_eld_log= open("eld_llreve_log.txt")
            lines = fd_eld_log.readlines()            
            lines = '\n'.join(lines)
            
            if lines.find("unknown") != -1:
                    output = output + str(benchmark) + ", " + str(total_time) + "," + " unknown" + "\n"
                    fd_eld.write(output)
            elif lines.find("unsat") != -1:
                    output= fd_eld.readlines()
                    output = '\n'.join(output)
                    output = str(benchmark) + ", " + str(total_time) + "," + " unsat" + "\n"
                    fd_eld.write(output)
            elif lines.find("sat") != -1:
                    output = fd_eld.readlines()
                    output = '\n'.join(output)
                    output = output + str(benchmark) + ", " + str(total_time) +", sat" + "\n"
                    fd_eld.write(output)
            else:
                    output = fd_eld.readlines()
                    output = '\n'.join(output)
                    output = output + str(benchmark) + ", " +"TIMEOUT" + "\n"
                    fd_eld.write(output)
            fd_eld.close()
    
    return True


if __name__ == '__main__':
    sys.exit(main())

