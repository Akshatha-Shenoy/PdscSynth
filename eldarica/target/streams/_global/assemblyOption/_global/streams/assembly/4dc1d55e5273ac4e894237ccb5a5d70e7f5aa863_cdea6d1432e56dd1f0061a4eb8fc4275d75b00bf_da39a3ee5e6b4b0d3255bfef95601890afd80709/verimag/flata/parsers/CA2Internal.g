tree grammar CA2Internal;

options { 
  ASTLabelType = CommonTree;

  tokenVocab = CA;
}

// @SuppressWarnings({"unchecked", "unused"})
@header {
  package verimag.flata.parsers;
  
  import java.io.File;
  import org.antlr.runtime.BitSet;
  import java.util.*;

  
  import verimag.flata.automata.ca.*;
  import verimag.flata.automata.cg.*;
  import verimag.flata.automata.ba.*;
  import verimag.flata.presburger.*;
  import verimag.flata.MainTermination;

/*  
  import verimag.flata.sil.LoopCA;
  import verimag.flata.sil.LoopCA.ArraySymbolCounters;
  import verimag.flata.sil.LoopCA.ScalarSymbolCounters;
*/

}

@members {

  public static class ComposeInput {
    public Collection<Variable> vars = new LinkedList<Variable>();
    public LinearRel t1;
    public LinearRel t2;
  }

  public static final int eGuard = 0;
  public static final int eAction = 1;

  public File inputFilePath;      // name of file from which the parse tree has been created (without extension)
  public CG callgraph = new CG();

  // fields for Buchi automata 
  public Map<String, BA> infAutomata;
  public List<CompositeRel> inf_int2rel = new ArrayList<CompositeRel>();
  
  private void ensureInf(String id) {
    if (infAutomata == null)
      infAutomata = new HashMap<String, BA>();
  
    if (infAutomata.containsKey(id))
      return;
    
    if (!callgraph.isDefined(id))
      throw new RuntimeException("internal error: automaton not defined");
    CA ca = callgraph.caForCall(id);
    BA ia = MainTermination.createBA(ca, inf_int2rel);
    infAutomata.put(id, ia);
  }
  
  private String getTextFromNode(CommonTree aNode) {
    return aNode.getText();
  }
  
  private void checkLinTerm(LinearConstr res, LinearConstr arg1, LinearConstr arg2) {
    if (res == null) {
      System.out.println("transition label is not a linear constraint: multiplication ("+arg1+")*("+arg2+")");
    }
  }
  
  private List<CATransition> createTransitions(List<ModuloRel> aRels, CA a, CAState from, CAState to, String namePref) {
  	
  	List<CATransition> ret = new LinkedList<CATransition>();
  	
  	boolean more = aRels.size() > 0;
  	
  	for (ModuloRel r : aRels) {
  	
  	  String name;
      if (more) {
        name = a.giveNextTransitionLabelWithPrefix(namePref);
      } else {
        name = namePref;
  	  }
  	  
  	  CompositeRel rComp = new CompositeRel(Relation.toMinType(r));
  	  CATransition t = new CATransition(from, to, rComp, name, a);
      ret.add(t);
  	}
  	
  	return ret;
  }
  
  private BENode.ASTConstrType parsertype2asttype(int i) {
    switch (i) {
    case EQ:
      return BENode.ASTConstrType.EQ;
    case NEQ:
      return BENode.ASTConstrType.NEQ;
    case LEQ:
      return BENode.ASTConstrType.LEQ;
    case LESS:
      return BENode.ASTConstrType.LESS;
    case GEQ:
      return BENode.ASTConstrType.GEQ;
    case GREATER:
      return BENode.ASTConstrType.GREATER;
    case DIVIDES:
      return BENode.ASTConstrType.DIVIDES;
    default:
      throw new RuntimeException("internal error: unexpected type \""+i+"\"");
    }
  }

}

/*
automatonWithSymbols returns [LoopCA retCA]
	:   
	  ^(AUTOMATON_WITH_SYMBOLS automaton
		{
    		CA ca = $automaton.rCA;
    		retCA = new LoopCA();
    		retCA.ca(ca);
		}
	  sym_wn[retCA] sym_arrays[retCA] sym_scalars[retCA]
	  )
	
	;
sym_wn[LoopCA aLoopCA]
	: ^(WN ID { aLoopCA.wnCounter($ID.getText()); })
	;
sym_arrays[LoopCA aLoopCA]
	: ^(ARRAYS 
	  (
		{ ArraySymbolCounters asc = new ArraySymbolCounters(); } 
	  ^(name=ID inx=ID in=ID out=ID 
	 	{
	    asc.symbol($name.getText());
	    asc.inxCounter($inx.getText());
	    asc.inCounter($in.getText());
	    asc.outCounter($out.getText());
	 	} 
	  (wc=ID  {asc.addWorkingCounter($wc.getText());} )* 
	 	{ aLoopCA.addArraySymbolCounters(asc); }
	  ))*)  // at least index,input,output
	;
sym_scalars[LoopCA aLoopCA]
	: ^(SCALARS (
	    { ScalarSymbolCounters ssc = new ScalarSymbolCounters(); }
	    ^(name=ID in=ID out=ID )
	    {
	      ssc.symbol($name.getText());
	      ssc.inCounter($in.getText());
	      ssc.outCounter($out.getText());
	      aLoopCA.addScalarSymbolCounters(ssc);
	    }
	    )*)  // input,output
	;
*/

