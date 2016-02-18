module SemantikCheck where

import AbsSyn
import Data.Maybe

-- Ausdruck/Statement, Lokale Variablen, Sichtbare Klassen -> Getypter Ausdruck/Statement

typecheckExpr :: Expr -> [(Type, String)] -> [Class] -> Expr
typecheckExpr This localVars classes =
	let
		thisVar = getMaybeLocalVar "this" localVars
		thisClassType = getTypeFromLocalVar $ fromJustOrError thisVar "'this' var was not found."
	in
		TypedExpr(This,thisClassType)

typecheckExpr Super localVars classes =
	let
		thisVar = getMaybeLocalVar "this" localVars
		thisClassType = getTypeFromLocalVar $ fromJustOrError thisVar "'this' var was not found."
		thisClassDecl = fromJustOrError (getMaybeClass thisClassType classes) $ "class " ++ (getTypeNameFromType thisClassType) ++ " was not found when checking super expression"
		superClasses = getSuperClassTypesFromClass thisClassDecl
	in
		TypedExpr(Super,typeListUpperBound superClasses classes)

typecheckExpr (LocalOrFieldVar(varName)) localVars classes =
	let
		localVar = getMaybeLocalVar varName localVars
	in
		if isNothing localVar
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
		instanceClass = fromJustOrError (getMaybeClass instanceType classes) $ "class " ++ (getTypeNameFromType instanceType) ++ " was not found when checking inst var " ++ instVarName
		instVarFieldDecl = getMaybeFieldDecl instVarName $ getFieldDeclsFromClass instanceClass classes
		instVarType = getTypeFromFieldDecl $ fromJustOrError instVarFieldDecl $ "field declaration " ++ instVarName ++ " was not found in class " ++ (getTypeNameFromType instanceType)
	in
		TypedExpr((InstVar(instanceExpr, instVarName)),instVarType)

typecheckExpr (Unary(operator, expr)) localVars classes = 
	let
		typedExpr = typecheckExpr expr localVars classes
		typedExprType = getTypeFromExpr typedExpr
		operatorValid = elem operator ["+","-","++","--","!","~"]
		operandVaild = elem typedExprType [Type "bool",Type "int"]
	in
		if operatorValid
		then
			if and [operandVaild,or[not (operator == "!"),typedExprType == (Type "bool")]]
			then
				TypedExpr(Unary(operator,typedExpr),typedExprType)
			else
				error $ "operator " ++ operator ++ " cannot be applied to operand " ++ (show expr) ++ " of type " ++ (getTypeNameFromType typedExprType) 
		else
			error $ "Invalid unary operator" ++ operator

typecheckExpr (Binary(operator, expA, expB)) localVars classes = 
	let
		typedExprA = typecheckExpr expA localVars classes
		typedExprB = typecheckExpr expB localVars classes
		typeA = getTypeFromExpr typedExprA
		typeB = getTypeFromExpr typedExprB
		typeOfBinary = getTypeOfBinary operator typeA typeB classes
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
	if isNothing $ getMaybeLocalVar localVarName localVars
	then
		let
			typedFirstStmt = typecheckStmt (LocalVarDecl(localVarType,localVarName)) localVars classes
			newLocalVars = (localVarType, localVarName) : localVars
			typedBlockOfStmts = typecheckStmt (Block(stmts)) newLocalVars classes
			typedRestOfStmts = (\(TypedStmt(Block(typedStmts),_)) -> typedStmts) typedBlockOfStmts
			typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
		in
			TypedStmt(Block(typedFirstStmt : typedRestOfStmts),typeOfBlockOfStmts)
	else
		error $ "local var " ++ localVarName ++ " has already been declared"

typecheckStmt (Block(firstStmt : stmts)) localVars classes =
	let
		typedFirstStmt = typecheckStmt firstStmt localVars classes
		typeOfFirstStmt = getTypeFromStmt typedFirstStmt
		typedBlockOfStmts = typecheckStmt (Block(stmts)) localVars classes
		typedRestOfStmts = (\(TypedStmt(Block(typedStmts),_)) -> typedStmts) typedBlockOfStmts
		typeOfBlockOfStmts = getTypeFromStmt typedBlockOfStmts
		typeOfBlock = typeUpperBound typeOfFirstStmt typeOfBlockOfStmts classes
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
		if (getTypeFromExpr typedConditionExpr) == Type "bool"
		then
			TypedStmt(While(typedConditionExpr, typedStmt), stmtType)
		else
			error $ "while condition " ++ (show conditionExpr) ++ " evaluates to " ++ (getTypeNameFromType (getTypeFromExpr typedConditionExpr)) ++ " and not to boolean"

