module JavaParserHelper where
import AbsSyn
fieldDeclToList(f) = ([f], [])
methodDeclToList(m) = ([], [m])
getIdString(l) =
  if length l == 0
    then ""
  else if length l == 1
    then head l
  else head l ++ "," ++ getIdString(tail l)

getVarDeclIds(v) =
  if length v == 0
    then ""
  else if length v == 1
    then getIdString(fst(head(v)))
  else getIdString(fst(head(v))) ++ "," ++ getVarDeclIds(tail(v))

getVarDeclBody(v) =
  if length v == 0
    then []
  else snd(head(v)) ++ getVarDeclBody(tail(v))

getVarDeclAssignment(id, expr) = ([id], [StmtExprStmt(Assign(LocalOrFieldVar(id), expr))])

-- Get a list of statements.
buildAssignStmt(Assign(LocalOrFieldVar(v), Jnull)) = []
buildAssignStmt(Assign(LocalOrFieldVar(v), e)) = [StmtExprStmt(Assign(LocalOrFieldVar(v), e))]

buildVDeclStmts(t, d) =
  let s = fst(d) in
  let e = snd(d) in
  [LocalVarDecl(t, s)] ++ buildAssignStmt(Assign(LocalOrFieldVar(s), e))

buildVDeclAssign(t, xs) = buildVDeclStmts(t, head(xs)) ++ buildVDeclAssign(t, tail(xs))