procedures
  : 
    { List<String> globals = new LinkedList<String>(); } 
    globals[globals]? 
    { VariablePool globalPool = VariablePool.createGPool(globals); } 
    ( automaton[globalPool] )+
  {
    // check definitions of procedures
    callgraph.checkProcedureDefinitions();
    
    // check parameters of calls
    callgraph.checkCallParameters();
    
    // check main procedure
    callgraph.checkMain();
    
  }
  ;

automaton [VariablePool globalPool] returns [CA rCA]
  : ^(AUTOMATON id=ID 
      { 
        String s = $id.getText();
      }
      automaton2 [globalPool, s]
      {
        $rCA = $automaton2.rCA;
      }
      )
  | ^(PRINT id=ID)
      {
        String s = $id.getText();
        BA ia = infAutomata.get(s);
        if (ia == null) {
          System.err.println("Automaton id \""+s+"\" is not defined");
          System.exit(1);
        }
        System.out.println(ia.toString());
      }
  ;

automaton2 [VariablePool globalPool, String aCaName] returns [CA rCA]
  :   
  		{ List<String> locals = new LinkedList<String>(); }
  		locals[locals]?
        { 
          VariablePool pool = VariablePool.createGLPool(globalPool, locals, aCaName);
          rCA = callgraph.caForDefinition(aCaName, pool);
        }
  		port_in[pool]? port_out[pool]? initial_states[rCA] final_states[rCA]? error_states[rCA]? transitions[pool,rCA]
  		{
  		  rCA.postParsing($transitions.rT);
  		}
  | ^(NOT ID) 
      {
        String name = $ID.getText();
        ensureInf(name);
        BA ia = infAutomata.get(name);
        BA ia_neg = ia.complement(inf_int2rel.size());
        infAutomata.put(aCaName, ia_neg);
      }
  | ^( ( op=OR|op=AND ) id1=ID id2=ID)
      {
        String name1 = $id1.getText();
        String name2 = $id2.getText();
        ensureInf(name1);
        ensureInf(name2);
        BA ia1 = infAutomata.get(name1);
        BA ia2 = infAutomata.get(name2);
        BA ia_op;
        int operator = $op.getToken().getType();
        if (operator == AND) {
          ia_op = ia1.intersect(ia2);
        } else {
          ia_op = ia1.union(ia2,inf_int2rel.size());
        }
        infAutomata.put(aCaName, ia_op);
      } 
  ;

globals [List<String> globals]
  : ^(GLOBALS ( id=ID {
      globals.add(id.getText());
      } 
    )+)
  ;
locals [List<String> locals]
  : ^(LOCALS 
        ( id=ID 
        { locals.add(id.getText()); }
        )+
      )
  ;
port_in [VariablePool pool]
  : ^(PORT_IN {List<String> aux = new LinkedList<String>();} 
       ( id=ID {aux.add(id.getText());} )* {pool.declarePortIn(aux);} )
  ;
port_out [VariablePool pool]
  : ^(PORT_OUT {List<String> aux = new LinkedList<String>();} 
       ( id=PRIMED_ID {aux.add(id.getText());} )* {pool.declarePortOut(aux);} )
  ;

initial_states [CA ca]
  : ^(INITIAL ( id=ID {
      ca.getStateWithName(id.getText(), CA.fINIT);
      } 
    )+)
  ;
final_states [CA ca]
  : ^(FINAL ( id=ID {
      ca.getStateWithName(id.getText(), CA.fFINAL);
      } 
    )+)
  ;
error_states [CA ca]
  : ^(ERROR ( id=ID {
      ca.getStateWithName(id.getText(), CA.fERROR);
      }
    )+)
  ;


transitions [VariablePool pool, CA ca] returns [List<CATransition> rT]
  @init{
    rT = new LinkedList<CATransition>(); 
  }
  : 
  | ^( TRANSITIONS (transition[pool,ca] {rT.addAll($transition.rT);} )* )
  ;

