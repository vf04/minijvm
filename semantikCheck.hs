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

typecheckExpr(Unary(operator, expr)) = 
	(\ localVars -> (\ classes -> 
	let typedExpr = (typecheckExpr(expr))(localVars)(classes)
	in TypedExpr(Unary(operator,typedExpr),getTypeFromExpr(typedExpr))))
typecheckExpr(Binary(operator, expA, expB)) = 
	(\ localVars -> (\ classes -> 
	let
		typedExprA = typecheckExpr expA localVars classes
		typedExprB = typecheckExpr expB localVars classes
		typeA = getTypeFromExpr typedExprA
		typeB = getTypeFromExpr typedExprB
		typeOfBinary = getTypeOfBinary operator typeA typeB
	in TypedExpr(Binary(operator,typedExprA,typedExprB),typeOfBinary)))
typecheckExpr(Integer(i)) = (\ _ -> (\ _ -> TypedExpr(Integer(i),"int")))
typecheckExpr(Bool(b)) = (\ _ -> (\ _ -> TypedExpr(Bool(b),"bool")))
typecheckExpr(Char(c)) = (\ _ -> (\ _ -> TypedExpr(Char(c),"char")))
typecheckExpr(String(s)) = (\ _ -> (\ _ -> TypedExpr(String(s),"String")))
typecheckExpr(Jnull) = (\ _ -> (\ _ -> TypedExpr(Jnull,"null")))


typecheckStmt :: Stmt -> [(String, Type)] -> [Class] -> Stmt
typecheckStmt(Block((LocalVarDecl(localVarType, localVarName)) : stmts)) = (\localVars -> (\classes ->
	let
		typedFirstStmt = typecheckStmt (LocalVarDecl(localVarType,localVarName)) localVars classes
		oldLocalVars = removeLocalVar localVarName localVars
		newLocalVars = (localVarType, localVarName) : oldLocalVars
		typedBlockOfStmts = typecheckStmt (Block(stmts)) newLocalVars classes
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
	in
		TypedStmt(Block([typedFirstStmt,typedBlockOfStmts]),typeOfBlockOfStmts)))
typecheckStmt(Block(firstStmt : stmts)) = (\localVars -> (\classes ->
	let
		typedFirstStmt = typecheckStmt firstStmt localVars classes
		typeOfFirstStmt = getTypeFromStmt typedFirstStmt
		typedBlockOfStmts = typecheckStmt (Block(stmts)) localVars classes
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
		typeOfBlock = typeUpperBound typeOfFirstStmt typeOfBlockOfStmts
	in
		TypedStmt(Block([typedFirstStmt,typedBlockOfStmts]),typeOfBlock)))
typecheckStmt(Block([])) = (\_ -> (\_ -> TypedStmt(Block([]),"void")))
typecheckStmt(Return(expr)) = (\localVars -> (\classes ->
	let
		typedExpr = typecheckExpr expr localVars classes
		exprType = getTypeFromExpr typedExpr
	in
		TypedStmt(Return(typedExpr),exprType)))
typecheckStmt(While(conditionExpr, stmt)) = (\localVars -> (\classes ->
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmt = typecheckStmt stmt localVars classes
		stmtType = getTypeFromStmt typedStmt
	in
		TypedStmt(While(typedConditionExpr, typedStmt), stmtType)))
typecheckStmt(LocalVarDecl(varType, varName)) = (\localVars -> (\classes ->
	TypedStmt(LocalVarDecl(varType, varName),"void")))
typecheckStmt(If(conditionExpr, stmtTrue, Nothing)) = (\localVars -> (\classes ->
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmtTrue = typecheckStmt typedStmtTrue localVars classes
		stmtTrueType = getTypeFromStmt typedStmtTrue
		upperBoundStmtType = typeUpperBound stmtTrueType "void"
	in
		TypedStmt(If(typedConditionExpr, typedStmtTrue, Nothing),upperBoundStmtType)))
