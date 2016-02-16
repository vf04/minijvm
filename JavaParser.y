{
module JavaParser (parse) where
import AbsSyn
import JavaLexer
import JavaParserHelper
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
%name parse1 localvariabledeclarationstatement
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

name             : qualifiedname { $1 }
   | simplename { $1 } 

typedeclaration  : classdeclaration { $1 }

qualifiedname    : name  DOT IDENTIFIER { $1 ++ "." ++ $3 }

simplename       : IDENTIFIER { $1 }

classdeclaration : CLASS IDENTIFIER classbody { Class(Type($2), fst($3), snd($3), []) }
  | modifiers CLASS IDENTIFIER classbody { Class(Type($3), fst($4), snd($4), []) }

classbody        : LBRACKET RBRACKET  { ([], []) }
  | LBRACKET classbodydeclarations  RBRACKET { $2 }

modifiers        : modifier { [$1] }
  | modifiers modifier { $1 ++ [$2] }

classbodydeclarations :  classbodydeclaration { $1 }
  | classbodydeclarations classbodydeclaration { (fst($1) ++ fst($2), snd($1) ++ snd($2)) }

modifier         : PUBLIC { Public }
   | PROTECTED { Protected }
                 | PRIVATE { Private }
                 | STATIC { Static }
                 | ABSTRACT { Abstract }

classtype        : classorinterfacetype{ $1 }

classbodydeclaration : classmemberdeclaration { $1  }
--   | constructordeclaration { $1 }

classorinterfacetype : name { $1 }

classmemberdeclaration : fielddeclaration { fieldDeclToList($1) }
  | methoddeclaration { methodDeclToList($1) }

fielddeclaration : type variabledeclarators  SEMICOLON { FieldDecl($1, getVarDeclIdString($2)) }
  | modifiers type variabledeclarators  SEMICOLON { FieldDecl($2, getVarDeclIdString($3)) }

type             : primitivetype { $1 }
  | referencetype { $1 }

variabledeclarators : variabledeclarator { [$1] }
  | variabledeclarators  COMMA  variabledeclarator { $1 ++ [$3] }

variabledeclarator : variabledeclaratorid { ($1, Jnull) }
  | variabledeclaratorid ASSIGN variableinitializer { ($1, $3) }

variabledeclaratorid : IDENTIFIER { $1 }

variableinitializer  : expression { $1 }

methoddeclaration : methodheader methodbody { MethodDecl(fst($1), fst(snd($1)), snd(snd($1)), $2) }

methodheader  : type methoddeclarator { ($1, $2) }
  | modifiers type methoddeclarator { ($2, $3) }
  | VOID methoddeclarator { (Type("void"), $2) }

methodbody       : block { $1 }

primitivetype    : BOOLEAN { Type("bool") }
   | numerictype { $1 }

referencetype    : classorinterfacetype { Type($1) }

numerictype      : integraltype { $1 }

integraltype     : INT  { Type("int") }
                 | CHAR { Type("char") }

block            : LBRACKET   RBRACKET { Block([Empty])}
  | LBRACKET  blockstatements  RBRACKET { Block($2) }

methoddeclarator : IDENTIFIER LBRACE  RBRACE  { ($1, []) }
   | IDENTIFIER LBRACE formalparameterlist  RBRACE  { ($1, $3) }
formalparameterlist : formalparameter { [$1] }
   | formalparameterlist  COMMA  formalparameter { $1 ++[$3] }

formalparameter  : type variabledeclaratorid { ($1, $2) }

blockstatements  : blockstatement { $1 }
  | blockstatements blockstatement { $1 ++ $2 }

blockstatement  : localvariabledeclarationstatement { $1 }
  | statement  { [$1] }

localvariabledeclarationstatement : localvariabledeclaration  SEMICOLON  { buildVDeclAssign(fst($1), snd($1)) }

localvariabledeclaration : type variabledeclarators { ($1, $2) }

statement        : statementwithouttrailingsubstatement { $1  }

statementwithouttrailingsubstatement : block { $1 }
   | emptystatement { $1 }
--  | expressionstatement { $1 }
  | returnstatement { $1 }

emptystatement  :  SEMICOLON  { Empty }

-- expressionstatement : statementexpression  SEMICOLON { $1 }

returnstatement  : RETURN  SEMICOLON  { Return(Nothing) }
  | RETURN expression  SEMICOLON { Return(Just $2) }

expression       : literal { $1 }
  | statementexpression { StmtExprExpr($1) }
  | name {LocalOrFieldVar($1) }

literal   : INTLITERAL { Integer($1) }
   | BOOLLITERAL { Bool($1) }
   | CHARLITERAL { Char($1) }
   | STRINGLITERAL { String($1) }
   | JNULL { Jnull }

statementexpression : methodinvocation { $1 }

methodinvocation : name LBRACE   RBRACE  { MethodCall(This, $1, []) }
  | name LBRACE argumentlist RBRACE { MethodCall(This, $1, $3) }
--   | primary  DOT IDENTIFIER LBRACE RBRACE  { MethodCall($1, $3, [])}
--   | primary  DOT IDENTIFIER LBRACE argumentlist  RBRACE  { MethodCall($1, $3, $5) }

primary   : primarynonewarray { $1 }

primarynonewarray : literal { $1 }
   | THIS { This }
--   | LBRACE expression RBRACE  { $2 }
  | fieldaccess { $1 }
--  | methodinvocation { $1 }

fieldaccess      : primary  DOT IDENTIFIER { InstVar($1, $3) }

argumentlist     : expression { [$1] }
   | argumentlist  COMMA  expression { $1 ++[$3] }

{
parse = compilationunit . alexScanTokens

parseError :: [Token] -> a
parseError _ = error "Parse error"

}