compose_input [VariablePool pool] returns[ComposeInput rCompose]
	: 
	{ 
	  rCompose = new ComposeInput();
	}
	( id=ID 
	  { rCompose.vars.add(pool.giveVariable(id.getText())); } 
    )+
    t1=constrInput [pool]
    t2=constrInput [pool]
    
    {
      if ($t1.ret.size() != 0 || $t2.ret.size() != 0) {
        System.err.println("incorrect input");
        System.exit(-1);
      }
      ModuloRel r1 = $t1.ret.get(0);
      ModuloRel r2 = $t2.ret.get(0);
      
      rCompose.t1 = r1.toLinearRel();
      rCompose.t2 = r2.toLinearRel(); 
    }
    ;

constrsInput [VariablePool pool] returns [ List<ModuloRel> ret ]
	:
	{ ret = new LinkedList<ModuloRel>(); }
	( constrInput [pool] 
	  { ret.addAll($constrInput.ret); } 
	)*
	;

constrInput [VariablePool pool] returns [ List<ModuloRel> ret ]
  : ^( CONSTR_INPUT 
      (c=constraints[null,pool])?)
      { 
        BENode root = $c.aRet;
        BENode dnfRoot = BENode.normalize(root);
        ret = dnfRoot.dnf2Rels();
      }
  ;

calc [VariablePool pool]
  @init{
  	Map<String,DisjRel> stored = new HashMap<String,DisjRel>();
  	Map<String,Set<Variable>> params = new HashMap<String,Set<Variable>>();
  }
  : (calc_print[pool, stored, params] | calc_store[pool, stored, params])*
  ;
calc_print [VariablePool pool, Map<String,DisjRel> stored, Map<String,Set<Variable>> params]
  : ^(PRINT 
       (constraints[null, pool] 
       {
         BENode expr = $constraints.aRet;
         expr = expr.processAtoms();
         expr.eval(pool, null, stored, null, params);
         System.out.println(expr.calc_rel());
       }
       )+
     )
  ;
calc_store [VariablePool pool, Map<String,DisjRel> stored, Map<String,Set<Variable>> params]
  : ^(ID constraints[null, pool]) 
    {
      BENode expr = $constraints.aRet;
      expr = expr.processAtoms();
      Set<Variable> pp = expr.eval(pool, null, stored, null, params);
      stored.put($ID.getToken().getText(), expr.calc_rel());
      params.put($ID.getToken().getText(), pp);
    }
  ;

transition [VariablePool pool, CA ca] returns [List<CATransition> rT]
  : ^( TRANSITION id1=ID id2=ID 
       {
         CAState from = ca.getStateWithName(id1.getToken().getText());
         CAState to   = ca.getStateWithName(id2.getToken().getText());
        
         String name = null; // TODO
       }
       
       transition2[pool,ca,from,to,name]
       {
         $rT = $transition2.rT;
       }
     )
  | ^( TRANSITION id0=ID id1=ID id2=ID
       {
         CAState from = ca.getStateWithName(id1.getToken().getText());
         CAState to   = ca.getStateWithName(id2.getToken().getText());
        
         String name = new String(id0.getToken().getText());
        
         // TODO
         if (ca.isUsedTransName(name)) {
           String msg = "Redefinition of transition '"+name+"' [r: "+id0.getLine()+",c: "+id0.getCharPositionInLine()+"].";
           System.err.println(msg);
           System.exit(-1);
         }
       }
      
       transition2[pool,ca,from,to,name]
       {
         $rT = $transition2.rT;
       }
     )
  ;

transition2 [VariablePool pool, CA ca, CAState from, CAState to, String name] returns [List<CATransition> rT]
  @init{
    rT = new LinkedList<CATransition>(); 
  }
  : call [pool]
    {
      Call c = callgraph.addCall(ca.name(), $call.rCallName, $call.rArgs);
      CATransition tt = new CATransition(from, to, c, name, ca);
      c.setCallingPoint(tt);
      rT.add(tt);
    }
  | constraints [null,pool]
     { 
      BENode root = $constraints.aRet;
      BENode.checkOperators(root);
      BENode dnfRoot = BENode.normalize(root); // dnf
      List<ModuloRel> rels = dnfRoot.dnf2Rels();
      rT.addAll(createTransitions(rels, ca, from, to, name)); // add transitions
     }
  ;

call [VariablePool pool] returns [List<LinearConstr> rArgs, String rCallName ]
  : ^(CALL 
        called=ID
        {
          $rCallName = $called.getText();
          $rArgs = new LinkedList<LinearConstr>();
        }
        ( terms[pool]
          { $rArgs.add($terms.rConstr); }
        )*
     )
  ;