typecheckStmt (LocalVarDecl(varType, varName)) localVars classes =
	TypedStmt(LocalVarDecl(varType, varName),Type "void")

typecheckStmt (If(conditionExpr, stmtTrue, Nothing)) localVars classes =
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmtTrue = typecheckStmt stmtTrue localVars classes
		stmtTrueType = getTypeFromStmt typedStmtTrue
		upperBoundStmtType = typeUpperBound stmtTrueType (Type "void") classes
	in
		if (getTypeFromExpr typedConditionExpr) == Type "bool"
		then
			TypedStmt(If(typedConditionExpr, typedStmtTrue, Nothing),upperBoundStmtType)
		else
			error $ "if condition " ++ (show conditionExpr) ++ " evaluates to " ++ (getTypeNameFromType (getTypeFromExpr typedConditionExpr)) ++ " and not to boolean"

typecheckStmt (If(conditionExpr, stmtTrue, Just stmtFalse)) localVars classes =
	let
		typedConditionExpr = typecheckExpr conditionExpr localVars classes
		typedStmtTrue = typecheckStmt stmtTrue localVars classes
		stmtTrueType = getTypeFromStmt typedStmtTrue
		typedStmtFalse = typecheckStmt stmtFalse localVars classes
		stmtFalseType = getTypeFromStmt typedStmtFalse
		upperBoundStmtType = typeUpperBound stmtTrueType stmtFalseType classes
	in
		if (getTypeFromExpr typedConditionExpr) == Type "bool"
		then
			TypedStmt(If(typedConditionExpr, typedStmtTrue, (Just typedStmtFalse)),upperBoundStmtType)
		else
			error $ "if condition " ++ (show conditionExpr) ++ " evaluates to " ++ (getTypeNameFromType (getTypeFromExpr typedConditionExpr)) ++ " and not to boolean"

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
		if isSubtypeOf typeB typeA classes
		then
			TypedStmtExpr(Assign(typedExprA,typedExprB),typeA)
		else
			error $ "cannot assign " ++ (getTypeNameFromType typeB) ++ " " ++ (show expB) ++ " to " ++ (getTypeNameFromType typeA) ++ " " ++ (show expA)

typecheckStmtExpr (New(newType, constructorArguments)) localVars classes =
	let
		typedConstructorArguments = typecheckListOfExpr constructorArguments localVars classes
		newClass = fromJustOrError (getMaybeClass newType classes) $ "could not find class " ++ (getTypeNameFromType newType) ++ " when calling its constructor"
		constructorDecl = getConstructorFromClass newClass
		constructorArgs = getArgsFromMethodDecl constructorDecl
		declArgTypes = map getTypeFromLocalVar constructorArgs
		actualArgTypes = map getTypeFromExpr typedConstructorArguments
		argNumbersMatch = (length constructorArgs) == (length constructorArguments)
	in
		if argNumbersMatch
		then
			let
				argTypesMatch = and $ map (\(declType,actualType) -> isSubtypeOf actualType declType classes) $ zip declArgTypes actualArgTypes
			in
				if argTypesMatch
				then
					TypedStmtExpr(New(newType,typedConstructorArguments),newType)
				else
					error $ "argument type mismatch when calling constructor of class " ++ (getTypeNameFromType newType)
		else
			error $ "the constructor of class " ++ (getTypeNameFromType newType) ++ " requires " ++ (show (length constructorArgs)) ++ " argument(s), but " ++ (show (length constructorArguments)) ++ " were given"

