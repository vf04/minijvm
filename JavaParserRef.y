{
module JavaParser (parse) where
import AbsSyn
import JavaLexer
}

%name compilationunit
%name typedeclarations
%name name
%name typedeclaration
%name qualifiedname
%name simplename
%name classdeclaration
%name classbody
%name modifiers
%name modifier
%name classbodydeclarations
%name classtype
%name classbodydeclaration
%name classorinterfacetype
%name classmemberdeclaration
%name constructordeclaration
%name fielddeclaration
%name methoddeclaration
%name block
%name constructordeclarator
%name constructorbody
%name methodheader
%name variabledeclarators
%name methodbody
%name blockstatements
%name formalparameterlist
%name explicitconstructorinvocation
%name classtypelist
%name methoddeclarator
%name primitivetype
%name referencetype
%name variabledeclarator
%name blockstatement
%name formalparameter
%name argumentlist
%name numerictype
%name variabledeclaratorid
%name variableinitializer
%name localvariabledeclarationstatement
%name statement
%name expression
%name integraltype
%name localvariabledeclaration
%name statementwithouttrailingsubstatement
%name ifthenstatement
%name ifthenelsestatement
%name whilestatement
%name assignmentexpression
%name emptystatement
%name expressionstatement
%name returnstatement
%name statementnoshortif
%name conditionalexpression
%name assignment
%name statementexpression
%name ifthenelsestatementnoshortif
%name whilestatementnoshortif
%name conditionalorexpression
%name lefthandside
%name assignmentoperator
%name preincrementexpression
%name predecrementexpression
%name postincrementexpression
%name postdecrementexpression
%name methodinvocation
%name classinstancecreationexpression
%name conditionalandexpression
%name fieldaccess
%name unaryexpression
%name postfixexpression
%name primary
%name inclusiveorexpression
%name primarynonewarray
%name unaryexpressionnotplusminus
%name exclusiveorexpression
%name literal
%name castexpression
%name andexpression
%name equalityexpression
%name relationalexpression
%name shiftexpression
%name additiveexpression
%name multiplicativeexpression
%tokentype { Token }
%error { parseError }
  
%token 
    ABSTRACT { ABSTRACT}
    BOOLEAN { BOOLEAN}
    BREAK { BREAK}
    CASE { CASE}
     CATCH { CATCH}
     CHAR  { CHAR}
     CLASS { CLASS}
     CONTINUE { CONTINUE}
     DEFAULT { DEFAULT}
     DO { DO}
     ELSE { ELSE}
     EXTENDS { EXTENDS}
     FINALLY { FINALLY}
     FOR { FOR}
     IF { IF}
     INSTANCEOF { INSTANCEOF}
     INT { INT}
     NEW { NEW}
     PRIVATE { PRIVATE}
     PROTECTED { PROTECTED}
     PUBLIC { PUBLIC}
     RETURN { RETURN}
     STATIC { STATIC}
     SUPER { SUPER}
     SWITCH { SWITCH}
     THIS { THIS}
     THROW { THROW}
     THROWS { THROWS}
     TRY { TRY}
     VOID { VOID}
     WHILE { WHILE}
     INTLITERAL { INTLITERAL $$}
     BOOLLITERAL { BOOLLITERAL $$}
     JNULL { JNULL}
     CHARLITERAL { CHARLITERAL $$}
     STRINGLITERAL { STRINGLITERAL $$}
     IDENTIFIER { IDENTIFIER $$}
     EQUAL { EQUAL}
     LESSEQUAL { LESSEQUAL}
     GREATEREQUAL { GREATEREQUAL}
     NOTEQUAL { NOTEQUAL }
     LOGICALOR { LOGICALOR}
     LOGICALAND { LOGICALAND}
     INCREMENT { INCREMENT}
     DECREMENT { DECREMENT}
     SHIFTLEFT { SHIFTLEFT}
     SHIFTRIGHT { SHIFTRIGHT}
     UNSIGNEDSHIFTRIGHT { UNSIGNEDSHIFTRIGHT}
     SIGNEDSHIFTRIGHT { SIGNEDSHIFTRIGHT}
     PLUSEQUAL { PLUSEQUAL}
     MINUSEQUAL { MINUSEQUAL}
     TIMESEQUAL { TIMESEQUAL}
     DIVIDEEQUAL { DIVIDEEQUAL}
     ANDEQUAL { ANDEQUAL}
     OREQUAL { OREQUAL}
     XOREQUAL { XOREQUAL}
     MODULOEQUAL { MODULOEQUAL}
     SHIFTLEFTEQUAL { SHIFTLEFTEQUAL}
     SIGNEDSHIFTRIGHTEQUAL { SIGNEDSHIFTRIGHTEQUAL}
     UNSIGNEDSHIFTRIGHTEQUAL { UNSIGNEDSHIFTRIGHTEQUAL}
     LBRACE { LBRACE}
     RBRACE { RBRACE}
     LBRACKET { LBRACKET}
     RBRACKET { RBRACKET}
     LSQBRACKET { LSQBRACKET}
     RSQBRACKET { RSQBRACKET}
     SEMICOLON { SEMICOLON}
     DOT { DOT}
     ASSIGN { ASSIGN}
     LESS { LESS}
     GREATER { GREATER}
     EXCLMARK { EXCLMARK}
     TILDE { TILDE}
     QUESMARK { QUESMARK}
     COLON { COLON}
     PLUS { PLUS}
     MINUS { MINUS}
     MUL { MUL}
     DIV { DIV}
     MOD { MOD}
     AND { AND}
     OR { OR}
     XOR { XOR}
     SHARP { SHARP}
     ARROW { ARROW}
     COMMA { COMMA}

