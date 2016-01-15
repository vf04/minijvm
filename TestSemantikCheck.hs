import AbsSyn
import SemantikCheck

testProgramms = [[Class("Leer",[],[])],
                 [Class("A",[FieldDecl("int","x")],[])],
                 [Class("B",[FieldDecl("int","x")],[MethodDecl("int","getX",[],Block([Return(LocalOrFieldVar("x"))]))])],
                 [Class("C",[FieldDecl("bool","b")],[]),
                  Class("D",[FieldDecl("C","c")],[MethodDecl("bool","getBFromC",[],Block([Return(InstVar(LocalOrFieldVar("c"),"b"))]))])],
                 [Class("E",[],[MethodDecl("int","add",[("int","a"),("int","b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))])],
                 [Class("F",[FieldDecl("int","x")],[MethodDecl("int","getX",[],Block([Return(LocalOrFieldVar("x"))]))]),
                  Class("G",[],[MethodDecl("int","callGetX",[("F","f")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("f"),"getX",[]))))])],
                 [Class("H",[],[MethodDecl("int","add",[("int","a"),("int","b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))]),
                  Class("I",[FieldDecl("H","h")],[MethodDecl("int","callAdd",[("int","x"),("int","y")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("h"),"add",[LocalOrFieldVar("x"),LocalOrFieldVar("y")]))))])]]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (show (typecheckPrg prg) ++ "\n\n")) testProgramms
