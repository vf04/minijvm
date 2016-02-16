module JavaParserHelper where
import AbsSyn
fieldDeclToList(f) = ([f], [])
methodDeclToList(m) = ([], [m])

getIdString(l) =
  if length l == 0
    then ""
  else if length l == 1
    then head l
  else head l ++ "," ++ getIdString(tail(l))

getVarDeclIds([]) = []
getVarDeclIds(v) = [fst(head(v))] ++ getVarDeclIds(tail(v))

getVarDeclIdString(v) = getIdString(getVarDeclIds(v))

-- Get a list of statements.
buildAssignStmt(Assign(LocalOrFieldVar(v), Jnull)) = []
buildAssignStmt(Assign(LocalOrFieldVar(v), e)) = [StmtExprStmt(Assign(LocalOrFieldVar(v), e))]

buildVDeclStmts(t, d) =
  let s = fst(d) in
  let e = snd(d) in
  [LocalVarDecl(t, s)] ++ buildAssignStmt(Assign(LocalOrFieldVar(s), e))

buildVDeclAssign(t, []) = []
buildVDeclAssign(t, xs) = buildVDeclStmts(t, head(xs)) ++ buildVDeclAssign(t, tail(xs))
