import AbsSyn
import SemantikCheck
import Data.List

testPrograms =
	[
		[Class(Type "A",[],[],[])],
		[Class(Type "B",[FieldDecl(Type "int","x"),FieldDecl(Type "int","y")],
			[MethodDecl(Type "int","getX",[],Block([Return(Just(LocalOrFieldVar("x")))])),
			MethodDecl(Type "int","getY",[],Block([Return(Just(LocalOrFieldVar("y")))])),
			MethodDecl(Type "void","setX",[(Type "int","i")],StmtExprStmt(Assign(LocalOrFieldVar("x"),LocalOrFieldVar("i")))),
			MethodDecl(Type "void","setY",[(Type "int","i")],StmtExprStmt(Assign(InstVar(This,"y"),LocalOrFieldVar("i")))),
			MethodDecl(Type "int","addXY",[],Return(Just(Binary("+",LocalOrFieldVar("x"),LocalOrFieldVar("y"))))),
			MethodDecl(Type "int","add",[(Type "int","a"),(Type "int","b")],Return(Just(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b")))))],[]),
		Class(Type "C",[FieldDecl(Type "B","b")],
			[MethodDecl(Type "int","getXFromB",[],Return(Just(InstVar(LocalOrFieldVar("b"),"x")))),
			MethodDecl(Type "int","callGetYFromB",[],Return(Just(StmtExprExpr(MethodCall(LocalOrFieldVar("b"),"getY",[]))))),
			MethodDecl(Type "void","callSetXFromB",[(Type "int","x")],StmtExprStmt(MethodCall(LocalOrFieldVar("b"),"setX",[LocalOrFieldVar("x")]))),
			MethodDecl(Type "int","callAddFromB",[(Type "int","x"),(Type "int","y")],Return(Just(StmtExprExpr(MethodCall(LocalOrFieldVar("b"),"add",[LocalOrFieldVar("x"),LocalOrFieldVar("y")])))))],[]),
		Class(Type "D",[],
			[MethodDecl(Type "D","getThis",[],Return(Just(This))),
			MethodDecl(Type "C","getNewC",[],Block([LocalVarDecl(Type "C","newC"),StmtExprStmt(Assign(LocalOrFieldVar("newC"),StmtExprExpr(New(Type "C",[])))),Return(Just(LocalOrFieldVar("newC")))]))],[])],
		[Class(Type "E",[FieldDecl(Type "F","myF")],
			[MethodDecl(Type "E","getE",[],Return(Just(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(LocalOrFieldVar("myF"),"getG",[])),"getE",[]))))),
			MethodDecl(Type "F","getF",[],Return(Just(LocalOrFieldVar("myF"))))],[]),
		Class(Type "F",[FieldDecl(Type "G","myG")],
			[MethodDecl(Type "F","getF",[],Return(Just(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(LocalOrFieldVar("myG"),"getE",[])),"getF",[]))))),
			MethodDecl(Type "G","getG",[],Return(Just(LocalOrFieldVar("myG"))))],[]),
		Class(Type "G",[FieldDecl(Type "E","myE")],
			[MethodDecl(Type "E","getE",[],Return(Just(LocalOrFieldVar("myE")))),
			MethodDecl(Type "G","getG",[],Return(Just(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(LocalOrFieldVar("myE"),"getF",[])),"getG",[])))))],[])],
		[Class(Type "H",[],
			[MethodDecl(Type "int","fibonacciIter",[(Type "int","x")],Block([LocalVarDecl(Type "int","a"),StmtExprStmt(Assign(LocalOrFieldVar("a"),Integer(0))),LocalVarDecl(Type "int","b"),StmtExprStmt(Assign(LocalOrFieldVar("b"),Integer(1))),
				While(Binary(">",LocalOrFieldVar("x"),Integer(0)),Block([LocalVarDecl(Type "int","temp"),StmtExprStmt(Assign(LocalOrFieldVar("temp"),LocalOrFieldVar("b"))),StmtExprStmt(Assign(LocalOrFieldVar("b"),Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b")))),
					StmtExprStmt(Assign(LocalOrFieldVar("a"),LocalOrFieldVar("temp"))),StmtExprStmt(Assign(LocalOrFieldVar("x"),Unary("--",LocalOrFieldVar("x"))))])),Return(Just(LocalOrFieldVar("b")))])),
			MethodDecl(Type "int","fibonacciRec",[(Type "int","x")],Block([If(Binary("||",Binary("<=",LocalOrFieldVar("x"),Integer(0)),Binary("==",LocalOrFieldVar("x"),Integer(1))),Return(Just(Integer(1))),Nothing),
				Return(Just(Binary("+",StmtExprExpr(MethodCall(This,"fibonacciRec",[Binary("-",LocalOrFieldVar("x"),Integer(2))])),StmtExprExpr(MethodCall(This,"fibonacciRec",[Binary("-",LocalOrFieldVar("x"),Integer(1))])))))]))],[])],
		[Class(Type "I",[],
			[MethodDecl(Type "int","ackermann",[(Type "int","n"),(Type "int","m")],If(Binary("==",LocalOrFieldVar("n"),Integer(0)),Return(Just(Binary("+",LocalOrFieldVar("m"),Integer(1)))),
				Just (If(Binary("==",LocalOrFieldVar("m"),Integer(0)),Return(Just(StmtExprExpr(MethodCall(This,"ackermann",[Binary("-",LocalOrFieldVar("n"),Integer(1)),Integer(1)])))),
					Just (Return(Just(StmtExprExpr(MethodCall(This,"ackermann",[Binary("-",LocalOrFieldVar("n"),Integer(1)),StmtExprExpr(MethodCall(This,"ackermann",[LocalOrFieldVar("n"),Binary("-",LocalOrFieldVar("m"),Integer(1))]))])))))))))],[])],
		[Class(Type "J",[],
			[MethodDecl(Type "int","getX",[],Return(Just(LocalOrFieldVar("x")))),
			MethodDecl(Type "int","callAddYToX",[(Type "int","y")],Return(Just(StmtExprExpr(MethodCall(This,"addYToX",[LocalOrFieldVar("y")])))))],[Type "K"]),
		Class(Type "K",[FieldDecl(Type "int","x")],
			[MethodDecl(Type "int","addYToX",[(Type "int","y")],Return(Just(Binary("+",LocalOrFieldVar("x"),LocalOrFieldVar("y")))))],[])],
		[Class(Type "L",[FieldDecl(Type "int","i")],
			[MethodDecl(Type "int","getI",[],Return(Just(LocalOrFieldVar("i")))),
			MethodDecl(Type "char","getSupersI",[],Return(Just(InstVar(Super,"i"))))],[Type "M"]),
		Class(Type "M",[],[MethodDecl(Type "N","getNewM",[],Block([LocalVarDecl(Type "N","myN"),StmtExprStmt(Assign(LocalOrFieldVar("myN"),StmtExprExpr(New(Type "M",[])))),Return(Just(LocalOrFieldVar("myN")))]))],[Type "N"]),
		Class(Type "N",[FieldDecl(Type "char","i")],[],[])],
		[Class(Type "O",[FieldDecl(Type "int","x")],
			[MethodDecl(Type "void","O",[(Type "int","x")],StmtExprStmt(Assign(InstVar(This,"x"),LocalOrFieldVar("x")))),MethodDecl(Type "O","test",[],Block([LocalVarDecl(Type "int","a"),
				Block([LocalVarDecl(Type "int","i"),StmtExprStmt(Assign(LocalOrFieldVar("i"),Integer(40))),StmtExprStmt(Assign(LocalOrFieldVar("a"),LocalOrFieldVar("i")))]),
				Block([LocalVarDecl(Type "int","i"),StmtExprStmt(Assign(LocalOrFieldVar("i"),Binary("+",LocalOrFieldVar("a"),Integer(2)))),Return(Just(StmtExprExpr(New(Type "O",[LocalOrFieldVar("i")]))))])]))],[])]
	]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (formatPrg (typecheckPrg prg) ++ "\n")) testPrograms

