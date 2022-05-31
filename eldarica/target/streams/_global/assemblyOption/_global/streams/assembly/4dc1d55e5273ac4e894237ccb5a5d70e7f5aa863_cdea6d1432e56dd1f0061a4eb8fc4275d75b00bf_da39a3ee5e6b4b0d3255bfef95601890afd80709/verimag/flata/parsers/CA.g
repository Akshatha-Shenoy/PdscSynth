grammar CA;

options {
	k=1; // lookahead
	output=AST;
	ASTLabelType=CommonTree; // type of $stat.tree ref etc...
} 



tokens {

//	NEQ = '!=';

	PLUS = '+' ;
	MINUS = '-' ;
	MULT = '*' ;

//	NOT = '!' ;
	AND = '&&' ;
//	OR = '||' ; // handled together with DIVIDES

	EQ = '=' ;
//	DIVIDES = '|' ; // handled together with OR

	// calculator
	PRINT = 'print';
	EXISTS = 'exists';	
	COMPOSE = '@' ;
	
	COMMA = ',' ;
	WN = 'wN' ;
	ARRAYS = 'arrays' ;
	SCALARS = 'scalars' ;
	
	TRUE = 'true' ;
	FALSE = 'false' ;
	LPAR_C = '{' ;
	RPAR_C = '}' ;
	LPAR = '(' ;
	RPAR = ')' ;
	
    LOCALS = 'locals';
    GLOBALS = 'globals';
    PORT_IN = 'in';
    PORT_OUT = 'out';

	// imaginary AST tokens
	AUTOMATA ;
	AUTOMATON ;
	AUTOMATON_WITH_SYMBOLS ;
	INITIAL = 'initial';
	FINAL = 'final';
	ERROR = 'error';
	TRANSITIONS ;
	TRANSITION ;
	TERMS ;
	GUARDS ;
	GUARD ;
	ACTIONS ;
	ACTION ;
	CONSTRAINTS ;
	CONSTRAINT ;
	CALL ;
	
	CONSTR_INPUT ;

	ASSIGN = ':=';
}

@header {
	package verimag.flata.parsers;

	import verimag.flata.parsers.CALexer;
}
@lexer::header {
	package verimag.flata.parsers;
}


@lexer::members {
	public Token nextToken() {
		while (true) {
			this.state.token = null;
			this.state.channel = Token.DEFAULT_CHANNEL;
			this.state.tokenStartCharIndex = input.index();
			this.state.tokenStartCharPositionInLine = input.getCharPositionInLine();
			this.state.tokenStartLine = input.getLine();
			this.state.text = null;
			if ( input.LA(1)==CharStream.EOF ) {
				return Token.EOF_TOKEN;
			}
			try {
				mTokens();
				if ( this.state.token==null ) {
					emit();
				}
				else if ( this.state.token==Token.SKIP_TOKEN ) {
					continue;
				}
				return this.state.token;
			}
			catch (RecognitionException re) {
				reportError(re);
				throw new RuntimeException("Parsing ended."); // or throw Error
			}
		}
	}
}

// Optional step: Disable automatic error recovery
@members {
	//protected void mismatch(IntStream input, int ttype, BitSet follow)
	//	throws RecognitionException
	//	{
	//		throw new MismatchedTokenException(ttype, input);
	//	}
	//public Object recoverFromMismatchedSet(IntStream input,
	//	RecognitionException e,
	//	BitSet follow)
	//	throws RecognitionException
	//	{
	//		throw e;
	//	}
    public void reportError(RecognitionException e) {
    	super.reportError(e);
    	System.exit(-1);
    }
}
// Alter code generation so catch-clauses get replace with
// this action.
@rulecatch {
	//catch (RecognitionException e) {
	//	throw e;
	//}
}
@lexer::rulecatch {
	catch (RecognitionException e) {
		//throw e;
		System.exit(-1);
	}
}

/*------------------------------------------------------------------
 * PARSER RULES
 *------------------------------------------------------------------*/

procedures
	: globals? ( automaton )+ EOF!
	;

automata 
	: ( automaton )+ EOF!
	;

automatonWithSymbols
	: 'automaton' ID LPAR_C symbols initial_states final_states transitions RPAR_C
	  -> ^(AUTOMATON_WITH_SYMBOLS ^(AUTOMATON ID initial_states final_states transitions) symbols)
	;
symbols
	: 'symbols'! LPAR_C! sym_wn sym_arrays sym_scalars RPAR_C!
	;
sym_wn
	: WN^ EQ! '['! ID ']'!
	;
sym_arrays
	: ARRAYS^ LPAR_C! 
	    sym_arrays2*
	  RPAR_C!
	;
