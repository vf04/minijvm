{
module JavaParser (parse) where
import AbsSyn
import JavaLexer
}

%name parse
%tokentype { Token }
%error { parseError }
  
%token 
       BOOLEAN { BOOLEAN }
       BREAK { BREAK }
       CASE { CASE }
       CHAR  { CHAR $$}
       CLASS { CLASS}
       IDENTIFIER { IDENTIFIER $$}
       INTLITERAL { INTLITERAL $$}
       CHARLITERAL { CHARLITERAL}
       INCREMENT { INCREMENT}
       CATCH { CATCH}
       CONTINUE { CONTINUE}
       DEFAULT { DEFAULT}
       DO { DO}
       ELSE { ELSE}
       IF { IF}
       For { FOR}
       

%%

compilationunit  : typedeclarations { $1 }

typedeclarations : typedeclaration { [$1] }
		 | typedeclarations typedeclaration { $1 ++ [$2] }

name             : qualifiedname { }
		 | simplename { }

typedeclaration  : classdeclaration { $1 }

qualifiedname    : name  DOT IDENTIFIER { }

simplename       : IDENTIFIER { $1 }

classdeclaration : CLASS IDENTIFIER classbody { Class(TC($2, []), [], []) }
                 | modifiers CLASS IDENTIFIER classbody {Class(TC($3, []), [], []) }

classbody        : LBRACKET RBRACKET  { ([], []) }
		 | LBRACKET classbodydeclarations  RBRACKET { $2 }

modifiers        : modifier { }
		 | modifiers modifier		 { }

classbodydeclarations :  classbodydeclaration { }
		 | classbodydeclarations classbodydeclaration{ }

modifier         : PUBLIC { }
		 | PROTECTED { }
                 | PRIVATE { }
                 | STATIC { }
                 | ABSTRACT { }

classtype        : classorinterfacetype{ }

classbodydeclaration : classmemberdeclaration { }
		 | constructordeclaration { }

classorinterfacetype : name{ }

classmemberdeclaration : fielddeclaration { }
		 | methoddeclaration { }

constructordeclaration : constructordeclarator constructorbody { }
		 |  modifiers constructordeclarator constructorbody { }

fielddeclaration : type variabledeclarators  SEMICOLON { }
 		 | modifiers type variabledeclarators  SEMICOLON { }

methoddeclaration : methodheader methodbody { }

block            : LBRACKET   RBRACKET { }
		 | LBRACKET  blockstatements  RBRACKET { }

constructordeclarator :  simplename LBRACE  RBRACE  { }
		 |  simplename LBRACE formalparameterlist RBRACE  { }

constructorbody	 : LBRACKET RBRACKET { }
		 | LBRACKET explicitconstructorinvocation  RBRACKET { }
		 | LBRACKET blockstatements  RBRACKET { }
		 | LBRACKET explicitconstructorinvocation blockstatements RBRACKET { }

methodheader	 : type methoddeclarator { }
		 | modifiers type methoddeclarator { }
		 | VOID methoddeclarator { }
		 | modifiers VOID methoddeclarator { }

type             : primitivetype { }
		 | referencetype { }

variabledeclarators : variabledeclarator { }
		 | variabledeclarators  COMMA  variabledeclarator { }

methodbody       : block { }
		 | SEMICOLON { }

blockstatements  : blockstatement { }
		 | blockstatements blockstatement { }

formalparameterlist : formalparameter { }
		 | formalparameterlist  COMMA  formalparameter{ }

explicitconstructorinvocation : THIS LBRACE  RBRACE   SEMICOLON  { }
		 | THIS LBRACE argumentlist  RBRACE   SEMICOLON  { }

classtypelist    : classtype { }
		 | classtypelist  COMMA  classtype { }

methoddeclarator : IDENTIFIER LBRACE  RBRACE  { }
		 | IDENTIFIER LBRACE formalparameterlist  RBRACE  { }

primitivetype    : BOOLEAN { }
		 | numerictype { }

referencetype    : classorinterfacetype { }


variabledeclarator : variabledeclaratorid { }
		 | variabledeclaratorid ASSIGN variableinitializer { }

blockstatement	 : localvariabledeclarationstatement { }
		 | statement  { }

formalparameter  : type variabledeclaratorid { }

argumentlist     : expression { }
		 | argumentlist  COMMA  expression { }

numerictype      : integraltype { }

variabledeclaratorid : IDENTIFIER { }

variableinitializer  : expression { }

localvariabledeclarationstatement : localvariabledeclaration  SEMICOLON  { }

statement        : statementwithouttrailingsubstatement{ }
		 | ifthenstatement { }
		 | ifthenelsestatement { }
		 | whilestatement { }
				     

expression       : assignmentexpression { }

integraltype     : INT  { }
                 | CHAR { }

localvariabledeclaration : type variabledeclarators { }

statementwithouttrailingsubstatement : block { }
		 | emptystatement { }
		 | expressionstatement { }
		 | returnstatement { }

ifthenstatement  : IF LBRACE expression  RBRACE  statement { }

ifthenelsestatement : IF LBRACE expression  RBRACE statementnoshortif ELSE statement  { }

