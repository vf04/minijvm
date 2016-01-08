import AbsSyn

-- Ausdruck/Statement, Lokale Variablen, Sichtbare Klassen -> Getypter Ausdruck/Statement

typecheckExpr :: Expr -> [(Type, String)] -> [Class] -> Expr
typecheckExpr(LocalOrFieldVar(varName)) = (\ localVars -> (\ classes ->
	let
		localVar = getMaybeLocalVar varName localVars
	in
		if localVar == Nothing
		then
			let
				thisVar = getMaybeLocalVar "this" localVars
				thisClassType = getTypeFromLocalVar $ deMaybe thisVar
				thisClass = getMaybeClass thisClassType classes
				fieldVarDecl = getMaybeFieldDecl varName $ getFieldDeclsFromClass $ deMaybe thisClass
				fieldVarType = getTypeFromFieldDecl $ deMaybe fieldVarDecl
			in
			TypedExpr(LocalOrFieldVar(varName),fieldVarType)
		else
			let
				varType = getTypeFromLocalVar $ deMaybe localVar
			in
				TypedExpr(LocalOrFieldVar(varName),varType)))

typecheckExpr(InstVar(expr, instVarName)) = (\ localVars -> (\ classes ->
	let
		instanceExpr = (typecheckExpr(expr) localVars classes)
		instanceType = getTypeFromExpr(instanceExpr)
		instanceClass = getMaybeClass instanceType classes
		instVarFieldDecl = getMaybeFieldDecl instVarName $ getFieldDeclsFromClass $ deMaybe instanceClass
		instVarType = getTypeFromFieldDecl $ deMaybe instVarFieldDecl
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
typecheckExpr(StmtExprExpr(stmtExpr)) =
	(\localVars -> (\classes ->
	let
		typedStmtExpr = typecheckStmtExpr stmtExpr localVars classes
		typeOfStmtExpr = getTypeFromStmtExpr typedStmtExpr
	in
		TypedExpr(StmtExprExpr(typedStmtExpr),typeOfStmtExpr)))

typecheckStmt :: Stmt -> [(Type, String)] -> [Class] -> Stmt
typecheckStmt(Block((LocalVarDecl(localVarType, localVarName)) : stmts)) = (\localVars -> (\classes ->
	let
		typedFirstStmt = typecheckStmt (LocalVarDecl(localVarType,localVarName)) localVars classes
		oldLocalVars = removeLocalVar localVarName localVars
		newLocalVars = (localVarType, localVarName) : oldLocalVars
		typedBlockOfStmts = typecheckStmt (Block(stmts)) newLocalVars classes
		typedRestOfStmts = (\(TypedStmt(Block(typedStmts),_)) -> typedStmts) typedBlockOfStmts
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
	in
		TypedStmt(Block(typedFirstStmt : typedRestOfStmts),typeOfBlockOfStmts)))
typecheckStmt(Block(firstStmt : stmts)) = (\localVars -> (\classes ->
	let
		typedFirstStmt = typecheckStmt firstStmt localVars classes
		typeOfFirstStmt = getTypeFromStmt typedFirstStmt
		typedBlockOfStmts = typecheckStmt (Block(stmts)) localVars classes
		typedRestOfStmts = (\(TypedStmt(Block(typedStmts),_)) -> typedStmts) typedBlockOfStmts
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
		typeOfBlock = typeUpperBound typeOfFirstStmt typeOfBlockOfStmts
	in
		TypedStmt(Block(typedFirstStmt : typedRestOfStmts),typeOfBlock)))
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
typecheckStmt(StmtExprStmt(stmtExpr)) =
	(\localVars -> (\classes ->
	let
		typedStmtExpr = typecheckStmtExpr stmtExpr localVars classes
		typeOfStmtExpr = getTypeFromStmtExpr typedStmtExpr
	in
		TypedStmt(StmtExprStmt(typedStmtExpr),"void")))


typecheckStmtExpr :: StmtExpr -> [(Type, String)] -> [Class] -> StmtExpr
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
		instanceClass = getMaybeClass instanceType classes
		methodDecl = getMaybeMethodDecl methodName $ getMethodDeclsFromClass $ deMaybe instanceClass
		methodType = getTypeFromMethodDecl $ deMaybe methodDecl
		methodArgs = getArgsFromMethodDecl $ deMaybe methodDecl
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
typecheckMethod(MethodDecl(methodType, methodName, arguments, stmt)) = (\thisType -> (\classes ->
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
							MethodDecl(methodType, methodName, arguments, typedStmt)
						else
							error "Method return type does not match to the given type"
				else
					error $ "One or multiple arguments of method " ++ methodName ++ " in class " ++ thisType ++ " name an invalid type"
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
typeUpperBound "bool" "int" = "int"
typeUpperBound "char" "char" = "char"
typeUpperBound "int" "bool" = "int"
typeUpperBound "int" "int" = "int"
typeUpperBound "String" "String" = "String"
typeUpperBound _ _ = "Object"

getTypeOfBinary :: String -> Type -> Type -> Type
getTypeOfBinary("+") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("-") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("*") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("/") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("%") = (\typeA -> (\typeB -> typeUpperBound typeA typeB))
getTypeOfBinary("&&") = (\"bool" -> (\"bool" -> "bool"))
getTypeOfBinary("||") = (\"bool" -> (\"bool" -> "bool"))

getMaybeClass :: Type -> [Class] -> Maybe Class
getMaybeClass _ [] = Nothing
getMaybeClass className (Class(name, fieldDecl, methodDecl) : classes)
	| className == name = Just (Class(name, fieldDecl, methodDecl))
	| otherwise = getMaybeClass className classes

getMaybeFieldDecl :: String -> [FieldDecl] -> Maybe FieldDecl
getMaybeFieldDecl _ [] = Nothing
getMaybeFieldDecl name (FieldDecl(fieldType,fieldName) : fieldDecls)
	| fieldName == name = Just (FieldDecl(fieldType,fieldName))
	| otherwise = getMaybeFieldDecl name fieldDecls

getMaybeMethodDecl :: String -> [MethodDecl] -> Maybe MethodDecl
getMaybeMethodDecl _ [] = Nothing
getMaybeMethodDecl name (MethodDecl(methodType,methodName,methodArgs,methodStmts) : methodDecls)
	| methodName == name = Just (MethodDecl(methodType,methodName,methodArgs,methodStmts))
	| otherwise = getMaybeMethodDecl name methodDecls

getMaybeLocalVar :: String -> [(Type, String)] -> Maybe (Type, String)
getMaybeLocalVar _ [] = Nothing
getMaybeLocalVar name ((varType, varName) : localVars)
	| varName == name = Just (varType, varName)
	| otherwise = getMaybeLocalVar name localVars
	
deMaybe :: Maybe a -> a
deMaybe(Just(a)) = a
	
getTypeFromLocalVar :: (Type, String) -> Type
getTypeFromLocalVar(typeName,_) = typeName

getTypeFromFieldDecl :: FieldDecl -> Type
getTypeFromFieldDecl(FieldDecl(typeName,_)) = typeName

getFieldDeclsFromClass :: Class -> [FieldDecl]
getFieldDeclsFromClass(Class(_,fieldDecls,_)) = fieldDecls

getMethodDeclsFromClass :: Class -> [MethodDecl]
getMethodDeclsFromClass(Class(_,_,methodDecls)) = methodDecls

getTypeFromMethodDecl :: MethodDecl -> Type
getTypeFromMethodDecl(MethodDecl(typeName,_,_,_)) = typeName

getArgsFromMethodDecl :: MethodDecl -> [(Type,String)]
getArgsFromMethodDecl(MethodDecl(_,_,args,_)) = args

isSubtypeOf :: Type -> Type -> Bool
isSubtypeOf x y = (typeUpperBound x y) == y

removeLocalVar :: String -> [(Type, String)] -> [(Type, String)]
removeLocalVar(varName) = (\varList ->
	foldr (\(aVarType,aVarName) list -> 
		if aVarName == varName then list
		else (aVarType,aVarName) : list) [] varList)

typeExists :: Type -> [Class] -> Bool
typeExists "bool" _ = True
typeExists "char" _ = True
typeExists "int" _ = True
typeExists "null" _ = True
typeExists "void" _ = True
typeExists "String" _ = True
typeExists "Object" _ = True
typeExists typeName classes = elem typeName $ map (\(Class(className,_,_)) -> className) classes