sym_arrays2
	: ID^ EQ! '['! ID COMMA! ID COMMA! ID (COMMA! ID)* ']'!   // at least index,input,output
	;
sym_scalars
	: SCALARS^ LPAR_C! 
	    sym_scalars2*
	  RPAR_C!
	;
sym_scalars2
	: ID^ EQ! '['! ID COMMA! ID']'!   // input,output
	;

automaton_top
	: automaton EOF!
	;

// fast model
f_automaton
	: 'model' ID LPAR_C
			initial_states final_states
			f_var
			f_states
			f_transitions 
		RPAR_C 
		//(ALPHANUM | LPAR_C | RPAR_C | ':' | EQ | ';' | '*' | WHITESPACE)*
		//('strategy' ID LPAR_C .* )?
		.*
		//EOF
	 -> ^(AUTOMATON ID initial_states final_states f_transitions)
	;
f_var
	: 'var' ID (COMMA ID)* ';'
	;
f_states
	: 'states' ID (COMMA ID)* ';'
	;
f_transitions
	: ( f_transition )+
	  -> ^( TRANSITIONS ( f_transition )+ )
	;
f_transition
	: 'transition' idt=ID ASSIGN LPAR_C
			f_transition2  
	   RPAR_C ';'
	 -> ^( TRANSITION $idt f_transition2) 
	;
f_transition2
	:	  'from' ASSIGN idfrom=ID ';' 
	      'to' ASSIGN idto=ID ';'
	      f_guardaction
	 -> ^(TRANSITION $idfrom $idto f_guardaction) 
	;
f_guardaction
	:     'guard' ASSIGN f_guard ';'
	      'action' ASSIGN f_action ';'
	 -> ^(CONSTRAINTS f_guard f_action)
	;
f_guard
	: f_constraint ('&&'! f_constraint)*
	;
f_action
	: f_constraint (COMMA! f_constraint)*
	;
f_constraint
	: constraint
	 -> ^(CONSTRAINT constraint)
	;

automaton
	: 'automaton' ID automaton2
	  -> ^(AUTOMATON ID automaton2)
	| PRINT ID
	  -> ^(PRINT ID)
	;

automaton2
	: LPAR_C! locals? port_in? port_out? initial_states final_states? error_states? transitions RPAR_C!
	| EQ! automaton3
	;
automaton3
	: id1=ID ( op=OR|op=AND ) id2=ID
	  -> ^($op $id1 $id2)
	| NOT ID 
	  -> ^(NOT ID)
	;

globals
	: GLOBALS LPAR_C (ID)(COMMA ID)* RPAR_C
	  -> ^(GLOBALS ID (ID)*)
	;

locals
	: LOCALS LPAR_C (ID)(COMMA ID)* RPAR_C
	  -> ^(LOCALS ID (ID)*)
	;
port_in
	: PORT_IN LPAR ((ID)(COMMA ID)*)? RPAR
	  -> ^(PORT_IN (ID (ID)*)?)
	;
port_out
	: PORT_OUT LPAR ((PRIMED_ID)(COMMA PRIMED_ID)*)? RPAR
	  -> ^(PORT_OUT (PRIMED_ID (PRIMED_ID)*)?)
	;
	
initial_states
	: INITIAL LPAR_C (ID)(COMMA ID)* RPAR_C
	  -> ^(INITIAL ID (ID)*)
	;
final_states
	: FINAL LPAR_C (ID)(COMMA ID)* RPAR_C 
	  -> ^(FINAL ID (ID)*)
	;
error_states
	: ERROR LPAR_C (ID)(COMMA ID)* RPAR_C 
	  -> ^(ERROR ID (ID)*)
	;

transitions
	:
	| ( transition )+
	  -> ^( TRANSITIONS ( transition )+ )
	;
	
compose_input
	: LPAR_C! (ID)(COMMA! ID)* RPAR_C! constr_input constr_input
	;

rel_list
	: ( constr_input )* EOF!
	;

constrs_input
	: ( constr_input )*
	;
constr_input
	: LPAR_C constraints RPAR_C
	  -> ^( CONSTR_INPUT constraints)
	;
	

calc
	: (calc_statement)*
	;
calc_statement
	: calc_print
	| calc_store
	;
calc_store
	: ID^ ':'! be_e0 ';'!
	;
calc_print
	: PRINT^ be_e0 (','! be_e0)* ';'!
	;

transition
	: id1=ID transition2
	  -> ^( TRANSITION $id1 transition2)
	;
transition2
	: ':'! ID '->'! ID LPAR_C! label RPAR_C!
	| '->'! ID LPAR_C! label RPAR_C!
	;


label
	: (call) => 
	  call
	| constraints
	;


