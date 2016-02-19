import AbsSyn
import ClassFormat
import JavaParser
import SemantikCheck
import CodeGen
import ClassFormat
import BinaryClass
import System.IO.Unsafe


test_CP :: FilePath -> CP_Infos
test_CP fileName =
    let
        javaCode = unsafePerformIO $ readFile (strToPathJava fileName)
    in
        diflist (merge $ get_CP $ unsafePerformIO $ decodeClassFile $ strToPathClass fileName) (merge $ create_CP $ typecheckPrg $ parse javaCode)


test_merge :: FilePath -> CP_Infos
test_merge fileName =
    let
        javaCode = unsafePerformIO $ readFile (strToPathJava fileName)
    in --Eines der beiden folgenden testet den Test-Merge:
        merge $ get_CP $ unsafePerformIO $ decodeClassFile $ strToPathClass fileName
        --merge $ create_CP $ typecheckPrg $ parse javaCode


strToPathClass :: FilePath -> FilePath
strToPathClass name = name ++ ".class"


strToPathJava :: FilePath -> FilePath
strToPathJava name = name ++ ".java"

get_CP :: ClassFile -> CP_Infos
get_CP (ClassFile
            Magic
            minver
            maxver
            count_cp
            array_cp
            acfg
            this
            super
            count_interfaces
            array_interfaces
            count_fields
            array_fields
            count_methods
            array_methods
            count_attributes
            array_attributes)
            = array_cp


-- Explizite Tests:


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
        Class(Type "M",[],[MethodDecl(Type "N","getNewM",[],Block([LocalVarDecl(Type "N","myN"),StmtExprStmt(Assign(LocalOrFieldVar("myN"),StmtExprExpr(New(Type "M",[])))),Return(Just(LocalOrFieldVar("myN")))]))],[Type "N"]),
        Class(Type "N",[FieldDecl(Type "char","i")],[],[])]
    ]

testInput = map typecheckPrg testProgramms

explTest_CP :: Prg -> FilePath -> CP_Infos
explTest_CP prg fileName =
    let
        javaCode = unsafePerformIO $ readFile (strToPathJava fileName)
    in
        diflist (merge $ get_CP $ unsafePerformIO $ decodeClassFile $ strToPathClass fileName) (merge $ create_CP prg)



-- Hilfsfunktionen:

diflist :: Eq a => [a] -> [a] -> [a]
diflist as bs = foldr (del_elem) as bs

del_elem :: Eq a => a -> [a] -> [a]
del_elem a as = filter (not_eq a) as

not_eq :: Eq a => a -> a -> Bool
not_eq a b = not $ a == b



merge :: CP_Infos -> CP_Infos
merge cp = 
        let cp_NameAndType = map (merge_NameAndType cp) cp
        in map (merge_CP (cp_NameAndType)) $ cp_NameAndType

merge_NameAndType :: CP_Infos -> (CP_Info -> CP_Info)
merge_NameAndType = (\ cp -> (\ info -> (trans_NameAndType info cp)))

trans_NameAndType :: CP_Info -> CP_Infos -> CP_Info --Ueberfuehrt NameAndType_Info und Class Info in Utf8_Info
trans_NameAndType (NameAndType_Info TagNameAndType i j "") cp = (Utf8_Info TagUtf8 0 (get_cad (cp !! (i-1)) ++ ":" ++ (get_cad (cp !! (j-1)))) "NameAndType")
trans_NameAndType (Class_Info TagClass index "") cp = (Utf8_Info TagUtf8 0 (get_cad (cp !! (index-1))) "Class")
trans_NameAndType rest cp = rest

get_cad :: CP_Info -> String
get_cad (Utf8_Info TagUtf8 n cad desc) = cad
get_cad rest = "no Utf8_INFO"


merge_CP :: CP_Infos -> (CP_Info -> CP_Info)
merge_CP = (\ cp -> (\ info -> (trans_CP info cp)))

trans_CP :: CP_Info -> CP_Infos -> CP_Info -- Ueberfuehrt die restlichen CP_Infos in Utf8_Info
trans_CP (Utf8_Info TagUtf8 tam cad "") cp = (Utf8_Info TagUtf8 tam cad "")
trans_CP (FieldRef_Info TagFieldRef i j "") cp = (Utf8_Info TagUtf8 0 ((get_cad (cp !! (i-1))) ++ "." ++ (get_cad (cp !! (j-1)))) "FieldRef")
trans_CP (MethodRef_Info TagMethodRef i j "") cp = (Utf8_Info TagUtf8 0 ((get_cad (cp !! (i-1))) ++ "." ++ (get_cad (cp !! (j-1)))) "MethodRef")
trans_CP rest cp = rest