%%
compilationunit  : typedeclarations { $1 }

typedeclarations : typedeclaration { [$1] }
   | typedeclarations typedeclaration { $1 ++ [$2] }

name             : qualifiedname { [$1] }
   | simplename { $1 }

typedeclaration  : classdeclaration { $1 }

qualifiedname    : name  DOT IDENTIFIER { $1 ++ [$3]}

simplename       : IDENTIFIER { $1 }

classdeclaration : CLASS IDENTIFIER classbody { Class(Type($2), fst($3), snd($3)) }
--                | modifiers CLASS IDENTIFIER classbody { $1 Class($3, $4) }

classbody        : LBRACKET RBRACKET  { ([], []) }
   | LBRACKET classbodydeclarations  RBRACKET { $2 }

modifiers        : modifier { [$1] }
  | modifiers modifier { $1 ++ [$2] }

classbodydeclarations :  classbodydeclaration { [$1] }
   | classbodydeclarations classbodydeclaration { $1 ++ [$2] }

modifier         : PUBLIC { Public }
   | PROTECTED { Protected }
                 | PRIVATE { Private }
                 | STATIC { Static }
                 | ABSTRACT { Abstract }

classtype        : classorinterfacetype{ $1 }

classbodydeclaration : classmemberdeclaration { $1  }
   | constructordeclaration { $1 }

classorinterfacetype : name { $1 }

classmemberdeclaration : fielddeclaration { $1 }
   | methoddeclaration { $1 }

constructordeclaration : constructordeclarator constructorbody { Empty }
--   |  modifiers constructordeclarator constructorbody { $1, $2, $3 }

fielddeclaration : type variabledeclarators  SEMICOLON { FieldDecl($1 , $2) }
--    | modifiers type variabledeclarators  SEMICOLON { $1, FieldDecl($2, $3) }

methoddeclaration : methodheader methodbody {  Empty }

block            : LBRACKET   RBRACKET { Empty }
   | LBRACKET  blockstatements  RBRACKET { Empty }

constructordeclarator :  simplename LBRACE  RBRACE  { $1 }
   |  simplename LBRACE formalparameterlist RBRACE  { Empty }

constructorbody  : LBRACKET RBRACKET { Empty }
   | LBRACKET explicitconstructorinvocation  RBRACKET { Empty }
   | LBRACKET blockstatements  RBRACKET { Empty }
   | LBRACKET explicitconstructorinvocation blockstatements RBRACKET { Empty }

methodheader  : type methoddeclarator { Empty }
--    | modifiers type methoddeclarator { $1 $2 $3 }
--    | VOID methoddeclarator { $2 }
--    | modifiers VOID methoddeclarator { $1 $3 }

