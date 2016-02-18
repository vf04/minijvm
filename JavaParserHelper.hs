module JavaParserHelper where
import AbsSyn
-- Returns list of field declarations from a tuple.
fieldDeclToList(f) = ([f], [])

-- Returns a list of method declarations from a tuple.
methodDeclToList(m) = ([], [m])

-- Gets a list of strings and returns a string in format "x1,x2...xn".
getIdString(l) =
  if length l == 0
    then ""
  else if length l == 1
    then head l
  else head l ++ "," ++ getIdString(tail(l))

-- Takes a list of variable declarators and returns a list with the corresponding ids.
getVarDeclIds([]) = []
getVarDeclIds(v) = [fst(head(v))] ++ getVarDeclIds(tail(v))

-- Takes a list of variable declarators and returns the corresponding ids as string.
getVarDeclIdString(v) = getIdString(getVarDeclIds(v))

-- Turns a variable declaration into a list with a corresponding assign statement.
buildAssignStmt(Assign(LocalOrFieldVar(v), Jnull)) = []
buildAssignStmt(Assign(LocalOrFieldVar(v), e)) = [StmtExprStmt(Assign(LocalOrFieldVar(v), e))]

-- Turns a variable declaration into a list containing the corresponding name and assign statements.
buildVDeclStmts(t, d) =
  let s = fst(d) in
  let e = snd(d) in
  [LocalVarDecl(t, s)] ++ buildAssignStmt(Assign(LocalOrFieldVar(s), e))

-- Takes a list of variables of the form (Type, vardecl) and returns a list with the corresponding name and assign statements.
buildVDeclAssign(t, []) = []
buildVDeclAssign(t, xs) = buildVDeclStmts(t, head(xs)) ++ buildVDeclAssign(t, tail(xs))

-- Takes left and right sides +operator of an assignment and returns a corresponding assign statement.
getAssignExpr(l, "=", exp) = Assign(l, exp)
getAssignExpr(l, op, exp) = Assign(l, Jnull)

-- Get unary or simple expression
getExprFromUnary(Unary(op, expr)) = expr
