from z3 import *
xp_1 = Int('xp_1')
hp_1 = Int('hp_1')
countp_0 = Int('countp_0')
hp_0 = Int('hp_0')
xp_0 = Int('xp_0')
countp_1 = Int('countp_1')

x0_eq_x1=Bool('x0_eq_x1')
p_synth_1=Bool('p_synth_1')
p_synth_2=Bool('p_synth_2')
p_synth_3=Bool('p_synth_3')
p_synth_4=Bool('p_synth_4')
p_synth_5=Bool('p_synth_5')
abs_h_0=Bool('abs_h_0')
count_0_0=Bool('count_0_0')
abs_h_1=Bool('abs_h_1')
count_0_1=Bool('count_0_1')

x0_eq_x1p = ((xp_0 == xp_1))
p_synth_1p = ((xp_1 == 8))
p_synth_2p = ((xp_1 < 42))
p_synth_3p = ((xp_1 == 42))
p_synth_4p = ((xp_1 == xp_1))
p_synth_5p = ((xp_1 == xp_1))
abs_h_0p = ((1 == hp_0))
count_0_0p = ((countp_0 == 0))
abs_h_1p = ((1 == hp_1))
count_0_1p = ((countp_1 == 0))

a=simplify(And(And(And(x0_eq_x1p == False,        p_synth_1p == False,        p_synth_2p == False,        p_synth_3p == False,        p_synth_4p == True,        p_synth_5p == True,        abs_h_0p == True,        count_0_0p == False,        abs_h_1p == True,        count_0_1p == False))))
print(a.sexpr())
