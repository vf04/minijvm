import AbsSyn
import SemantikCheck

testProgramms = [[Class(Type("Leer"),[],[])],
                 [Class(Type("A"),[FieldDecl(Type("int"),"x")],[])],
                 [Class(Type("B"),[FieldDecl(Type("int"),"x")],[MethodDecl(Type("int"),"getX",[],Block([Return(LocalOrFieldVar("x"))]))])],
                 [Class(Type("C"),[FieldDecl(Type("bool"),"b")],[]),
                  Class(Type("D"),[FieldDecl(Type("C"),"c")],[MethodDecl(Type("bool"),"getBFromC",[],Block([Return(InstVar(LocalOrFieldVar("c"),"b"))]))])],
                 [Class(Type("E"),[],[MethodDecl(Type("int"),"add",[(Type("int"),"a"),((Type("int")),"b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))])],
                 [Class(Type("F"),[FieldDecl(Type("int"),"x")],[MethodDecl(Type("int"),"getX",[],Block([Return(LocalOrFieldVar("x"))]))]),
                  Class(Type("G"),[],[MethodDecl(Type("int"),"callGetX",[(Type("F"),"f")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("f"),"getX",[]))))])],
                 [Class(Type("H"),[],[MethodDecl(Type("int"),"add",[(Type("int"),"a"),((Type("int")),"b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))]),
                  Class(Type("I"),[FieldDecl(Type("H"),"h")],[MethodDecl(Type("int"),"callAdd",[(Type("int"),"x"),(Type("int"),"y")],Return(StmtExprExpr(MethodCall(LocalOrFieldVar("h"),"add",[LocalOrFieldVar("x"),LocalOrFieldVar("y")]))))])]]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (show (typecheckPrg prg) ++ "\n\n")) testProgramms
