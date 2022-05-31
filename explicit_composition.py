import z3


class ExplicitComposition:
    def __init__(self, dynamic_program, ctx):
        self.state_to_next_step = []
        self.dp = dynamic_program
        self.ctx = ctx

    def as_formula(self):
        composition_conditions = self.dp.possible_assignments-1
        for state, next_step in reversed(self.state_to_next_step):
            composition_conditions = z3.If(self.dp.abstract_state_to_cond(state), next_step, composition_conditions,
                                           self.ctx)
        return composition_conditions

    def change_next_step(self, state, new_next=None):
        tuple = None
        for s, n in self.state_to_next_step:
            if s == state:
                tuple = (s, n)
        if tuple is not None:
            self.state_to_next_step.remove(tuple)
        if new_next is not None:
            self.state_to_next_step.append((state, new_next))

    def remove_stete(self, state):
        self.change_next_step(state)
