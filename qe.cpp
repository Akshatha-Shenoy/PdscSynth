#include <iostream>
#include <vector>
#include <set>
#include <cmath>
#include "z3++.h"
#include <algorithm>

using namespace z3;
using namespace std;

expr doQE(expr & input, context & c, bool simplify = false)
{
  goal g(c);
  g.add(input);
  tactic t =  tactic(c, "qe_rec");
  apply_result r = t(g);
  goal rg = r[0];
  expr re = rg.as_expr();

  if (simplify) {
    goal g2(c);
    g2.add(!re);
    tactic t2 =  tactic (c, "ctx-solver-simplify");
    // tactic t2 = tactic (c, "ctx-solver-simplify") & tactic(c, "propagate-ineqs") & tactic(c, "propagate-values") & tactic(c, "unit-subsume-simplify") & tactic(c, "simplify") & tactic(c, "normalize-bounds") & tactic(c, "solve-eqs");
    r = t2(g2);
    rg = r[0];
    re = rg.as_expr();
  }

  return re;
}

void uniqAdd(vector<expr> & vars, expr & var)
{
  for (auto v : vars)
    if (v.id() == var.id())
      return;

  vars.push_back(var);		
}

/* existentially quantified variables are of type is_var(),
  whereas other variables are app with 0 args */
void getFreeVars(expr in, vector<expr> & vars)
{
  if (in.is_app()) {
    if (in.is_const() && !in.is_true() && !in.is_false() && !in.is_numeral()) {
      uniqAdd(vars, in);
      return;
    }      
    for (int i = 0; i < in.num_args(); i++) {
      getFreeVars(in.arg(i), vars);
    }
  }
}

bool hasQuant(expr in)
{
  if (in.is_exists() || in.is_forall()) {
    return true;
  }
  else if (in.is_app()) {
    bool hasq = false;
    for (int i = 0; i < in.num_args(); i++) {
      hasq = hasq || hasQuant(in.arg(i));
    }
    return hasq;
  } else {
    return false;
  }
}


void reorderVars(vector<expr> & vars, const vector<string> & order)
{
  if (order.size() == 0) return;

  vector<expr> outputVars;

  for (int i = 0; i < order.size(); i++) {
    string curvar(order[i]);
    for (auto itr = vars.begin(); itr != vars.end(); itr++) {
      stringstream stream;
      stream << *itr;
      if (stream.str() == curvar) {
	outputVars.push_back(*itr);
	vars.erase(itr);
	break;
      }
    }
  }

  for (auto v : vars)
    outputVars.push_back(v);

  vars.clear();
  
  for (auto o : outputVars)
    vars.push_back(o);
  
}

bool isSat(expr  a, expr  b, context & c)
{
  solver s(c);
  s.reset();
  s.add(a);
  s.add(b);
  switch (s.check()) {
  case sat: return true;
  case unsat: return false;
  case unknown: return false;
  }
  return false;
}

int main(int argc, char** argv)
{
  if (argc < 2) {
    cout << "Usage: qe input_file.smt2 [vars]* \n";
    return 1;
  }

  const string inputFile (argv[1]);
  vector<string> varsOrder;
  for (int i = 2; i < argc; i++) {
    varsOrder.push_back(argv[i]);
  }
      
  context c;
  expr_vector asserts = c.parse_file(inputFile.c_str());
  assert(asserts.size() == 2);
  expr phi = asserts[0];
  expr src = asserts[1];
  vector<expr> evars;
  // vector<expr> allvars;
  
  cout << "Before: \n" << phi << endl;

  assert(phi.is_exists());
  
  // for (int i = 0; i < Z3_get_quantifier_num_bound(c, phi); i++) {
  //   symbol vname (c, Z3_get_quantifier_bound_name(c, phi, i));
  //   sort vsort (c, Z3_get_quantifier_bound_sort(c, phi, i)); 
  //   evars.push_back(c.constant(vname, vsort));
  // }

  expr phimat(c, Z3_get_quantifier_body(c, phi));
  
  vector<expr> freeVars;
  getFreeVars(phimat, freeVars);

  // cout << "After: \n" << doQE (phi, c) << endl;
  
  if (freeVars.size() > 100) {
    // cout << isSat(phi, phi, c) << endl;
    expr re = doQE(phi, c);
    cout << "After: \n" << re << endl;
    
  } else {

    reorderVars(freeVars, varsOrder);

    unsigned int varsSize = freeVars.size();
    vector<unsigned int> permuteSize;
    
    for (int i = varsSize-1; i > 0; i--) {
      permuteSize.push_back(i);
    }
    //give first preference to permutation size of 2 and 3, and least preference to 1
    std::rotate(permuteSize.begin(), permuteSize.begin()+1, permuteSize.end());
    
    for (auto i : permuteSize) {
      vector <bool> add(varsSize);
      fill(add.end()-i, add.end(), true);      
      do {
  	expr_vector newEVars(c);
  	for (int j = 0; j < varsSize; j++) {
  	  if (add[j])
  	    newEVars.push_back(freeVars[j]);
  	}
  	expr newphi = exists(newEVars, phi);
  	expr re = doQE(newphi, c, true);
	// while (hasQuant(re)) {
	//   re = doQE(re, c, true);
	// }
  	if (!re.is_false() && !re.is_true() && isSat(re, src, c)) {
  	  cout << "After: \n" << re << endl;
  	  return 0;
  	}
      } while (next_permutation(add.begin(), add.end()));
    }
  }	  
  
  return 0;

}


