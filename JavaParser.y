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

classbody        : LBRACKET RBRACKET  { ([FieldDecl], [MethodDecl]) }
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

constructordeclaration : constructordeclarator constructorbody { $1, $2 }
--   |  modifiers constructordeclarator constructorbody { $1, $2, $3 }

fielddeclaration : type variabledeclarators  SEMICOLON { FieldDecl($1 , $2) }
--    | modifiers type variabledeclarators  SEMICOLON { $1, FieldDecl($2, $3) }

methoddeclaration : methodheader methodbody { $1, $2 }

block            : LBRACKET   RBRACKET { Block([]) }
   | LBRACKET  blockstatements  RBRACKET { Block($2) }

constructordeclarator :  simplename LBRACE  RBRACE  { $1 }
   |  simplename LBRACE formalparameterlist RBRACE  { $1, $3 }

constructorbody  : LBRACKET RBRACKET { Empty }
   | LBRACKET explicitconstructorinvocation  RBRACKET { $2 }
   | LBRACKET blockstatements  RBRACKET { $2 }
   | LBRACKET explicitconstructorinvocation blockstatements RBRACKET { $2, $3 }

methodheader  : type methoddeclarator { $1, $2 }
   | modifiers type methoddeclarator { $1 $2 $3 }
   | VOID methoddeclarator { $2 }
   | modifiers VOID methoddeclarator { $1 $3 }

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
   | THIS LBRACE argumentlist  RBRACE   SEMICOLON  { [This] ++ $3 }

classtypelist    : classtype { [$1] }
   | classtypelist  COMMA  classtype { $1 ++[$3] }

methoddeclarator : IDENTIFIER LBRACE  RBRACE  { $1 }
   | IDENTIFIER LBRACE formalparameterlist  RBRACE  { $1, $3 }

primitivetype    : BOOLEAN { Type("bool") }
   | numerictype { $1 }

referencetype    : classorinterfacetype { $1 }

variabledeclarator : variabledeclaratorid { $1 }
   | variabledeclaratorid ASSIGN variableinitializer { $1, $3 }

blockstatement  : localvariabledeclarationstatement { $1 }
   | statement  { $1 }

formalparameter  : type variabledeclaratorid { $1, $2 }

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

localvariabledeclaration : type variabledeclarators { $1, $2 }

statementwithouttrailingsubstatement : block { $1 }
   | emptystatement { }
   | expressionstatement { $1 }
   | returnstatement { $1 }

ifthenstatement  : IF LBRACE expression  RBRACE  statement { If($3, $5, Nothing) }

ifthenelsestatement : IF LBRACE expression  RBRACE statementnoshortif ELSE statement  { If($3, $5, Just $7) }

whilestatement   : WHILE LBRACE expression  RBRACE  statement { While($3, $5) }

assignmentexpression : conditionalexpression { $1 }
   |  assignment { $1 }

emptystatement  :  SEMICOLON  { Empty }

expressionstatement : statementexpression  SEMICOLON { $1 }

returnstatement  : RETURN  SEMICOLON  { Return(Jnull) }
   | RETURN expression  SEMICOLON { Return($2) }

statementnoshortif : statementwithouttrailingsubstatement { $1 }
   | ifthenelsestatementnoshortif { $1 }
   | whilestatementnoshortif { $1 }

conditionalexpression : conditionalorexpression { $1 }
   | conditionalorexpression QUESMARK expression  COLON  conditionalexpression { }

assignment       : lefthandside assignmentoperator assignmentexpression { }
 

statementexpression : assignment { $1 }
   | preincrementexpression { $1 }
   | predecrementexpression { $1 }
   | postincrementexpression { $1 }
   | postdecrementexpression { $1 }
   | methodinvocation { $1 }
   | classinstancecreationexpression { $1 }

ifthenelsestatementnoshortif :IF LBRACE expression  RBRACE  statementnoshortif
         ELSE statementnoshortif  { }

whilestatementnoshortif : WHILE LBRACE expression  RBRACE  statementnoshortif { }

conditionalorexpression : conditionalandexpression { }
   | conditionalorexpression LOGICALOR conditionalandexpression{ }

lefthandside     : name { $1 }

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

methodinvocation : name LBRACE   RBRACE  { $1 }
   | name LBRACE argumentlist RBRACE { $1, $2 }
   | primary  DOT IDENTIFIER LBRACE RBRACE  { $1, $3 }
   | primary  DOT IDENTIFIER LBRACE argumentlist  RBRACE  { }
     
classinstancecreationexpression : NEW classtype LBRACE   RBRACE  { $2 }
                 | NEW classtype LBRACE  argumentlist  RBRACE  { $2, $4 }

conditionalandexpression : inclusiveorexpression { }

fieldaccess      : primary  DOT IDENTIFIER { }

unaryexpression  : preincrementexpression { }
   | predecrementexpression { }
   | PLUS unaryexpression { }
   | MINUS unaryexpression { }
   | unaryexpressionnotplusminus { }

postfixexpression : primary { }
   | name { }
   | postincrementexpression { }
   | postdecrementexpression{ }

primary   : primarynonewarray { }

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

literal   : INTLITERAL { }
   | BOOLLITERAL { }
   | CHARLITERAL { }
   | STRINGLITERAL { }
   | JNULL { Jnull }

castexpression  : LBRACE  primitivetype  RBRACE  unaryexpression { }
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

shiftexpression  : additiveexpression { }

additiveexpression : multiplicativeexpression { }
   | additiveexpression PLUS multiplicativeexpression { }
   | additiveexpression MINUS multiplicativeexpression { }

multiplicativeexpression : unaryexpression { }
   | multiplicativeexpression MUL unaryexpression { }
   | multiplicativeexpression DIV unaryexpression { }
   | multiplicativeexpression MOD unaryexpression { }


{
parse = modifiers . alexScanTokens 
parseError :: [Token] -> a
parseError _ = error "Parse error"

}
