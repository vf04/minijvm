import AbsSyn

-- Ausdruck/Statement, Lokale Variablen, Sichtbare Klassen -> Getypter Ausdruck/Statement

typecheckExpr :: Expr -> [(String, Type)] -> [Class] -> Expr
typecheckExpr(LocalOrFieldVar(varName)) = (\ localVars -> (\ classes ->
	let
		var = getLocalVar varName localVars
		varType = (\(Just (_, typeName)) -> typeName) var
	in
		TypedExpr(LocalOrFieldVar(varName),varType)))
--FIXME FieldVars

typecheckExpr(InstVar(expr, instVarName)) = (\ localVars -> (\ classes ->
	let
		instanceExpr = (typecheckExpr(expr) localVars classes)
		instanceType = getTypeFromExpr(instanceExpr)
		instanceClass = getClass instanceType classes
		instVarFieldDecl = getFieldDecl instVarName ((\(Just (Class(_,a,_))) -> a) instanceClass)
		instVarType = (\(Just (FieldDecl(fieldType, _))) -> fieldType) instVarFieldDecl
	in
		TypedExpr((InstVar(instanceExpr, instVarName)),instVarType)))
--TODO: Schönere Fehlerausgaben, falls Klasse oder Feld nicht gefunden

-- Eine Methode je Operator?
typecheckExpr(Unary(operator, expr)) = 
	(\ localVars -> (\ classes -> 
	let typedExpr = (typecheckExpr(expr))(localVars)(classes)
	in TypedExpr(Unary(operator,typedExpr),getTypeFromExpr(typedExpr))))
typecheckExpr(Binary(operator, expA, expB)) = 
	(\ localVars -> (\ classes -> 
	let
		typedExprA = (typecheckExpr(expA))(localVars)(classes)
		typedExprB = (typecheckExpr(expB))(localVars)(classes)
	in TypedExpr(Binary(operator,typedExprA,typedExprB),
				 typeofBinary(operator,getTypeFromExpr(typedExprA),getTypeFromExpr(typedExprB)))))
typecheckExpr(Integer(i)) = (\ _ -> (\ _ -> TypedExpr(Integer(i),"int")))
typecheckExpr(Bool(b)) = (\ _ -> (\ _ -> TypedExpr(Bool(b),"bool")))
typecheckExpr(Char(c)) = (\ _ -> (\ _ -> TypedExpr(Char(c),"char")))
typecheckExpr(String(s)) = (\ _ -> (\ _ -> TypedExpr(String(s),"String")))
typecheckExpr(Jnull) = (\ _ -> (\ _ -> TypedExpr(Jnull,"null")))

-- Hilfsfunktionen

typeofBinary :: (String, Type, Type) -> Type
typeofBinary(operator,typeA,typeB) = "FIXME"

getClass :: Type -> [Class] -> Maybe Class
getClass _ [] = Nothing
getClass className (Class(name, fieldDecl, methodDecl) : classes)
	| className == name = Just (Class(name, fieldDecl, methodDecl))
	| otherwise = getClass className classes

getFieldDecl :: String -> [FieldDecl] -> Maybe FieldDecl
getFieldDecl _ [] = Nothing
getFieldDecl name (FieldDecl(fieldType,fieldName) : fieldDecls)
	| fieldName == name = Just (FieldDecl(fieldType,fieldName))
	| otherwise = getFieldDecl name fieldDecls
	
getLocalVar :: String -> [(String, Type)] -> Maybe (String, Type)
getLocalVar _ [] = Nothing
getLocalVar name ((varName, varType) : localVars)
	| varName == name = Just (varName, varType)
	| otherwise = getLocalVar name localVars
--isFieldOfClass :: (String, Type, [Class]) -> Bool
--isFieldOfClass(fieldName, className, []) = False
--isFieldOfClass(fieldName, className, (Class(name, fieldDecl, methodDecl)) : classes) =
--	className == name && elem fieldName (map (\(FieldDecl(fType, fName)) -> fName) fieldDecl)
--	|| isFieldOfClass(fieldName, className, classes)


--typecheckStmt :: Stmt -> [(String, Type)] -> [Class] -> Stmt