typecheckStmtExpr (MethodCall(instanceExpr, methodName, arguments)) localVars classes =
	let
		typedArguments = typecheckListOfExpr arguments localVars classes
		typedInstance = typecheckExpr instanceExpr localVars classes
		instanceType = getTypeFromExpr typedInstance
		instanceClass = fromJustOrError (getMaybeClass instanceType classes) $ "could not find class " ++ (getTypeNameFromType instanceType) ++ " when calling " ++ methodName
		methodDecl = fromJustOrError (getMaybeMethodDecl methodName $ getMethodDeclsFromClass instanceClass classes) $ "could not find method declaration " ++ methodName ++ " in class " ++ (getTypeNameFromType instanceType)
		methodType = getTypeFromMethodDecl methodDecl 
		methodArgs = getArgsFromMethodDecl methodDecl
		declArgTypes = map getTypeFromLocalVar methodArgs
		actualArgTypes = map getTypeFromExpr typedArguments
		argNumbersMatch = (length methodArgs) == (length arguments)
	in
		if argNumbersMatch
		then
			let
				argTypesMatch = and $ map (\(declType,actualType) -> isSubtypeOf actualType declType classes) $ zip declArgTypes actualArgTypes
			in
				if argTypesMatch
				then
					TypedStmtExpr(MethodCall(typedInstance,methodName,typedArguments),methodType)
				else
					error $ "argument type mismatch when calling " ++ methodName ++ " of class " ++ (getTypeNameFromType instanceType)
		else
			error $ methodName ++ " of class " ++ (getTypeNameFromType instanceType) ++ " requires " ++ (show (length methodArgs)) ++ " argument(s), but " ++ (show (length arguments)) ++ " were given"
		

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
						if isSubtypeOf actualMehtodType methodType classes
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
		superTypesExists = and $ map (\superClassType -> typeExists superClassType classes) superClasses
	in
		if superTypesExists
		then
			let
				superTypesAreNonRecursive = not $ elem className $ expandListOfSuperClasses superClasses classes
			in
				if superTypesAreNonRecursive
				then
					let
						fieldDeclTypesExist = typecheckFieldDecls fieldDecls classes
					in
						if fieldDeclTypesExist
						then
							let
								typedMethods = map (\methodDecl -> typecheckMethod methodDecl className classes) methodDecls
							in
								Class(className, fieldDecls, typedMethods,superClasses)
						else
							error $ "One or multiple field declarations of class " ++ (getTypeNameFromType className) ++ " name an invalid type"
				else
					error $ "Class " ++ (getTypeNameFromType className) ++ " expands recursively"
		else
			error $ "class " ++ (getTypeNameFromType className) ++ " expands undeclared types"

typecheckPrg :: Prg -> Prg
typecheckPrg classes =
	map (\theClass -> typecheckClass theClass classes) classes

-- Hilfsfunktionen

typecheckListOfExpr :: [Expr] -> [(Type, String)] -> [Class] -> [Expr]
typecheckListOfExpr expressions localVars classes =
	map (\expr -> typecheckExpr expr localVars classes) expressions

typeListUpperBound :: [Type] -> [Class] -> Type
typeListUpperBound [] _ = Type "Object"
typeListUpperBound [a] _ = a
typeListUpperBound [a,b] classes = typeUpperBound a b classes
typeListUpperBound (a : rest) classes = typeUpperBound a (typeListUpperBound rest classes) classes

typeUpperBound :: Type -> Type -> [Class] -> Type
typeUpperBound (Type "void") x _ = x
typeUpperBound x (Type "void") _ = x
typeUpperBound (Type "null") x _ = Type "null"
typeUpperBound x (Type "null") _ = Type "null"
typeUpperBound (Type "bool") (Type "bool") _ = Type "bool"
typeUpperBound (Type "bool") (Type "int") _ = Type "int"
typeUpperBound (Type "char") (Type "char") _ = Type "char"
typeUpperBound (Type "int") (Type "bool") _ = Type "int"
typeUpperBound (Type "int") (Type "int") _ = Type "int"
typeUpperBound (Type "String") (Type "String") _ = Type "String"
typeUpperBound _ (Type "int") _ = Type "Object"
typeUpperBound (Type "int") _ _ = Type "Object"
typeUpperBound _ (Type "bool") _ = Type "Object"
typeUpperBound (Type "bool") _ _ = Type "Object"
typeUpperBound _ (Type "char") _ = Type "Object"
typeUpperBound (Type "char") _ _ = Type "Object"
typeUpperBound _ (Type "Object") _ = Type "Object"
typeUpperBound (Type "Object") _ _ = Type "Object"
typeUpperBound x y []
	| x == y = x
	|otherwise = Type "Object"
typeUpperBound x y classes =
	let
		xDecl = fromJustOrError (getMaybeClass x classes) $ "could not find class " ++ (getTypeNameFromType x)
		yDecl = fromJustOrError (getMaybeClass y classes) $ "could not find class " ++ (getTypeNameFromType y)
		xExpandsY = elem x $ expandListOfSuperClasses (getSuperClassTypesFromClass yDecl) classes
		yExpandsX = elem y $ expandListOfSuperClasses (getSuperClassTypesFromClass xDecl) classes
	in
		if xExpandsY
		then x
		else
			if yExpandsX
			then y
			else typeUpperBound x y []

