import AbsSyn
import SemantikCheck

testProgramms =
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
		Class(Type "M",[],[],[Type "N"]),
		Class(Type "N",[FieldDecl(Type "char","i")],[],[])]
	]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (show (typecheckPrg prg) ++ "\n\n")) testProgramms
