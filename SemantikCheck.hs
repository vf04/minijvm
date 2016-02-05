module SemantikCheck where

import AbsSyn

-- Ausdruck/Statement, Lokale Variablen, Sichtbare Klassen -> Getypter Ausdruck/Statement

typecheckExpr :: Expr -> [(Type, String)] -> [Class] -> Expr
typecheckExpr This localVars classes =
	let
		thisVar = getMaybeLocalVar "this" localVars
		thisClassType = getTypeFromLocalVar $ fromJustOrError thisVar "'this' var was not found."
	in
		TypedExpr(This,thisClassType)

typecheckExpr (LocalOrFieldVar(varName)) localVars classes =
	let
		localVar = getMaybeLocalVar varName localVars
	in
		if localVar == Nothing
		then
			let
				thisVar = getMaybeLocalVar "this" localVars
				thisClassType = getTypeFromLocalVar $ fromJustOrError thisVar "'this' var was not found. Cannot evaluate field vars."
				thisClass = getMaybeClass thisClassType classes
				fieldVarDecl = getMaybeFieldDecl varName $ getFieldDeclsFromClass (fromJustOrError thisClass $ "Class " ++ (getTypeNameFromType thisClassType) ++ " was not found.") classes
				fieldVarType = getTypeFromFieldDecl $ fromJustOrError fieldVarDecl $ "var '" ++ varName ++ "' is neither a local var nor a field var in " ++ (getTypeNameFromType thisClassType)
			in
			TypedExpr(LocalOrFieldVar(varName),fieldVarType)
		else
			let
				varType = getTypeFromLocalVar $ fromJustOrError localVar $ "could not retrieve var type from local var " ++ varName
			in
				TypedExpr(LocalOrFieldVar(varName),varType)

typecheckExpr (InstVar(expr, instVarName)) localVars classes =
	let
		instanceExpr = typecheckExpr expr localVars classes
		instanceType = getTypeFromExpr instanceExpr
		instanceClass = getMaybeClass instanceType classes
		instVarFieldDecl = getMaybeFieldDecl instVarName $ getFieldDeclsFromClass (fromJustOrError instanceClass $ "class " ++ (getTypeNameFromType instanceType) ++ " was not found when checking inst var " ++ instVarName) classes
		instVarType = getTypeFromFieldDecl $ fromJustOrError instVarFieldDecl $ "field declaration " ++ instVarName ++ " was not found in class " ++ (getTypeNameFromType instanceType)
	in
		TypedExpr((InstVar(instanceExpr, instVarName)),instVarType)

typecheckExpr (Unary(operator, expr)) localVars classes = 
	let typedExpr = typecheckExpr expr localVars classes
	in TypedExpr(Unary(operator,typedExpr),getTypeFromExpr(typedExpr))

typecheckExpr (Binary(operator, expA, expB)) localVars classes = 
	let
		typedExprA = typecheckExpr expA localVars classes
		typedExprB = typecheckExpr expB localVars classes
		typeA = getTypeFromExpr typedExprA
		typeB = getTypeFromExpr typedExprB
		typeOfBinary = getTypeOfBinary operator typeA typeB
	in TypedExpr(Binary(operator,typedExprA,typedExprB),typeOfBinary)

typecheckExpr (Integer(i)) _ _ = TypedExpr(Integer(i),Type "int")
typecheckExpr (Bool(b)) _ _ = TypedExpr(Bool(b),Type "bool")
typecheckExpr (Char(c)) _ _ = TypedExpr(Char(c),Type "char")
typecheckExpr (String(s)) _ _ = TypedExpr(String(s),Type "String")
typecheckExpr (Jnull) _ _ = TypedExpr(Jnull,Type "null")

typecheckExpr (StmtExprExpr(stmtExpr)) localVars classes =
	let
		typedStmtExpr = typecheckStmtExpr stmtExpr localVars classes
		typeOfStmtExpr = getTypeFromStmtExpr typedStmtExpr
	in
		TypedExpr(StmtExprExpr(typedStmtExpr),typeOfStmtExpr)

typecheckStmt :: Stmt -> [(Type, String)] -> [Class] -> Stmt
typecheckStmt (Block((LocalVarDecl(localVarType, localVarName)) : stmts)) localVars classes =
	let
		typedFirstStmt = typecheckStmt (LocalVarDecl(localVarType,localVarName)) localVars classes
		oldLocalVars = removeLocalVar localVarName localVars
		newLocalVars = (localVarType, localVarName) : oldLocalVars
		typedBlockOfStmts = typecheckStmt (Block(stmts)) newLocalVars classes
		typedRestOfStmts = (\(TypedStmt(Block(typedStmts),_)) -> typedStmts) typedBlockOfStmts
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
	in
		TypedStmt(Block(typedFirstStmt : typedRestOfStmts),typeOfBlockOfStmts)

