import JavaParser
import SemantikCheck
import CodeGen

compileJavaFile :: FilePath -> IO()
compileJavaFile fileName = do
		javaCode <- readFile fileName
		--putStrLn $ show $ typecheckPrg $ parse javaCode
		iogen "Compiled.class" $ typecheckPrg $ parse javaCode