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
			MethodDecl(Type "int","add",[(Type "int","a"),(Type "int","b")],Return(Binary("+",LocalOrFieldVar("a"),LocalOrFieldVar("b"))))
			])
		]
	]

main :: IO ()
main = putStrLn $ concat $ map (\prg -> (show (typecheckPrg prg) ++ "\n\n")) testProgramms