typecheckStmt (Block(firstStmt : stmts)) localVars classes =
	let
		typedFirstStmt = typecheckStmt firstStmt localVars classes
		typeOfFirstStmt = getTypeFromStmt typedFirstStmt
		typedBlockOfStmts = typecheckStmt (Block(stmts)) localVars classes
		typedRestOfStmts = (\(TypedStmt(Block(typedStmts),_)) -> typedStmts) typedBlockOfStmts
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
		typeOfBlock = typeUpperBound typeOfFirstStmt typeOfBlockOfStmts
	in
		TypedStmt(Block(typedFirstStmt : typedRestOfStmts),typeOfBlock)

typecheckStmt (Block([])) _ _ = TypedStmt(Block([]),Type "void")

typecheckStmt (Return(Just expr)) localVars classes =
	let
		typedExpr = typecheckExpr expr localVars classes
		exprType = getTypeFromExpr typedExpr
	in
		TypedStmt(Return(Just typedExpr),exprType)
typecheckStmt (Return(Nothing)) localVars classes =
		TypedStmt(Return(Nothing),Type "void")

typecheckStmt (While(conditionExpr, stmt)) localVars classes =
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmt = typecheckStmt stmt localVars classes
		stmtType = getTypeFromStmt typedStmt
	in
		TypedStmt(While(typedConditionExpr, typedStmt), stmtType)

typecheckStmt (LocalVarDecl(varType, varName)) localVars classes =
	TypedStmt(LocalVarDecl(varType, varName),Type "void")

typecheckStmt (If(conditionExpr, stmtTrue, Nothing)) localVars classes =
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmtTrue = typecheckStmt stmtTrue localVars classes
		stmtTrueType = getTypeFromStmt typedStmtTrue
		upperBoundStmtType = typeUpperBound stmtTrueType (Type "void")
	in
		TypedStmt(If(typedConditionExpr, typedStmtTrue, Nothing),upperBoundStmtType)

typecheckStmt (If(conditionExpr, stmtTrue, Just stmtFalse)) localVars classes =
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmtTrue = typecheckStmt stmtTrue localVars classes
		stmtTrueType = getTypeFromStmt typedStmtTrue
		typedStmtFalse = typecheckStmt stmtFalse localVars classes
		stmtFalseType = getTypeFromStmt typedStmtFalse
		upperBoundStmtType = typeUpperBound stmtTrueType stmtFalseType
	in
		TypedStmt(If(typedConditionExpr, typedStmtTrue, (Just typedStmtFalse)),upperBoundStmtType)

typecheckStmt Empty localVars classes =
		TypedStmt(Empty,Type "void")

typecheckStmt (StmtExprStmt(stmtExpr)) localVars classes =
	let
		typedStmtExpr = typecheckStmtExpr stmtExpr localVars classes
	in
		TypedStmt(StmtExprStmt(typedStmtExpr),Type "void")


typecheckStmtExpr :: StmtExpr -> [(Type, String)] -> [Class] -> StmtExpr
typecheckStmtExpr (Assign(expA, expB)) localVars classes =
	let
		typedExprA = typecheckExpr expA localVars classes
		typedExprB = typecheckExpr expB localVars classes
		typeA = getTypeFromExpr typedExprA
		typeB = getTypeFromExpr typedExprB
	in
		if isSubtypeOf typeB typeA
		then
			TypedStmtExpr(Assign(typedExprA,typedExprB),typeA)
		else
			error $ "cannot assign " ++ (getTypeNameFromType typeB) ++ " " ++ (show expB) ++ " to " ++ (getTypeNameFromType typeA) ++ " " ++ (show expA)

typecheckStmtExpr (New(newType, constructorArguments)) localVars classes =
	let
		typedConstructorArguments = typecheckListOfExpr constructorArguments localVars classes
	in
		TypedStmtExpr(New(newType,typedConstructorArguments),newType)

