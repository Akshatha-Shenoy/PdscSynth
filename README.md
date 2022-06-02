
PdscSynth
---------

PdscSynth is a tool designed on top of PDSC (https://bitbucket.org/sharonsh/pdsc/src/master/), corresponding to the work presented in our FMCAD 2022 submission (paper ID 103).

To individually run each benchmark from command prompt, follow the next section. To run all the benchmarks at once, see [here](#2-to-run-all-benchmarks-at-once-using-sygus-qe-and-msat).

1. Running a benchmark
------------------------------------

Description of the PdscSynth directory
---------------------------------------
This repository has a README file and a license file. There are 3 techniques used to refine predicates, namely SyGuS, Quantifier Elimination and Interpolation using MathSAT5. These techniques are abbreviated as sygus, qe, and msat respectively in our tool. There is a logs folder consisting of traces printed upon running the tool on benchmarks using each of the techniques, which are stored seperately in respective subdirs. 

Refining using SyGuS
--------------------------
The input smt files are present in "Benchmarks_sygus" directory. Each of these files consists of a code that declares variables, specifies the pre- and post-conditions, transition relations and a section specifying the proof language (given as a set of input predicates at the bottom of the file). When the tool is run, the newly discovered predicates are appended to the bottom of the file.

In the "sygus" folder of "Output" directory, we have given all the benchmarks that have been appended by the predicates discovered by our tool, should the reviewers wish to take a look at the final output. The predicates synthesised by PdscSynth have the substring  "_synth_" in predicate names, and can be found at the bottom of each file.

Refining using QE
--------------------------
The input smt files are present in "Benchmarks_qe" directory. Each of these files consists of a code that declares variables, specifies the pre- and post-conditions, transition relations and a section specifying the proof language (given as a set of input predicates at the bottom of the file). When the tool is run, the newly discovered predicates are appended to the bottom of the file.

In the "qe" folder of "Output" directory, we have given all the benchmarks that have been appended by the predicates discovered by our tool, should the reviewers wish to take a look at the final output. The predicates synthesised by PdscSynth have the substring  "_synth_" in predicate names, and can be found at the bottom of each file.

Refining using MathSAT5
--------------------------
The input smt files are present in "Benchmarks_msat" directory. Each of these files consists of a code that declares variables, specifies the pre- and post-conditions, transition relations and a section specifying the proof language (given as a set of input predicates at the bottom of the file). When the tool is run, the newly discovered predicates are appended to the bottom of the file.

In the "msat" folder of "Output" directory, we have given all the benchmarks that have been appended by the predicates discovered by our tool, should the reviewers wish to take a look at the final output. The predicates synthesised by PdscSynth have the substring  "_synth_" in predicate names, and can be found at the bottom of each file.

The "interpolants" folder consists of intermediate files that are used by the interpolating prover (MathSAT5, in our case). The files in the folder may be deleted after the tool has run.

Note that files in Benchmarks_sygus, Benchmarks_qe and Benchmarks_msat before running the tool are identical and copies of the directories have been made just for convenience.

Command to execute a benchmark
-------------------------------
To run the tool on input files, execute
> timeout 5m python3 pdsc_synth.py -[qe/msat/sygus] -f ./Benchmarks_[qe/msat/sygus]/[INPUT_FILENAME].smt2

Options explained
-------------------
1. sygus : The option sygus as the name suggests refers to the SyGuS technique aided by CVC 1.8 to obtain predicates. 
   For example: To execute inc_dec on pdsc_synth using SyGuS, execute
    > timeout 5m python3 pdsc_synth.py -sygus -f ./Benchmarks/inc_dec.smt2
    
2. qe : Specifies the use of Z3's quantifier elimination tactic to add new predicates in refinement loop of the tool.
   For example: To run inc_dec using qe, run
    > timeout 5m python3 pdsc_synth.py -qe -f ./Benchmarks/inc_dec.smt2

3. msat : Refers to the use of Mathsat5.6.6 to obtain sequence interpolants. To run pdsc_synth with mathsat in refinement loop, execute
    > timeout 5m python3 pdsc_synth.py -msat -f ./Benchmarks/inc_dec.smt2

 Output
------------
1. Unsafe : The program outputs that the program is not safe, concrete counter example, number of predicates added.
2. Safe : The program outputs that the program is safe, an invariant, number of predicates added. 

The predicates discovered during refinement will be appended to the input file. Synthesised predicates have substring  "_synth_" in predicate names. Although the tool modifies the input file by appending these predicates, please note that any predicate that has "_synth_" in its name gets removed automatically when the tool is run.

After the tool has run, the input file can be inspected to see the predicates that have been added newly. These predicates will be at the bottom of the input file and as explained above, they will have a "_synth_" in their names.

There are some intermediate folders that are generated, with names starting with "tmp_REMOVE_DIR_", consisting of intermediate files produced during a run of the tool. These folders may be deleted after the tool is run.

2. To run all benchmarks at once using SyGuS, QE and MSAT
---------------------------------------------------------
We can run all benchmarks at once using run_benchmarks.py with the refinement technique i.e.sygus, qe and msat given as an argument, the results are respectively stored in sygus_output.txt, qe_output.txt and msat_output.txt. Each line in these files consists of benchmark_name, time taken by the tool, whether the tool reports the benchmark safe or unsafe and the number of refinement predicates added by PdscSynth. If PdscSynth times out on the benchmark, TIMEOUT is mentioned next to the benchmark_name.
>python3  run_benchmarks.py -[sygus/qe/msat]

Example: To run all benchmarks on sygus,
>python3 run_benchmarks.py -sygus

The result is in sygus_output.txt. 

The motivating example doubleSquare requires 4 non-trivial predicates to be discovered.  The folder "doubleSquareVariants" consists of all variants of doubleSquare where (non-empty) subsets of these 4 predicates are not supplied and hence need to be discovered by the tool. These additional benchmarks are not mentioned in the paper, but we created them to get a number of examples of varying difficulty and to understand what kind of predicates may be easy/difficult to find.
These variants may be run similarly, like any other benchmark. We have run all of them using all the three options with PdscSynth -- the msat option works for all of them; qe works for two of them; sygus was unable to get any. The predicates discovered by these options for each file can be found appended to the file, in the three subfolder - msat, qe, and sygus.

3. Comparison with LLREVE
-----------------------------
"LLREVE_Input" is the directory that consists of necessary files to run LLREVE on our benchmarks. To run LLREVE, follow section b of this README file. This folder consists of subfolders for each benchmark (except squareSum, as it is not a program equivalence checking problem, and hence cannot be run on LLREVE). 

We run the benchmarks that check for program equivalence on the LLREVE tool. 

To run using LLREVE
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

To run using Eldarica 2.0.8,
>  ./eldarica/eld ./LLREVE_Output/[INPUT_FILENAME]_llreve.smt2

Example: To run Eldarica 2.0.8 on the smt2 file generated by LLREVE when run on inc_dec,
>  ./eldarica/eld ./LLREVE_Output/inc_dec_llreve.smt2

Note that there is only one doubleSquare version to be run on LLREVE as all variations of doubleSquare have the same two input programs and only vary in the input set of predicates.

The folder "eldarica" consists of files necessary to run Eldarica solver.

LLREVE Output
-----------------
z3 4.8.9 and Eldarica 2.0.8, when given the .smt2 file created by llreve, may either timeout, or can produce one of the following results:

1. "unknown"- which means the programs are equivalent but cannot be proven by LLREVE (shown as 'unknown' in the table in the paper)
2. "unsat" - which means the input programs are not equivalent (shown as the time taken, in seconds, in the table)
3. a model - if the programs are equivalent and z3 is able to obtain the model (shown as the time taken, in seconds, in the table)


Contact us
-----------

In case any clarification is needed, please do write to us:

Akshatha Shenoy (akshathabshenoy@gmail.com)
Kumar Madhukar (madhukar.k.singh@gmail.com)




