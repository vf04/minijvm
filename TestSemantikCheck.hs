import AbsSyn
import SemantikCheck

testProgramms = [[Class(Type "Leer",[],[])],
                 [Class(Type "A",[FieldDecl(Type "int","x")],[])],
                 [Class(Type "B",[FieldDecl(Type "int","x")],[MethodDecl(Type "int","getX",[],Block([Return(LocalOrFieldVar("x"))]))])],
                 [Class(Type "C",[FieldDecl(Type "bool","b")],[]),
                  Class(Type "D",[FieldDecl(Type "C","c")],[MethodDecl(Type "bool","getBFromC",[],Block([Return(InstVar(LocalOrFieldVar("c"),"b"))]))])],
                 [Class(Type "E",[],[MethodDecl(Type "int","add",[(Type "int","a"),((Type("int")),"b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))])],
                 [Class(Type "F",[FieldDecl(Type "int","x")],[MethodDecl(Type "int","getX",[],Block([Return(LocalOrFieldVar("x"))]))]),
                  Class(Type "G",[],[MethodDecl(Type "int","callGetX",[(Type "F","f")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("f"),"getX",[]))))])],
                 [Class(Type "H",[],[MethodDecl(Type "int","add",[(Type "int","a"),((Type("int")),"b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))]),
                  Class(Type "I",[FieldDecl(Type "H","h")],[MethodDecl(Type "int","callAdd",[(Type("int"),"x"),(Type("int"),"y")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("h"),"add",[LocalOrFieldVar("x"),LocalOrFieldVar("y")]))))])],
                 [Class(Type "J",[],[MethodDecl(Type "J","getThis",[],Return(This))])],
                 [Class(Type "K",[FieldDecl(Type "L","l"),FieldDecl(Type "int","x")],[MethodDecl(Type "L","getL",[],Return(LocalOrFieldVar("l"))),MethodDecl(Type "M","getM",[],Block([LocalVarDecl(Type "M","myM"),StmtExprStmt(Assign(LocalOrFieldVar("myM"),StmtExprExpr(MethodCall(LocalOrFieldVar("l"),"getM",[])))),Return(LocalOrFieldVar("myM"))]))]),
                  Class(Type "L",[FieldDecl(Type "M","m"),FieldDecl(Type "int","y")],[MethodDecl(Type "M","getM",[],Return(LocalOrFieldVar("m"))),MethodDecl(Type "int","sumABCTimesXYZ",[(Type "int","a"),(Type "int","b"),(Type "int","c")],Block([LocalVarDecl(Type "int","sum"),StmtExprStmt(Assign(LocalOrFieldVar("sum"),Binary("*",LocalOrFieldVar("a"),InstVar(StmtExprExpr(MethodCall(StmtExprExpr(MethodCall(This,"getM",[])),"getK",[])),"x")))),StmtExprStmt(Assign(LocalOrFieldVar("sum"),Binary("+",LocalOrFieldVar("sum"),Binary("*",LocalOrFieldVar("b"),LocalOrFieldVar("y"))))),StmtExprStmt(Assign(LocalOrFieldVar("sum"),Binary("+",LocalOrFieldVar("sum"),Binary("*",LocalOrFieldVar("c"),InstVar(LocalOrFieldVar("m"),"z"))))),Return(LocalOrFieldVar("sum"))]))]),
                  Class(Type "M",[FieldDecl(Type "K","k"),FieldDecl(Type "int","z")],[MethodDecl(Type "K","getK",[],Return(LocalOrFieldVar("k")))])],
                 [Class(Type "O",[],[MethodDecl(Type "int","fibonacci",[(Type "int", "x")],Block([LocalVarDecl(Type "int","a"),LocalVarDecl(Type "int", "b"),StmtExprStmt(Assign(LocalOrFieldVar("a"),Integer(0))),StmtExprStmt(Assign(LocalOrFieldVar("b"),Integer(1))),While(Binary(">",LocalOrFieldVar("x"),Integer(0)),Block([LocalVarDecl(Type "int","temp"),StmtExprStmt(Assign(LocalOrFieldVar("temp"),LocalOrFieldVar("b"))),StmtExprStmt(Assign(LocalOrFieldVar("b"),Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b")))),StmtExprStmt(Assign(LocalOrFieldVar("a"),LocalOrFieldVar("temp"))),StmtExprStmt(Assign(LocalOrFieldVar("x"),Binary("-",LocalOrFieldVar("x"),Integer(1))))])),Return(LocalOrFieldVar("b"))]))])],
                 [Class(Type "P",[],[]),
                  Class(Type "Q",[],[MethodDecl(Type "P","createP",[],Return(StmtExprExpr(New(Type "P",[]))))])]
                ]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (show (typecheckPrg prg) ++ "\n\n")) testProgramms
