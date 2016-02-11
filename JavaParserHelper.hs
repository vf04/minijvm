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