type             : primitivetype { $1 }
   | referencetype { $1 }
variabledeclarators : variabledeclarator { [$1] }
  | variabledeclarators  COMMA  variabledeclarator { $1 ++ [$3] }

methodbody       : block { $1 }
   | SEMICOLON {  Empty }

blockstatements  : blockstatement { [$1] }
   | blockstatements blockstatement { $1 ++ $2 }

formalparameterlist : formalparameter { [$1] }
   | formalparameterlist  COMMA  formalparameter { $1 ++[$2] }

explicitconstructorinvocation : THIS LBRACE  RBRACE   SEMICOLON  { This }
   | THIS LBRACE argumentlist  RBRACE   SEMICOLON  { Empty }

classtypelist    : classtype { [$1] }
   | classtypelist  COMMA  classtype { $1 ++[$3] }

methoddeclarator : IDENTIFIER LBRACE  RBRACE  { $1 }
   | IDENTIFIER LBRACE formalparameterlist  RBRACE  { Empty }

primitivetype    : BOOLEAN { Type("bool") }
   | numerictype { $1 }

referencetype    : classorinterfacetype { $1 }

variabledeclarator : variabledeclaratorid { $1 }
   | variabledeclaratorid ASSIGN variableinitializer { Empty }

blockstatement  : localvariabledeclarationstatement { $1 }
   | statement  { $1 }

formalparameter  : type variabledeclaratorid { ($1, $3) }

argumentlist     : expression { [$1] }
   | argumentlist  COMMA  expression { $1 ++[$3] }

numerictype      : integraltype { $1 }

variabledeclaratorid : IDENTIFIER { $1 }
variableinitializer  : expression { $1 }

localvariabledeclarationstatement : localvariabledeclaration  SEMICOLON  { $1 }

statement        : statementwithouttrailingsubstatement { $1  }
   | ifthenstatement { $1 }
   | ifthenelsestatement { $1 }
   | whilestatement { $1 }
         

expression       : assignmentexpression { $1 }

integraltype     : INT  { Type("int") }
                 | CHAR { Type("char") }

localvariabledeclaration : type variabledeclarators { Empty }

statementwithouttrailingsubstatement : block { $1 }
   | emptystatement { Empty }
   | expressionstatement { $1 }
   | returnstatement { $1 }

ifthenstatement  : IF LBRACE expression  RBRACE  statement { Empty }

ifthenelsestatement : IF LBRACE expression  RBRACE statementnoshortif ELSE statement  { Empty }

whilestatement   : WHILE LBRACE expression  RBRACE  statement { While($3, $5) }

assignmentexpression : conditionalexpression { $1 }
   |  assignment { $1 }

emptystatement  :  SEMICOLON  { Empty }

expressionstatement : statementexpression  SEMICOLON { $1 }

returnstatement  : RETURN  SEMICOLON  { Empty } 
   | RETURN expression  SEMICOLON { Return($2) }

statementnoshortif : statementwithouttrailingsubstatement { $1 }
   | ifthenelsestatementnoshortif { $1 }
   | whilestatementnoshortif { $1 }

conditionalexpression : conditionalorexpression { $1 }
   | conditionalorexpression QUESMARK expression  COLON  conditionalexpression { Empty }

assignment       : lefthandside assignmentoperator assignmentexpression { Empty }
 

statementexpression : assignment { $1 }
   | preincrementexpression { $1 }
   | predecrementexpression { $1 }
   | postincrementexpression { $1 }
   | postdecrementexpression { $1 }
   | methodinvocation { $1 }
   | classinstancecreationexpression { $1 }

ifthenelsestatementnoshortif :IF LBRACE expression  RBRACE  statementnoshortif ELSE statementnoshortif  { Empty }

whilestatementnoshortif : WHILE LBRACE expression  RBRACE  statementnoshortif { Empty }

conditionalorexpression : conditionalandexpression { Empty }
   | conditionalorexpression LOGICALOR conditionalandexpression { Empty }

lefthandside     : name { $1 }