typecheckStmtExpr (MethodCall(instanceExpr, methodName, arguments)) localVars classes =
	let
		typedArguments = typecheckListOfExpr arguments localVars classes
		typedInstance = typecheckExpr instanceExpr localVars classes
		instanceType = getTypeFromExpr typedInstance
		instanceClass = getMaybeClass instanceType classes
		methodDecl = getMaybeMethodDecl methodName $ getMethodDeclsFromClass (fromJustOrError instanceClass $ "could not find class " ++ (getTypeNameFromType instanceType) ++ " when calling " ++ methodName) classes
		methodType = getTypeFromMethodDecl $ fromJustOrError methodDecl $ "could not find method declaration " ++ methodName ++ " in class " ++ (getTypeNameFromType instanceType)
		methodArgs = getArgsFromMethodDecl $ fromJustOrError methodDecl $ "could not find method declaration " ++ methodName ++ " in class " ++ (getTypeNameFromType instanceType)
		declArgTypes = map getTypeFromLocalVar methodArgs
		actualArgTypes = map getTypeFromExpr typedArguments
		argTypesMatch = and $ map (\(declType,actualType) -> isSubtypeOf actualType declType) $ zip declArgTypes actualArgTypes
	in
		if argTypesMatch
		then
			TypedStmtExpr(MethodCall(typedInstance,methodName,typedArguments),methodType)
		else
			error $ "argument type mismatch when calling " ++ methodName ++ " in class " ++ (getTypeNameFromType instanceType)

typecheckFieldDecls :: [FieldDecl] -> [Class] -> Bool
typecheckFieldDecls fieldDecls classes = and $ map (\(FieldDecl(fieldType,_)) -> typeExists fieldType classes) fieldDecls

typecheckMethod :: MethodDecl -> Type -> [Class] -> MethodDecl
typecheckMethod (MethodDecl(methodType, methodName, arguments, stmt)) thisType classes =
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
						localVars = ((thisType,"this") : arguments)
						typedStmt = typecheckStmt stmt localVars classes
						actualMehtodType = getTypeFromStmt typedStmt
					in
						if isSubtypeOf actualMehtodType methodType
						then
							MethodDecl(methodType, methodName, arguments, typedStmt)
						else
							error $ "evaluated return type " ++ (getTypeNameFromType actualMehtodType) ++ " does not match the given return type " ++ (getTypeNameFromType methodType) ++ " of method " ++ methodName ++ " in class " ++ (getTypeNameFromType thisType) 
				else
					error $ "One or multiple arguments of method " ++ methodName ++ " in class " ++ (getTypeNameFromType thisType) ++ " name an invalid type"
		else
			error $ "return type " ++ (getTypeNameFromType methodType) ++ " of method " ++ methodName ++ " in class " ++ (getTypeNameFromType thisType) ++ "does not exist"

typecheckClass :: Class -> [Class] -> Class
typecheckClass (Class(className, fieldDecls, methodDecls,superClasses)) classes =
	let
		fieldDeclTypesExist = and $ map (\(FieldDecl(fieldType,superClasses)) -> typeExists fieldType classes) fieldDecls
	in
		if fieldDeclTypesExist
		then
			let
				typedMethods = map (\methodDecl -> typecheckMethod methodDecl className classes) methodDecls
			in
				Class(className, fieldDecls, typedMethods,superClasses)
		else
			error $ "One or multiple field declarations of class " ++ (getTypeNameFromType className) ++ " name an invalid type"

typecheckPrg :: Prg -> Prg
typecheckPrg classes =
	map (\theClass -> typecheckClass theClass classes) classes

-- Hilfsfunktionen

typecheckListOfExpr :: [Expr] -> [(Type, String)] -> [Class] -> [Expr]
typecheckListOfExpr expressions localVars classes =
	map (\expr -> typecheckExpr expr localVars classes) expressions

typeUpperBound :: Type -> Type -> Type
typeUpperBound (Type "void") x = x
typeUpperBound x (Type "void") = x
typeUpperBound (Type "null") x = Type "null"
typeUpperBound x (Type "null") = Type "null"
typeUpperBound (Type "bool") (Type "bool") = Type "bool"
typeUpperBound (Type "bool") (Type "int") = Type "int"
typeUpperBound (Type "char") (Type "char") = Type "char"
typeUpperBound (Type "int") (Type "bool") = Type "int"
typeUpperBound (Type "int") (Type "int") = Type "int"
typeUpperBound (Type "String") (Type "String") = Type "String"
typeUpperBound x y
	| x == y = x
	|otherwise = Type "Object"

