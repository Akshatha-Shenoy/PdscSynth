DoubleSquare has 4 predicates to be synthesised to be able to obtain a proof of soundness, namely
1. z1 = 2 * z0
2. z1 = 2 * z0 - 1
3. y1 = 2 * y0
4. y1 = 2 * y0 + x0

There are 15 files in this folder, each providing only a subset of predicates as input except the one in which all 4 are provided. Our tool proves safety in all the cases by discovering necessary predicates demonstrating the robustness of the tool.

Naming: 
============================
If the 4 predicates are mapped to 
    A: z1 = 2 * z0
    B: z1 = 2 * z0 - 1
    C: y1 = 2 * y0
    D: y1 = 2 * y0 + x0
then name of the file is doubleSquare_ABCD.smt2 where A, B, C, D is replaced with 1 or 0 depending on whether the predicate is provided in input or not respectively.

Example:
==========
  doubleSquare_0110.smt2 contains z1 = 2 * z0 - 1 and y1 = 2 * y0 in the input file(has B and C predicates).

To run doubleSquare0110.smt2:
> cd [PATH_TO_PdscSynth]
> python3 pdsc_synth.py -[msat/qe/sygus] -f ./doubleSquareVariants/doubleSquare0110.smt2

The input file after executing the above command is identical to the file with same name in [PATH_TO_PdscSynth]/Output/[msat/qe/sygus]/doubleSquareVariants

 To compare the output for doubleSquare_0110.smt2 using SyGuS,check with the file [PATH_TO_PdscSynth]/doubleSquareVariants/sygus/doubleSquare_0110.smt2.

