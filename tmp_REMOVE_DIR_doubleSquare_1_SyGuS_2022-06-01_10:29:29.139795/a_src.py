from z3 import *
x_1 = Int('x_1')
h_1 = Int('h_1')
h_0 = Int('h_0')
x_0 = Int('x_0')
end_0 = Int('end_0')
z_0 = Int('z_0')
y_0 = Int('y_0')
y_1 = Int('y_1')
z_1 = Int('z_1')
end_1 = Int('end_1')

z0_eq_z1=Bool('z0_eq_z1')
y0_eq_y1=Bool('y0_eq_y1')
x0_eq_x1=Bool('x0_eq_x1')
x0_gt_0=Bool('x0_gt_0')
p_synth_1=Bool('p_synth_1')
p_synth_2=Bool('p_synth_2')
p_synth_3=Bool('p_synth_3')
p_synth_4=Bool('p_synth_4')
y_gteq_0_0=Bool('y_gteq_0_0')
z_gteq_0_0=Bool('z_gteq_0_0')
abs_end_0=Bool('abs_end_0')
abs_h_0=Bool('abs_h_0')
y_gteq_0_1=Bool('y_gteq_0_1')
z_gteq_0_1=Bool('z_gteq_0_1')
abs_end_1=Bool('abs_end_1')
abs_h_1=Bool('abs_h_1')

z0_eq_z1 = ((z_0 == z_1))
y0_eq_y1 = ((y_0 == y_1))
x0_eq_x1 = ((x_0 == x_1))
x0_gt_0 = ((x_0 > 0))
p_synth_1 = ((x_1 < z_1))
p_synth_2 = ((x_1 == z_0))
p_synth_3 = ((x_1 == h_1))
p_synth_4 = ((x_1 == z_1 - x_1))
y_gteq_0_0 = ((y_0 >= 0))
z_gteq_0_0 = ((z_0 >= 0))
abs_end_0 = ((1 == end_0))
abs_h_0 = ((1 == h_0))
y_gteq_0_1 = ((y_1 >= 0))
z_gteq_0_1 = ((z_1 >= 0))
abs_end_1 = ((1 == end_1))
abs_h_1 = ((1 == h_1))

a=simplify(And(And(z0_eq_z1 == True,    y0_eq_y1 == False,    x0_eq_x1 == True,    x0_gt_0 == True,    p_synth_1 == False,    p_synth_2 == True,    p_synth_3 == True,    p_synth_4 == False,    y_gteq_0_0 == True,    z_gteq_0_0 == True,    abs_end_0 == False,    abs_h_0 == False,    y_gteq_0_1 == True,    z_gteq_0_1 == True,    abs_end_1 == False,    abs_h_1 == True)))
print(a.sexpr())