formatPrg :: Prg -> String
formatPrg classes = concat $ map formatClass classes

formatClass :: Class -> String
formatClass (Class(Type className,fieldDecls,methodDecls,superClasses)) = "Class (Type \"" ++ className ++ "\",\n[" ++ (showInLines fieldDecls) ++ "],\n[" ++ (formatMethodDecls methodDecls) ++ "],\n" ++ (show superClasses) ++ ")\n\n"

formatMethodDecls :: [MethodDecl] -> String
formatMethodDecls methodDecls = concat $ intersperse ",\n" $ map formatMethodDecl methodDecls

formatMethodDecl :: MethodDecl -> String
formatMethodDecl (MethodDecl(Type typeName,methodName,args,stmt)) = "MethodDecl (Type \"" ++ typeName ++ "\",\"" ++ methodName ++ "\"," ++ (show args) ++ ",\n" ++ (show stmt) ++ ")"

showInLines :: Show a => [a] -> String
showInLines list = concat $ intersperse ",\n" $ map show list

-- error tests

errorUndeclaredVar :: IO()
errorUndeclaredVar = print $ typecheckPrg [Class(Type "UndeclaredVar",[],[MethodDecl(Type "int","getX",[],Return(Just(LocalOrFieldVar("x"))))],[])]

errorUndeclaredInstVar :: IO()
errorUndeclaredInstVar = print $ typecheckPrg [Class(Type "A",[],[],[]),Class(Type "UndeclaredInstVar",[],[MethodDecl(Type "int","getYFromX",[(Type "A","x")],Return(Just(InstVar(LocalOrFieldVar("x"),"y"))))],[])]