/* closure nodes in ASTs are always children of AND */
constraints [ BENode aPred, VariablePool pool ] returns [ BENode aRet ]
  :  ^(AND { $aRet = new BENode(aPred, BENode.BENodeType.AND); BENode prev1 = null, prev2 = null; } 
         (  c=constraints[$aRet,pool] 
         { $aRet.addSucc($c.aRet); 
           prev2 = prev1; prev1 = $c.aRet;
           if (prev1.type().isClosure()) { // change the AST structure to have closures as parents of accelerated relations
             $aRet.removeSucc(prev2);
             prev1.addSucc(prev2);
             prev2.pred(prev1);
           } 
         } 
         )+ 
      )
  |  CL_STAR { $aRet = BENode.calc_closure_star(aPred); }
  |  CL_PLUS { $aRet = BENode.calc_closure_plus(aPred); }
  |  ^(CL_STAR ID) { $aRet = BENode.calc_closure_star_n(aPred, pool.giveVariable($ID.getToken().getText())); }
  |  ^(CL_PLUS ID) { $aRet = BENode.calc_closure_plus_n(aPred, pool.giveVariable($ID.getToken().getText())); }
  |  ^(COMPOSE { $aRet = new BENode(aPred, BENode.BENodeType.COMPOSE); } (c=constraints[$aRet,pool] { $aRet.addSucc($c.aRet); } )+ )
  |  ID { $aRet = BENode.calc_id(aPred, $ID.getToken().getText()); }
  |  ^(EXISTS 
      {List<Variable> vars = new LinkedList<Variable>();} 
      (id=ID | id=PRIMED_ID {vars.add(pool.giveVariable($ID.getToken().getText()));} )+ 
      { $aRet = BENode.calc_exists(aPred, vars); } 
      (c=constraints[$aRet,pool] { $aRet.addSucc($c.aRet); } ) )
    
  |  ^(OR { $aRet = new BENode(aPred, BENode.BENodeType.OR); } (c=constraints[$aRet,pool] { $aRet.addSucc($c.aRet); } )+ )
  |  ^(NOT { $aRet = new BENode(aPred, BENode.BENodeType.NOT); } (c=constraints[$aRet,pool] { $aRet.addSucc($c.aRet); } ) )
  |  ^(TRUE { $aRet = new BENode(aPred, BENode.BENodeType.TRUE); } )
  |  ^(FALSE { $aRet = new BENode(aPred, BENode.BENodeType.FALSE); } )
  |  c=constraint[aPred,pool] { $aRet = $c.aRet; }
  ;

constraint [BENode aPred, VariablePool pool] returns [BENode aRet]
  @init{
    LinearConstr lhs = new LinearConstr();
    LinearConstr rhs = new LinearConstr();
    int operator;
  }
  @after {
    BENode.ASTConstrType auxT = parsertype2asttype(operator);
    BENode.ASTConstr aux = new BENode.ASTConstr(lhs,rhs,auxT);
    $aRet = new BENode(aPred,aux);
  }
  : ^(CONSTRAINT
      tlhs=terms [pool]
      ( op=EQ|op=NEQ|op=LEQ|op=LESS|op=GEQ|op=GREATER|op=DIVIDES )
      {
        operator = $op.getToken().getType();
        if (operator == DIVIDES) {
          LinearTerm con = $tlhs.rConstr.get(null);
          if (con == null || $tlhs.rConstr.size() != 1) {
            System.err.println("Divisor must be a number, not ("+$tlhs.rConstr+")");
            System.exit(-1);
          }
        }
      }
      trhs=terms [pool]
      {
        lhs = $tlhs.rConstr;
        rhs = $trhs.rConstr;
      }
     )
  ;

terms [VariablePool pool] returns [LinearConstr rConstr]
  @init{
    $rConstr = new LinearConstr();
  } 
  : ^(PLUS {boolean m=false;} (PLUS | (MINUS {m=true;}))? t1=terms [pool]
       {
         $rConstr = $t1.rConstr;
         if (m) {
           $rConstr = $rConstr.times(-1);
         }
       } 
       ( 
         (PLUS {m=false;} | (MINUS {m=true;}) ) t2=terms [pool] 
           {
             LinearConstr aux =  $t2.rConstr;
             if (m) {
               aux = aux.times(-1);
             }
             $rConstr.addLinTerms(aux);
           }
       )*
     )
  | ^(MULT t1=terms [pool]
       { $rConstr = $t1.rConstr; }
       ( 
         t2=terms [pool]
         {
           LinearConstr old = $rConstr;
           $rConstr = old.times($t2.rConstr);
           checkLinTerm($rConstr, old, $t2.rConstr);
         } 
       )*
     )
  | (f=ID | f=PRIMED_ID) 
    {
      Variable var = pool.giveVariable(getTextFromNode(f));
      rConstr.addLinTerm(new LinearTerm(var,1));
    }
  | CONST 
    {
      int coef = java.lang.Integer.parseInt($CONST.getToken().getText());
      rConstr.addLinTerm(new LinearTerm(null,coef));
    }
  ;