getTypeOfBinary :: String -> Type -> Type -> Type
getTypeOfBinary "+" typeA typeB = typeUpperBound typeA typeB
getTypeOfBinary "-" typeA typeB = typeUpperBound typeA typeB
getTypeOfBinary "*" typeA typeB = typeUpperBound typeA typeB
getTypeOfBinary "/" typeA typeB = typeUpperBound typeA typeB
getTypeOfBinary "%" typeA typeB = typeUpperBound typeA typeB
getTypeOfBinary "&&" (Type "bool") (Type "bool") = Type "bool"
getTypeOfBinary "||" (Type "bool") (Type "bool") = Type "bool"
getTypeOfBinary "<" typeA typeB
	| (isSubtypeOf typeA typeB) || (isSubtypeOf typeB typeA) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary ">" typeA typeB
	| (isSubtypeOf typeA typeB) || (isSubtypeOf typeB typeA) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary "<=" typeA typeB
	| (isSubtypeOf typeA typeB) || (isSubtypeOf typeB typeA) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary ">=" typeA typeB
	| (isSubtypeOf typeA typeB) || (isSubtypeOf typeB typeA) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary "==" typeA typeB
	| (isSubtypeOf typeA typeB) || (isSubtypeOf typeB typeA) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)

getMaybeClass :: Type -> [Class] -> Maybe Class
getMaybeClass _ [] = Nothing
getMaybeClass className (Class(name, fieldDecl, methodDecl, superClasses) : classes)
	| className == name = Just (Class(name, fieldDecl, methodDecl, superClasses))
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
	
fromJustOrError :: Maybe a -> String -> a
fromJustOrError (Just(a)) _ = a
fromJustOrError Nothing errorString = error errorString
	
getTypeFromLocalVar :: (Type, String) -> Type
getTypeFromLocalVar(typeName,_) = typeName

getTypeFromFieldDecl :: FieldDecl -> Type
getTypeFromFieldDecl(FieldDecl(typeName,_)) = typeName

getTypeFromClass :: Class -> Type
getTypeFromClass(Class(classType,_,_,_)) = classType

getClasses :: [Type] -> [Class] -> [Class]
getClasses classNames classes =
	map (\className -> fromJustOrError (getMaybeClass className classes) $ "class " ++ (getTypeNameFromType className) ++ " was not found") classNames

getFieldDeclsFromClass :: Class -> [Class] -> [FieldDecl]
getFieldDeclsFromClass (Class(_,fieldDecls,_,[])) _ = fieldDecls
getFieldDeclsFromClass (Class(className,fieldDecls,_,superClasses)) classes = 
	let
		superClassDecls = getClasses superClasses classes
		superClassFieldDecls = concat $ map (\superClassDecl -> getFieldDeclsFromClass superClassDecl []) superClassDecls
	in
		fieldDecls ++ superClassFieldDecls

getMethodDeclsFromClass :: Class -> [Class] -> [MethodDecl]
getMethodDeclsFromClass (Class(_,_,methodDecls,[])) _ = methodDecls
getMethodDeclsFromClass (Class(_,_,methodDecls,superClasses)) classes =
	let
		superClassDecls = getClasses superClasses classes
		superClassMethodDecls = concat $ map (\superClassDecl -> getMethodDeclsFromClass superClassDecl []) superClassDecls
	in
		methodDecls ++ superClassMethodDecls

getTypeFromMethodDecl :: MethodDecl -> Type
getTypeFromMethodDecl(MethodDecl(typeName,_,_,_)) = typeName

getArgsFromMethodDecl :: MethodDecl -> [(Type,String)]
getArgsFromMethodDecl(MethodDecl(_,_,args,_)) = args

isSubtypeOf :: Type -> Type -> Bool
isSubtypeOf x y = (typeUpperBound x y) == y

removeLocalVar :: String -> [(Type, String)] -> [(Type, String)]
removeLocalVar varName varList =
	foldr (\(aVarType,aVarName) list -> 
		if aVarName == varName then list
		else (aVarType,aVarName) : list) [] varList

getTypeNameFromType :: Type -> String
getTypeNameFromType (Type(typeName)) = typeName

typeExists :: Type -> [Class] -> Bool
typeExists (Type "bool") _ = True
typeExists (Type "char") _ = True
typeExists (Type "int") _ = True
typeExists (Type "null") _ = True
typeExists (Type "void") _ = True
typeExists (Type "String") _ = True
typeExists (Type "Object") _ = True
typeExists typeName classes = elem typeName $ map getTypeFromClass classes

