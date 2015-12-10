import AbsSyn

-- Ausdruck/Statement, Lokale Variablen, Sichtbare Klassen -> Getypter Ausdruck/Statement

typecheckExpr :: Expr -> [(String, Type)] -> [Class] -> Expr
typecheckExpr(LocalOrFieldVar(varName)) = (\ localVars -> (\ classes ->
	let
		localVar = getLocalVar varName localVars
	in
		if localVar == Nothing
		then
			let
				thisVar = getLocalVar "this" localVars
				thisClassType = (\(Just (_, typeName)) -> typeName) thisVar
				thisClass = getClass thisClassType classes
				fieldVarDecl = getFieldDecl varName ((\(Just (Class(_,a,_))) -> a) thisClass)
				fieldVarType = (\(Just (FieldDecl(fieldType, _))) -> fieldType) fieldVarDecl
			in
			TypedExpr(LocalOrFieldVar(varName),fieldVarType)
		else
			let
				varType = (\(Just (_, typeName)) -> typeName) localVar
			in
				TypedExpr(LocalOrFieldVar(varName),varType)))

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
typeofBinary(operator,typeA,typeB) = "FIXME : Type of Binary"

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

getMethodDecl :: String -> [MethodDecl] -> Maybe MethodDecl
getMethodDecl _ [] = Nothing
getMethodDecl name (Method(methodType,methodName,methodArgs,methodStmts) : methodDecls)
	| methodName == name = Just (Method(methodType,methodName,methodArgs,methodStmts))
	| otherwise = getMethodDecl name methodDecls

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

isSubtypeOf :: Type -> Type -> Bool
isSubtypeOf "bool" "bool" = True
isSubtypeOf "char" "char" = True
isSubtypeOf "int" "int" = True
isSubtypeOf "bool" "int" = True
isSubtypeOf "int" "bool" = False
isSubtypeOf "null" _ = True
isSubtypeOf _ "null" = False
isSubtypeOf "bool" "char" = True
isSubtypeOf "char" "bool" = False
isSubtypeOf "char" "int" = True
isSubtypeOf "int" "char" = False

--typecheckStmt :: Stmt -> [(String, Type)] -> [Class] -> Stmt

typecheckStmtExpr :: StmtExpr -> [(String, Type)] -> [Class] -> StmtExpr
typecheckStmtExpr(Assign(expA, expB)) = (\localVars -> (\classes ->
	let
		typedExprA = typecheckExpr expA localVars classes
		typedExprB = typecheckExpr expB localVars classes
		typeA = getTypeFromExpr typedExprA
		typeB = getTypeFromExpr typedExprB
	in
		if isSubtypeOf typeB typeA
		then
			(TypedStmtExpr(Assign(typedExprA,typedExprB),typeA))
		else
			(TypedStmtExpr(Assign(typedExprA,typedExprB),"FIXME: type mismatch"))))
-- TODO: Prüfen, ob Typen kompatibel sind

typecheckStmtExpr(New(newType, newExpressions)) = (\localVars -> (\classes ->
	let
		typedNewExpressions = map (\expr -> typecheckExpr expr localVars classes) newExpressions
	in
		(TypedStmtExpr(New(newType,typedNewExpressions),newType))))

typecheckStmtExpr(MethodCall(instanceExpr, methodName, arguments)) = (\localVars -> (\classes ->
	let
		typedArguments = map (\arg -> typecheckExpr arg localVars classes) arguments
		typedInstance = typecheckExpr instanceExpr localVars classes
		instanceType = getTypeFromExpr typedInstance
		instanceClass = getClass instanceType classes
		methodDecl = getMethodDecl methodName ((\(Just (Class(_,_,x))) -> x)(instanceClass))
		methodType = (\(Just (Method(typeName,_,_,_))) -> typeName) methodDecl
		methodArgs = (\(Just (Method(_,_,args,_))) -> args) methodDecl
		declArgTypes = map (\(argType, argName) -> argType) methodArgs
		actualArgTypes = map getTypeFromExpr typedArguments
		argTypesMatch = and $ map (\(declType,actualType) -> isSubtypeOf actualType declType) $ zip declArgTypes actualArgTypes
	in
		if argTypesMatch
		then
			(TypedStmtExpr(MethodCall(typedInstance,methodName,typedArguments),methodType))
		else
			(TypedStmtExpr(MethodCall(typedInstance,methodName,typedArguments),"FIXME: argument type mismatch"))))
-- TODO: Prüfen, ob Argument-Typen kompatibel sind