getTypeOfBinary :: String -> Type -> Type -> [Class] -> Type
getTypeOfBinary "+" typeA typeB classes = typeUpperBound typeA typeB classes
getTypeOfBinary "-" typeA typeB classes = typeUpperBound typeA typeB classes
getTypeOfBinary "*" typeA typeB classes = typeUpperBound typeA typeB classes
getTypeOfBinary "/" typeA typeB classes = typeUpperBound typeA typeB classes
getTypeOfBinary "%" typeA typeB classes = typeUpperBound typeA typeB classes
getTypeOfBinary "&&" (Type "bool") (Type "bool") _ = Type "bool"
getTypeOfBinary "||" (Type "bool") (Type "bool") _ = Type "bool"
getTypeOfBinary "<" typeA typeB classes
	| (isSubtypeOf typeA typeB classes) || (isSubtypeOf typeB typeA classes) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary ">" typeA typeB classes
	| (isSubtypeOf typeA typeB classes) || (isSubtypeOf typeB typeA classes) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary "<=" typeA typeB classes
	| (isSubtypeOf typeA typeB classes) || (isSubtypeOf typeB typeA classes) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary ">=" typeA typeB classes
	| (isSubtypeOf typeA typeB classes) || (isSubtypeOf typeB typeA classes) = Type "bool"
	| otherwise = error $ "cannot compare " ++ (getTypeNameFromType typeA) ++ " and " ++ (getTypeNameFromType typeB)
getTypeOfBinary "==" typeA typeB classes
	| (isSubtypeOf typeA typeB classes) || (isSubtypeOf typeB typeA classes) = Type "bool"
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

getClassesIncludingSuperClasses :: [Type] -> [Class] -> [Class]
getClassesIncludingSuperClasses classNames classes = getClasses (expandListOfSuperClasses classNames classes) classes

getFieldDeclsFromClass :: Class -> [Class] -> [FieldDecl]
getFieldDeclsFromClass (Class(_,fieldDecls,_,[])) _ = fieldDecls
getFieldDeclsFromClass (Class(className,fieldDecls,_,superClasses)) classes = 
	let
		superClassDecls = getClassesIncludingSuperClasses superClasses classes
		superClassFieldDecls = concat $ map (\superClassDecl -> getFieldDeclsFromClass superClassDecl classes) superClassDecls
	in
		fieldDecls ++ superClassFieldDecls

getMethodDeclsFromClass :: Class -> [Class] -> [MethodDecl]
getMethodDeclsFromClass (Class(_,_,methodDecls,[])) _ = methodDecls
getMethodDeclsFromClass (Class(_,_,methodDecls,superClasses)) classes =
	let
		superClassDecls = getClassesIncludingSuperClasses superClasses classes
		superClassMethodDecls = concat $ map (\superClassDecl -> getMethodDeclsFromClass superClassDecl classes) superClassDecls
	in
		methodDecls ++ superClassMethodDecls

getConstructorFromClass :: Class -> MethodDecl
getConstructorFromClass (Class(classType,_,methodDecls,_)) =
	let
		className = getTypeNameFromType classType
		maybeSpecificConstructor = getMaybeMethodDecl className methodDecls
	in
		if isNothing maybeSpecificConstructor
		then
			MethodDecl(Type "void",className,[],Empty)
		else
			(\(Just constructor) -> constructor) maybeSpecificConstructor

getSuperClassTypesFromClass :: Class -> [Type]
getSuperClassTypesFromClass(Class(_,_,_,superClassTypes)) = superClassTypes

expandListOfSuperClasses :: [Type] -> [Class] -> [Type]
expandListOfSuperClasses classTypes classes = expandListOfSuperClassesHelper [] classTypes classes

expandListOfSuperClassesHelper:: [Type] -> [Type] -> [Class] -> [Type]
expandListOfSuperClassesHelper baseTypes [] classes =
	baseTypes
expandListOfSuperClassesHelper baseTypes classTypes classes =
	let
		superTypes = concat $ map getSuperClassTypesFromClass $ getClasses classTypes classes
		baseTypeConatainedInSuperTypes = any (\baseType -> elem baseType superTypes) baseTypes
	in
		if baseTypeConatainedInSuperTypes
		then
			error $ "recursive derivation detected in class " ++ (getTypeNameFromType $ head $ foldr (\baseType list -> if elem baseType superTypes then baseType : list else list) [] baseTypes)
		else
			expandListOfSuperClassesHelper (baseTypes ++ classTypes) superTypes classes

getTypeFromMethodDecl :: MethodDecl -> Type
getTypeFromMethodDecl(MethodDecl(typeName,_,_,_)) = typeName

getArgsFromMethodDecl :: MethodDecl -> [(Type,String)]
getArgsFromMethodDecl(MethodDecl(_,_,args,_)) = args

isSubtypeOf :: Type -> Type -> [Class] -> Bool
isSubtypeOf x y classes = (typeUpperBound x y classes) == y

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

