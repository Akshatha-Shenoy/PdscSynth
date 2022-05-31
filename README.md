
pdscSynth
---------

pdscSynth is a tool designed on top of PDSC, corresponding to the work presented in our FSE 2022 submission (paper ID 103).

To individually run each benchmark from command prompt, follow the next section.


a. Running a benchmark:
------------------------------------
==============================================================

Description of the pdscSynth directory
---------------------------------------
This repository has a README file and a license file. There are 3 techniques used to refine predicates, namely SyGuS, Quantifier Elimination and using Interpolants using Mathsat5. Each of these techniques are abbreviated as sygus, qe, msat respectively in our tool. There is a logs folder consisting of traces printed upon running the tool on benchmarks using each of the techniques, which are stored seperately in each subdirectories. 

Refining using Sygus
--------------------------
Input smt files are present in "Benchmarks_sygus" directory. Each of these files consists of a code that declares variables, specifies the pre and postconditions, transition relations and a section specifying the proof language (given as a set of input predicates at the bottom of the file). When the tool is run, the newly discovered predicates are appended to the bottom of the file.

In the "sygus" folder of "Output" directory, we have given all the benchmarks that have been appended by the predicates discovered by our tool, in case the reviewers wish to take a look at the final output. The predicates synthesised by pdscSynth have the substring  "_synth_" in predicate names, and can be find at the bottom of each file.

In the "sygus_logs" folder, we have given the trace printed in all the benchmarks while running the tool.

Refining using QE
--------------------------
Input smt files are present in "Benchmarks_qe" directory. Each of these files consists of a code that declares variables, specifies the pre and postconditions, transition relations and a section specifying the proof language (given as a set of input predicates at the bottom of the file). When the tool is run, the newly discovered predicates are appended to the bottom of the file.

In the "qe" folder of "Output" directory, we have given all the benchmarks that have been appended by the predicates discovered by our tool, in case the reviewers wish to take a look at the final output. The predicates synthesised by pdscSynth have the substring  "_synth_" in predicate names, and can be find at the bottom of each file.

In the "qe_logs" folder, we have given the trace printed in all the benchmarks while running the tool.


Refining using Mathsat5
--------------------------
Input smt files are present in "Benchmarks_msat" directory. Each of these files consists of a code that declares variables, specifies the pre and postconditions, transition relations and a section specifying the proof language (given as a set of input predicates at the bottom of the file). When the tool is run, the newly discovered predicates are appended to the bottom of the file.

In the "msat" folder of "Output" directory, we have given all the benchmarks that have been appended by the predicates discovered by our tool, in case the reviewers wish to take a look at the final output. The predicates synthesised by pdscSynth have the substring  "_synth_" in predicate names, and can be find at the bottom of each file.

In the "msat_logs" folder, we have given the trace printed in all the benchmarks while running the tool.

The "interpolants" folder consists of intermediate files that are used by the interpolating prover (MathSAT5, in our case). The files in the folder may also be deleted after the tool has run.


Note that files in Benchmarks_sygus, Benchmarks_qe and Benchmarks_msat before running the tool are identical and copies of the directories are made for convenience.

LLREVE
----------------

"LLREVE_Input" is a directory that consists of necessary files to run LLREVE on our benchmarks. To run LLREVE, follow section b of the README file. This folder consists of subfolders for each benchmark (except squareSum, as it is not a program equivalence checking problem, hence can not be run on LLREVE). 


There are some intermediate folders that are generated, with names starting with "tmp_REMOVE_DIR_", consisting of intermediate files produced during a run of the tool. These folders may be deleted after the tool is run.


The motivating example doubleSquare requires 4 non-trivial predicates to be discovered.  The folder "doubleSquareVariants" consists of all variants of doubleSquare where (non-empty) subsets of these 4 predicates are not supplied and hence need to be discovered by the tool. These additional benchmarks are not mentioned in the paper, but we created them to get a number of examples of varying difficulty and to understand what kind of predicates may be easy/difficult to find.
These variants may be run similarly, like any other benchmark. We have run all of them using all the three options with pdscSynth -- the msat option works for all of them; qe works for two of them; sygus was unable to get any. The predicates discovered by these options for each file can be found appended to the file, in the three subfolder - msat, qe, and sygus.