call
	: ID LPAR args? RPAR
	  -> ^(CALL ID args? )
	;
args
	: terms (COMMA! terms)*
	;

// constraints: any boolean combination of atomic constraints (linear and modulo)


constraints
	: ( ) =>
	  
	  -> ^(TRUE)
	| 
	  be_e0
	;


/** note: parsing doesn't work for the following:
 *  be_dd 	// disjunction
	  : be_cc be_ddd
        -> ^(OR be_cc be_ddd)
	  ;
    be_ddd 
      : // epsilon
      | OR! be_cc be_ddd
      ;
 * use the following instead
 *  be_dd 	// disjunction
	  : be_cc be_ddd?
        -> ^(OR be_cc be_ddd?)
	  ;
    be_ddd 
      : OR! be_cc be_ddd?
      ;
 */
/* ------------------ boolean expressions ---------------------- */
be_e0	// existentials allowed in calculator
	: EXISTS^ (ID | PRIMED_ID)+ '.'! be_e1
	| be_e1
	;

be_e1 	// disjunction
	: be_e2 be_ee1?
	  -> ^(OR be_e2 be_ee1?)
	;
be_ee1 
	: OR! be_e2 be_ee1?
	;
be_e2 	// composition
	: be_e3 be_ee2?
	  -> ^(COMPOSE be_e3 be_ee2?)
	;
be_ee2 
	: COMPOSE! be_e3 be_ee2?
	;
be_e3	// conjunction
	: be_nn be_ee3?
	  -> ^(AND be_nn be_ee3?)
	;
be_ee3
	: AND! be_nn be_ee3?
	;
be_nn	// negation
	: NOT^ be_ff
	| be_ff
	;
be_ff
	: (constraint (closure)?) => 
	  constraint (closure)?
	| LPAR! be_e0 RPAR! (closure)?
	;
	
closure
	: CL_PLUS^ ID?
	| CL_STAR^ ID?
	;

// priority of closure operators is higher than of any boolean operator
// priority of composition operator is higher than of disjunction an lower than of conjunction
// closure nodes in ASTs are always children of AND 

constraint
	: (terms cop terms) =>
	  terms cop terms
	  -> ^(CONSTRAINT terms cop terms)
	| (ID) => ID // used by calculator to store relations
	| TRUE
	  -> ^(TRUE)
	| FALSE
	  -> ^(FALSE)
	;
cop
	: EQ|NEQ|LEQ|LESS|GEQ|GREATER|DIVIDES
	;


terms
	: ae_aa
	;

/* ------------------ arithmetic expressions ---------------------- */
ae_aa 	// addition
	: pm? ae_mm ae_aaa?
	 -> ^(PLUS pm? ae_mm ae_aaa?)
	;
ae_aaa 
	: pm ae_mm ae_aaa?
	;
ae_mm	// multiplication
	: ae_ff ae_mmm?
	  -> ^(MULT ae_ff ae_mmm?)
	;
ae_mmm
	: MULT! ae_ff ae_mmm?
	;
ae_ff
	: LPAR! ae_aa RPAR!
	| PRIMED_ID
	| ID 
	| CONST
	;
pm
	: PLUS
	| MINUS
	;


/*------------------------------------------------------------------
 * LEXER RULES
 *------------------------------------------------------------------*/


CONST 
	:	  (NUM)+ 
	;

ID 
	:	  ALPHA (ALPHANUM)* ( '\'' {$type=PRIMED_ID; } )?
	;
LESS
	:	'<' (EQ {$type=LEQ;} )?
	;
GREATER
	:	'>' (EQ {$type=GEQ;} )?	
	;
DIVIDES
	:	'|' ('|' {$type=OR;} )?	
	;
NOT
	:	'!' ('=' {$type=NEQ;} )?	
	;
CL
	:	'^' (   '+' {$type=CL_PLUS;}
	          | '*' {$type=CL_STAR;}
	        )
	;


WHITESPACE 
	:	(	' ' 
			| '\t' 
			| '\f' 
			| '\r' 
			| '\n' 
		)+ 	
	{ $channel = HIDDEN; } 
	;

SINGLE_COMMENT: '//' (~('\r' | '\n'))* { skip(); };
MULTI_COMMENT options { greedy = false; }
  : '/*' .* '*/' { skip(); }
//  | 'strategy' (ALPHANUM)* LPAR_C .* RPAR_C { skip(); }
  ;

fragment NUM
	:	  '0'..'9'
	;
fragment ALPHA 
	:	  'a'..'z' 
		| 'A'..'Z'
		| '_'
	;
fragment ALPHANUM
	:	  NUM 
		| ALPHA
		| '#'
	;
