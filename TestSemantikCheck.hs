import AbsSyn
import SemantikCheck

testProgramms =
	[
		[Class(Type "A",[],[])],
		[Class(Type "B",[FieldDecl(Type "int","x"),FieldDecl(Type "int","y")],
			[MethodDecl(Type "int","getX",[],Block([Return(LocalOrFieldVar("x"))])),
			MethodDecl(Type "int","getY",[],Block([Return(LocalOrFieldVar("y"))])),
			MethodDecl(Type "void","setX",[(Type "int","i")],StmtExprStmt(Assign(LocalOrFieldVar("x"),LocalOrFieldVar("i")))),
			MethodDecl(Type "void","setY",[(Type "int","i")],StmtExprStmt(Assign(InstVar(This,"y"),LocalOrFieldVar("i")))),
			MethodDecl(Type "int","addXY",[],Return(Binary("+",LocalOrFieldVar("x"),LocalOrFieldVar("y")))),
			MethodDecl(Type "int","add",[(Type "int","a"),(Type "int","b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))]),
		Class(Type "C",[FieldDecl(Type "B","b")],
			[MethodDecl(Type "int","getXFromB",[],Return(InstVar(LocalOrFieldVar("b"),"x"))),
			MethodDecl(Type "int","callGetYFromB",[],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("b"),"getY",[])))),
			MethodDecl(Type "void","callSetXFromB",[(Type "int","x")],StmtExprStmt(MethodCall(LocalOrFieldVar("b"),"setX",[LocalOrFieldVar("x")]))),
			MethodDecl(Type "int","callAddFromB",[(Type "int","x"),(Type "int","y")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("b"),"add",[LocalOrFieldVar("x"),LocalOrFieldVar("y")]))))]),
		Class(Type "D",[],
			[MethodDecl(Type "D","getThis",[],Return(This)),
			MethodDecl(Type "C","getNewC",[],Block([LocalVarDecl(Type "C","newC"),StmtExprStmt(Assign(LocalOrFieldVar("newC"),StmtExprExpr(New(Type "C",[])))),Return(LocalOrFieldVar("newC"))]))])],
		[Class(Type "E",[FieldDecl(Type "F","myF")],
			[MethodDecl(Type "E","getE",[],Return(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(LocalOrFieldVar("myF"),"getG",[])),"getE",[])))),
			MethodDecl(Type "F","getF",[],Return(LocalOrFieldVar("myF")))]),
		Class(Type "F",[FieldDecl(Type "G","myG")],
			[MethodDecl(Type "F","getF",[],Return(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(LocalOrFieldVar("myG"),"getE",[])),"getF",[])))),
			MethodDecl(Type "G","getG",[],Return(LocalOrFieldVar("myG")))]),
		Class(Type "G",[FieldDecl(Type "E","myE")],
			[MethodDecl(Type "E","getE",[],Return(LocalOrFieldVar("myE"))),
			MethodDecl(Type "G","getG",[],Return(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(LocalOrFieldVar("myE"),"getF",[])),"getG",[]))))])],
		[Class(Type "H",[],
			[MethodDecl(Type "int","fibonacciIter",[(Type "int","x")],Block([LocalVarDecl(Type "int","a"),StmtExprStmt(Assign(LocalOrFieldVar("a"),Integer(0))),LocalVarDecl(Type "int","b"),StmtExprStmt(Assign(LocalOrFieldVar("b"),Integer(1))),
				While(Binary(">",LocalOrFieldVar("x"),Integer(0)),Block([LocalVarDecl(Type "int","temp"),StmtExprStmt(Assign(LocalOrFieldVar("temp"),LocalOrFieldVar("b"))),StmtExprStmt(Assign(LocalOrFieldVar("b"),Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b")))),
					StmtExprStmt(Assign(LocalOrFieldVar("a"),LocalOrFieldVar("temp"))),StmtExprStmt(Assign(LocalOrFieldVar("x"),Unary("--",LocalOrFieldVar("x"))))])),Return(LocalOrFieldVar("b"))])),
			MethodDecl(Type "int","fibonacciRec",[(Type "int","x")],Block([If(Binary("||",Binary("<=",LocalOrFieldVar("x"),Integer(0)),Binary("==",LocalOrFieldVar("x"),Integer(1))),Return(Integer(1)),Nothing),
				Return(Binary("+",StmtExprExpr(MethodCall(This,"fibonacciRec",[Binary("-",LocalOrFieldVar("x"),Integer(2))])),StmtExprExpr(MethodCall(This,"fibonacciRec",[Binary("-",LocalOrFieldVar("x"),Integer(1))]))))]))])],
		[Class(Type "I",[],
			[MethodDecl(Type "int","ackermann",[(Type "int","n"),(Type "int","m")],If(Binary("==",LocalOrFieldVar("n"),Integer(0)),Return(Binary("+",LocalOrFieldVar("m"),Integer(1))),
				Just (If(Binary("==",LocalOrFieldVar("m"),Integer(0)),Return(StmtExprExpr(MethodCall(This,"ackermann",[Binary("-",LocalOrFieldVar("n"),Integer(1)),Integer(1)]))),
					Just (Return(StmtExprExpr(MethodCall(This,"ackermann",[Binary("-",LocalOrFieldVar("n"),Integer(1)),StmtExprExpr(MethodCall(This,"ackermann",[LocalOrFieldVar("n"),Binary("-",LocalOrFieldVar("m"),Integer(1))]))]))))))))])]
	]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (show (typecheckPrg prg) ++ "\n\n")) testProgramms