typecheckStmt(If(conditionExpr, stmtTrue, Just stmtFalse)) = (\localVars -> (\classes ->
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmtTrue = typecheckStmt typedStmtTrue localVars classes
		stmtTrueType = getTypeFromStmt typedStmtTrue
		typedStmtFalse = typecheckStmt stmtFalse localVars classes
		stmtFalseType = getTypeFromStmt typedStmtFalse
		upperBoundStmtType = typeUpperBound stmtTrueType stmtFalseType
	in
		TypedStmt(If(typedConditionExpr, typedStmtTrue, (Just typedStmtFalse)),upperBoundStmtType)))

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
			error "assign type mismatch"))

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
			error "argument type mismatch in method call"))

typecheckFieldDecls :: [FieldDecl] -> [Class] -> Bool
typecheckFieldDecls fieldDecls classes = and $ map (\(FieldDecl(fieldType,_)) -> typeExists fieldType classes) fieldDecls

typecheckMethod :: MethodDecl -> Type -> [Class] -> MethodDecl
typecheckMethod(Method(methodType, methodName, arguments, stmt)) = (\thisType -> (\classes ->
	let
		returnTypeIsValid = typeExists methodType classes
	in
		if returnTypeIsValid
		then
			let
				argumentTypesAreValid = and $ map (\(argumentType,_) -> typeExists argumentType classes) arguments
			in
				if argumentTypesAreValid
				then
					let
						localVars = map (\(typeName,argName) -> (argName,typeName)) arguments
						typedStmt = typecheckStmt stmt (("this",thisType) : localVars) classes
						actualMehtodType = getTypeFromStmt typedStmt
					in
						if isSubtypeOf actualMehtodType methodType
						then
							Method(methodType, methodName, arguments, typedStmt)
						else
							error "Method return type does not match to the given type"
				else
					error $ "One or multiple arguments of method" ++ methodName ++ " in class " ++ thisType ++ " name an invalid type"
		else
			error $ "Invalid return type " ++ methodType ++ " of method " ++ methodName ++ " in class " ++ thisType))

typecheckClass :: Class -> [Class] -> Class
typecheckClass(Class(className, fieldDecls, methodDecls)) = (\classes ->
	let
		fieldDeclTypesExist = and $ map (\(FieldDecl(fieldType,_)) -> typeExists fieldType classes) fieldDecls
	in
		if fieldDeclTypesExist
		then
			let
				typedMethods = map (\methodDecl -> typecheckMethod methodDecl className classes) methodDecls
			in
				Class(className, fieldDecls, typedMethods)
		else
			error $ "One or multiple field declarations of class " ++ className ++ " name an invalid type")

typecheckPrg :: Prg -> Prg
typecheckPrg(classes) =
	map (\theClass -> typecheckClass theClass classes) classes

-- Hilfsfunktionen

typeUpperBound :: Type -> Type -> Type
typeUpperBound "void" x = x
typeUpperBound x "void" = x
typeUpperBound "null" x = "null"
typeUpperBound x "null" = "null"
typeUpperBound "bool" "bool" = "bool"
typeUpperBound "bool" "char" = "char"
typeUpperBound "bool" "int" = "int"
typeUpperBound "char" "bool" = "char"
typeUpperBound "char" "char" = "char"
typeUpperBound "char" "int" = "int"
typeUpperBound "int" "bool" = "int"
typeUpperBound "int" "char" = "int"
typeUpperBound "int" "int" = "int"
typeUpperBound _ _ = "Object"

getTypeOfBinary :: String -> Type -> Type -> Type
getTypeOfBinary("+") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("-") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("*") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("/") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("%") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("&&") = (\"bool" -> (\"bool" -> "bool"))
getTypeOfBinary("||") = (\"bool" -> (\"bool" -> "bool"))

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

isSubtypeOf :: Type -> Type -> Bool
isSubtypeOf x y = (typeUpperBound x y) == y

removeLocalVar :: String -> [(String, Type)] -> [(String, Type)]
removeLocalVar(varName) = (\varList ->
	foldr (\(aVarName,aVarType) list -> 
		if aVarName == varName then list
		else (aVarName,aVarType) : list) [] varList)

typeExists :: Type -> [Class] -> Bool
typeExists "bool" _ = True
typeExists "char" _ = True
typeExists "int" _ = True
typeExists "null" _ = True
typeExists "void" _ = True
typeExists "String" _ = True
typeExists "Object" _ = True
typeExists typeName classes = elem typeName $ map (\(Class(className,_,_)) -> className) classes