Command to execute a benchmark
-------------------------------
To run the tool on input files, execute
> timeout 5m python3 pdsc_synth.py -[qe/msat/sygus] -f ./Benchmarks_[qe/msat/sygus]/[INPUT_FILENAME].smt2


Options explained:
-------------------
1. sygus : The option sygus as the name suggests refers to the SyGuS technique aided by CVC 1.8 to obtain predicates. 
   For example: To execute inc_dec on pdsc_synth using SyGuS, execute
    > timeout 5m python3 pdsc_synth.py -sygus -f ./Benchmarks/inc_dec.smt2
    
2. qe : Specifies the use of Z3's quantifier elimination tactic to add new predicates in refinement loop of the tool.
   For example: To run inc_dec using qe, run
    > timeout 5m python3 pdsc_synth.py -qe -f ./Benchmarks/inc_dec.smt2

3. msat : Refers to the use of Mathsat5.6.6 to obtain sequence interpolants. To run pdsc_synth with mathsat in refinement loop, execute
    > timeout 5m python3 pdsc_synth.py -msat -f ./Benchmarks/inc_dec.smt2

 Output:
------------
1. Unsafe : The program outputs that the program is not safe, concrete counter example, number of predicates added.
2. Safe : The program outputs that the program is safe, an invariant, number of predicates added. 

The predicates discovered during refinement will be appended to the input file. Synthesised predicates have substring  "_synth_" in predicate names. Although the tool modifies the input file by appending these predicates, please note that any predicate that has "_synth_" in its name gets removed automatically when the tool is run.

After the tool has run, the input file can be inspected to see the predicates that have been added newly. These predicates will be at the bottom of the input file and as explained above, they will have a "_synth_" in their names.


b. Comparison with LLREVE
-----------------------------
==============================================================

We run the benchmarks that check for program equivalence on the LLREVE tool. 

To run using LLREVE:
--------------------
Two C files are generated for each benchmark, which encodes the two programs for which equivalence is checked. These files are present in folder named by the benchmark in the LLREVE_Input directory. We store the output of LLREVE in an SMT2 file in LLREVE_Output directory.
> ./llreve  ./LLREVE_Input/[INPUT_FILENAME]/[INPUT_FILENAME].c ./LLREVE_Input/[INPUT_FILENAME]/[INPUT_FILENAME]_2.c > ./LLREVE_Output/[INPUT_FILENAME]/[INPUT_FILENAME]_llreve.smt2 

Example: To run inc_dec on LLREVE,
> ./llreve ./LLREVE_Input/inc_dec/inc_dec.c ./LLREVE_Input/inc_dec/inc_dec_2.c > ./LLREVE_Output/inc_dec_llreve.smt2

 This SMT file is run using Z3 4.8.9 solver or Elderica solver to check for equivalence. 
To run using Z3,
>  z3 ./LLREVE_Output/[INPUT_FILENAME]_llreve.smt2

Example: To run z3 on the smt2 file generated by LLREVE when run on inc_dec,
> z3 ./LLREVE_Output/inc_dec_llreve.smt2

To run using Elderica,
>  ./elderica/eld ./LLREVE_Output/[INPUT_FILENAME]_llreve.smt2

Example: To run Elderica on the smt2 file generated by LLREVE when run on inc_dec,
>  ./elderica/eld ./LLREVE_Output/inc_dec_llreve.smt2

Note that there is only one doubleSquare version to be run on LLREVE as all variations of doubleSquare have the same two input programs and only vary in the input set of predicates.

The folder "elderica" consists of files necessary to run Elderica solver.

LLREVE Output:
-----------------
z3 and Elderica, when given the .smt2 file created by llreve, may either timeout, or can produce one of the following results:

1. "unknown"- which means the programs are equivalent but cannot be proven by LLREVE (shown as 'unknown' in the table in the paper)
2. "unsat" - which means the input programs are not equivalent (shown as the time taken, in seconds, in the table)
3. a model - if the programs are equivalent and z3 is able to obtain the model (shown as the time taken, in seconds, in the table)


Contact us:
-----------

In case any clarification is needed, please do write to us:

Akshatha Shenoy (akshathabshenoy@gmail.com)
Kumar Madhukar (madhukar.k.singh@gmail.com)