assignmentoperator : ASSIGN { Empty }
   | TIMESEQUAL { Empty }
   | DIVIDEEQUAL { Empty }
   | MODULOEQUAL { Empty }
   | PLUSEQUAL { Empty }
   | MINUSEQUAL { Empty }
   | SHIFTLEFTEQUAL { Empty }
   | SIGNEDSHIFTRIGHTEQUAL { Empty }
   | UNSIGNEDSHIFTRIGHTEQUAL { Empty }
   | ANDEQUAL { Empty }
   | XOREQUAL { Empty }
   | OREQUAL { Empty }

preincrementexpression : INCREMENT unaryexpression { Empty }

predecrementexpression : DECREMENT unaryexpression { Empty }

postincrementexpression : postfixexpression INCREMENT { Empty }

postdecrementexpression : postfixexpression DECREMENT { Empty }

methodinvocation : name LBRACE   RBRACE  { $1 }
   | name LBRACE argumentlist RBRACE { Empty }
   | primary  DOT IDENTIFIER LBRACE RBRACE  { Empty }
   | primary  DOT IDENTIFIER LBRACE argumentlist  RBRACE  { Empty }
     
classinstancecreationexpression : NEW classtype LBRACE   RBRACE  { Empty }
                 | NEW classtype LBRACE  argumentlist  RBRACE  { Empty }

conditionalandexpression : inclusiveorexpression { Empty }

fieldaccess      : primary  DOT IDENTIFIER { Empty }

unaryexpression  : preincrementexpression { $1 }
   | predecrementexpression { $1 }
   | PLUS unaryexpression { Empty }
   | MINUS unaryexpression { Empty }
   | unaryexpressionnotplusminus { Empty }

postfixexpression : primary { Empty }
   | name { $1 }
   | postincrementexpression { Empty }
   | postdecrementexpression { Empty }

primary   : primarynonewarray { Empty }

inclusiveorexpression : exclusiveorexpression { Empty }
   | inclusiveorexpression OR exclusiveorexpression { Empty }

primarynonewarray : literal { $1 }
   | THIS { This }
   | LBRACE expression RBRACE  { Empty }
                 | classinstancecreationexpression { Empty }
   | fieldaccess { Empty }
   | methodinvocation { Empty }

unaryexpressionnotplusminus : postfixexpression { Empty }
          | TILDE unaryexpression { Empty }
   | EXCLMARK unaryexpression { Empty }
   | castexpression { Empty }

exclusiveorexpression : andexpression { Empty }
   | exclusiveorexpression XOR andexpression { Empty }

literal   : INTLITERAL { $1 }
   | BOOLLITERAL { $1 }
   | CHARLITERAL { $1 }
   | STRINGLITERAL { $1 }
   | JNULL { Jnull }

castexpression  : LBRACE  primitivetype  RBRACE  unaryexpression { Empty }
    | LBRACE  expression  RBRACE  unaryexpressionnotplusminus{ Empty  }

andexpression    : equalityexpression { Empty }
   | andexpression AND equalityexpression { Empty }

equalityexpression : relationalexpression { Empty }
   | equalityexpression EQUAL relationalexpression { Empty }
   | equalityexpression NOTEQUAL relationalexpression { Empty }

relationalexpression : shiftexpression { Empty }
   | relationalexpression LESS shiftexpression { Empty }
   | relationalexpression GREATER shiftexpression { Empty }
   | relationalexpression LESSEQUAL shiftexpression { Empty }
   | relationalexpression GREATEREQUAL shiftexpression { Empty }
   | relationalexpression INSTANCEOF referencetype { Empty }

shiftexpression  : additiveexpression { Empty }

additiveexpression : multiplicativeexpression { Empty }
   | additiveexpression PLUS multiplicativeexpression { Empty }
   | additiveexpression MINUS multiplicativeexpression { Empty }

multiplicativeexpression : unaryexpression { Empty }
   | multiplicativeexpression MUL unaryexpression { Empty }
   | multiplicativeexpression DIV unaryexpression { Empty }
   | multiplicativeexpression MOD unaryexpression { Empty }


{
parse = modifiers . alexScanTokens 
parseError :: [Token] -> a
parseError _ = error "Parse error"

}