errorInvalidUnary :: IO()
errorInvalidUnary = print $ typecheckPrg [Class(Type "InvalidUnary",[],[MethodDecl(Type "void","doSomething",[],Block([LocalVarDecl(Type "String","a"),StmtExprStmt(Assign(LocalOrFieldVar("a"),Unary("++",String("test"))))]))],[])]

errorInvalidUnary2 :: IO()
errorInvalidUnary2 = print $ typecheckPrg [Class(Type "InvalidUnary2",[],[MethodDecl(Type "void","doSomething",[],Block([LocalVarDecl(Type "int","i"),StmtExprStmt(Assign(LocalOrFieldVar("i"),Unary("!",LocalOrFieldVar("i"))))]))],[])]

errorInvalidBinary :: IO()
errorInvalidBinary = print $ typecheckPrg [Class(Type "InvalidBinary",[],[MethodDecl(Type "void","doSomething",[],Block([LocalVarDecl(Type "int","i"),StmtExprStmt(Assign(LocalOrFieldVar("i"),Binary("+",Char('c'),Bool(False))))]))],[])]

errorInvalidBinary2 :: IO()
errorInvalidBinary2 = print $ typecheckPrg [Class(Type "InvalidBinary2",[],[MethodDecl(Type "void","doSomething",[],Block([LocalVarDecl(Type "bool","b"),StmtExprStmt(Assign(LocalOrFieldVar("b"),Binary("==",Char('c'),Bool(False))))]))],[])]

errorDuplicateLocalVar :: IO()
errorDuplicateLocalVar = print $ typecheckPrg [Class(Type "DuplicateLocalVar",[],[MethodDecl(Type "void","errorMethod",[],Block([LocalVarDecl(Type "int","x"),LocalVarDecl(Type "int","x")]))],[])]

