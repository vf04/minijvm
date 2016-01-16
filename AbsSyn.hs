module AbsSyn where

type Type = String

data Class = Class(Type, [FieldDecl], [MethodDecl]) deriving (Show)

data FieldDecl = FieldDecl(Type, String) deriving (Show)

data MethodDecl = MethodDecl(Type, String,[(Type,String)], Stmt) deriving (Show)

data Stmt = Block([Stmt])
          | Return( Expr )
          | While( Expr , Stmt )
          | LocalVarDecl(Type, String) 
          | If(Expr, Stmt , Maybe Stmt) 
          | StmtExprStmt(StmtExpr) 
      | TypedStmt(Stmt, Type)
          deriving (Show)

getTypeFromStmt (TypedStmt(_, typ)) = typ

data StmtExpr = Assign(Expr, Expr) 
              | New(Type, [Expr]) 
              | MethodCall(Expr, String, [Expr]) 
              | TypedStmtExpr(StmtExpr, Type)
              deriving (Show)

getTypeFromStmtExpr (TypedStmtExpr(_, typ)) = typ

data Expr = This
          | Super
          | LocalOrFieldVar(String)
          | InstVar(Expr, String)
          | Unary(String, Expr)
          | Binary(String, Expr, Expr) 
          | Integer(Integer)
          | Bool(Bool)
          | Char(Char)
          | String(String)
          | Jnull
          | StmtExprExpr(StmtExpr)
          | TypedExpr(Expr, Type)
          deriving (Show)

getTypeFromExpr (TypedExpr(_, typ)) = typ
          
 
type Prg = [Class]

data Name = QualifiedName(Name, Identifier)
  | SimpleName(Identifier)
  deriving (Show)

data Identifier = Identifier(String)
  deriving(Show)