whilestatement   : WHILE LBRACE expression  RBRACE  statement { }

assignmentexpression : conditionalexpression { }
		 |  assignment{ }

emptystatement	 :  SEMICOLON  { }

expressionstatement : statementexpression  SEMICOLON { }

returnstatement  : RETURN  SEMICOLON  { }
		 | RETURN expression  SEMICOLON { }

statementnoshortif : statementwithouttrailingsubstatement { }
		 | ifthenelsestatementnoshortif { }
		 | whilestatementnoshortif { }

conditionalexpression : conditionalorexpression { }
		 | conditionalorexpression QUESMARK expression  COLON  conditionalexpression { }

assignment       :lefthandside assignmentoperator assignmentexpression { }
	

statementexpression : assignment { }
		 | preincrementexpression { }
		 | predecrementexpression { }
		 | postincrementexpression { }
		 | postdecrementexpression { }
		 | methodinvocation { }
		 | classinstancecreationexpression { }

ifthenelsestatementnoshortif :IF LBRACE expression  RBRACE  statementnoshortif
			      ELSE statementnoshortif  { }

whilestatementnoshortif : WHILE LBRACE expression  RBRACE  statementnoshortif { }

conditionalorexpression : conditionalandexpression { }
		 | conditionalorexpression LOGICALOR conditionalandexpression{ }

lefthandside     : name { }

assignmentoperator : ASSIGN{ }
		 | TIMESEQUAL { }
		 | DIVIDEEQUAL { }
		 | MODULOEQUAL { }
		 | PLUSEQUAL { }
		 | MINUSEQUAL { }
		 | SHIFTLEFTEQUAL { }
		 | SIGNEDSHIFTRIGHTEQUAL { }
		 | UNSIGNEDSHIFTRIGHTEQUAL { }
		 | ANDEQUAL { }
		 | XOREQUAL { }
		 | OREQUAL{ }

preincrementexpression : INCREMENT unaryexpression { }

predecrementexpression : DECREMENT unaryexpression { }

postincrementexpression : postfixexpression INCREMENT { }

postdecrementexpression : postfixexpression DECREMENT { }

methodinvocation : name LBRACE   RBRACE  { }
		 | name LBRACE argumentlist RBRACE { }
		 | primary  DOT IDENTIFIER LBRACE RBRACE  { }
		 | primary  DOT IDENTIFIER LBRACE argumentlist  RBRACE  { }
     
classinstancecreationexpression : NEW classtype LBRACE   RBRACE  { }
                 | NEW classtype LBRACE  argumentlist  RBRACE  { }

conditionalandexpression : inclusiveorexpression { }

fieldaccess      : primary  DOT IDENTIFIER { }

unaryexpression	 : preincrementexpression { }
		 | predecrementexpression { }
		 | PLUS unaryexpression { }
		 | MINUS unaryexpression { }
		 | unaryexpressionnotplusminus { }

postfixexpression : primary { }
		 | name { }
		 | postincrementexpression { }
		 | postdecrementexpression{ }

primary		 : primarynonewarray { }

inclusiveorexpression : exclusiveorexpression { }
		 | inclusiveorexpression OR exclusiveorexpression { }

primarynonewarray : literal { }
		 | THIS { }
		 | LBRACE expression RBRACE  { }
                 | classinstancecreationexpression { }
		 | fieldaccess { }
		 | methodinvocation { }

unaryexpressionnotplusminus : postfixexpression { }
	         | TILDE unaryexpression { }
		 | EXCLMARK unaryexpression { }
		 | castexpression{ }

exclusiveorexpression : andexpression { }
		 | exclusiveorexpression XOR andexpression { }

literal		 : INTLITERAL { }
		 | BOOLLITERAL { }
		 | CHARLITERAL { }
		 | STRINGLITERAL { }
		 | JNULL { }

castexpression	 : LBRACE  primitivetype  RBRACE  unaryexpression { }
 		 | LBRACE  expression  RBRACE  unaryexpressionnotplusminus{ }

andexpression    : equalityexpression { }
		 | andexpression AND equalityexpression { }

equalityexpression : relationalexpression { }
		 | equalityexpression EQUAL relationalexpression { }
		 | equalityexpression NOTEQUAL relationalexpression { }

relationalexpression : shiftexpression { }
		 | relationalexpression LESS shiftexpression { }
		 | relationalexpression GREATER shiftexpression { }
		 | relationalexpression LESSEQUAL shiftexpression { }
		 | relationalexpression GREATEREQUAL shiftexpression { }
		 | relationalexpression INSTANCEOF referencetype { }

shiftexpression	 : additiveexpression { }

additiveexpression : multiplicativeexpression { }
		 | additiveexpression PLUS multiplicativeexpression { }
		 | additiveexpression MINUS multiplicativeexpression { }

multiplicativeexpression : unaryexpression { }
		 | multiplicativeexpression MUL unaryexpression { }
		 | multiplicativeexpression DIV unaryexpression { }
		 | multiplicativeexpression MOD unaryexpression { }


{

parseError :: [Token] -> a
parseError _ = error "Parse error"

}