errorDuplicateLocalVar2 :: IO()
errorDuplicateLocalVar2 = print $ typecheckPrg [Class(Type "DuplicateLocalVar2",[],[MethodDecl(Type "void","errorMethod",[(Type "int","x")],Block([LocalVarDecl(Type "int","x")]))],[])]

errorInvalidCondition :: IO()
errorInvalidCondition = print $ typecheckPrg [Class(Type "InvalidCondition",[],[MethodDecl(Type "int","doSomething",[(Type "int","i")],If(LocalOrFieldVar("i"),Return(Just(Integer(42))),Just(Return(Just(Integer(0))))))],[])]

errorInvalidAssign :: IO()
errorInvalidAssign = print $ typecheckPrg [Class(Type "InvalidAssign",[FieldDecl(Type "char","c")],[MethodDecl(Type "void","setI",[(Type "String","s")],StmtExprStmt(Assign(LocalOrFieldVar("c"),LocalOrFieldVar("s"))))],[])]

errorUndeclaredMethod :: IO()
errorUndeclaredMethod = print $ typecheckPrg [Class(Type "UndeclaredMethod",[],[MethodDecl(Type "void","callSomething",[],StmtExprStmt(MethodCall(This,"undeclaredMethod",[])))],[])]

errorMissingMethodArgs :: IO()
errorMissingMethodArgs = print $ typecheckPrg [Class(Type "MissingMethodArgs",[FieldDecl(Type "int","x")],[MethodDecl(Type "void","callSomething",[],StmtExprStmt(MethodCall(This,"setX",[]))),MethodDecl(Type "void","setX",[(Type "int","value")],StmtExprStmt(Assign(LocalOrFieldVar("x"),LocalOrFieldVar("value"))))],[])]

errorInvalidMethodArgs :: IO()
errorInvalidMethodArgs = print $ typecheckPrg [Class(Type "InvalidMethodArgs",[FieldDecl(Type "int","x")],[MethodDecl(Type "void","callSomething",[],StmtExprStmt(MethodCall(This,"setX",[This]))),MethodDecl(Type "void","setX",[(Type "int","value")],StmtExprStmt(Assign(LocalOrFieldVar("x"),LocalOrFieldVar("value"))))],[])]

errorInvalidNew :: IO()
errorInvalidNew = print $ typecheckPrg [Class(Type "InvalidNew",[],[MethodDecl(Type "void","InvalidNew",[(Type "int","i")],Empty),MethodDecl(Type "InvalidNew","newInstance",[],Return(Just(StmtExprExpr(New(Type "InvalidNew",[])))))],[])]

errorInvalidNew2 :: IO()
errorInvalidNew2 = print $ typecheckPrg [Class(Type "InvalidNew2",[],[MethodDecl(Type "void","InvalidNew2",[(Type "bool","b")],Empty),MethodDecl(Type "InvalidNew2","newInstance",[],Return(Just(StmtExprExpr(New(Type "InvalidNew2",[Integer(2)])))))],[])]

errorInvalidFieldDecls :: IO()
errorInvalidFieldDecls = print $ typecheckPrg [Class(Type "InvalidFieldDecls",[FieldDecl(Type "A","a")],[],[])]

errorInvalidReturnType :: IO()
errorInvalidReturnType = print $ typecheckPrg [Class(Type "InvalidReturnType",[],[MethodDecl(Type "void","addXY",[(Type "int","x"),(Type "int","y")],Return(Just(Binary("+",LocalOrFieldVar("x"),LocalOrFieldVar("y")))))],[])]

errorInvalidDerivation ::IO()
errorInvalidDerivation = print $ typecheckPrg [Class(Type "A",[],[],[Type "B"]),Class(Type "B",[],[],[Type "C"])]

errorInvalidDerivation2 ::IO()
errorInvalidDerivation2 = print $ typecheckPrg [Class(Type "A",[],[],[Type "B"]),Class(Type "B",[],[],[Type "C"]),Class(Type "C",[],[],[Type "A"])]
