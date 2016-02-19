module CodeGen where

--main = putStrLn("Erfolg")
--Datendefinitionen:
import AbsSyn
--import ByteCodeDefs jetzt in ClassFormat



-- Hackage -> https://hackage.haskell.org/package/dbjava
import ClassFormat
import BinaryClass

--encode jetzt in BinaryClass vorhanden brauche also nicht:
--import PrettyClass
--import UU.Pretty
--import System
--import System.Cmd


----- Insert

insert_MethodRef :: Int -> Int -> CP_Infos -> CP_Infos
insert_MethodRef classIndex nameAndTypeIndex cp = cp ++ [(MethodRef_Info TagMethodRef classIndex nameAndTypeIndex "")]

insert_Class :: String -> CP_Infos -> CP_Infos
insert_Class name cp =  insert_Utf8 name $ cp ++ [(Class_Info TagClass ((length cp) + 2) "")]

insert_FieldRef :: Int -> CP_Infos -> CP_Infos
insert_FieldRef nameAndTypeIndex cp = cp ++ [(FieldRef_Info TagFieldRef 8 nameAndTypeIndex "")]

insert_NameAndType :: Int -> Int -> CP_Infos -> CP_Infos
insert_NameAndType nameIndex typeIndex cp =  cp ++ [(NameAndType_Info TagNameAndType nameIndex typeIndex "")]

insert_Utf8 :: String -> CP_Infos -> CP_Infos
insert_Utf8 name cp = cp ++ [(Utf8_Info TagUtf8 (length name) name "")]

----- Create

create_CP :: Prg -> CP_Infos


create_CP program =
   let init_CP =  [(MethodRef_Info TagMethodRef 2 6 ""),
                   (Class_Info TagClass 7 ""),
                   (Utf8_Info TagUtf8 6 "<init>" ""),
                   (Utf8_Info TagUtf8 3 "()V" ""),
                   (Utf8_Info TagUtf8 4 "Code" ""),
                   (NameAndType_Info TagNameAndType 3 4 ""),
                   (Utf8_Info TagUtf8 16 "java/lang/Object" "")]
   in create_Prg program init_CP


create_Prg :: Prg -> CP_Infos -> CP_Infos --Geht alle Klassen durch.
create_Prg [] cp = insert_Utf8 "StackMapTable" cp
create_Prg (akt_class : rest) cp = create_Prg rest $ create_Class akt_class cp


create_Class :: Class -> CP_Infos -> CP_Infos --Erstellt CP fuer eine Klasse.
create_Class (Class(Type name, fields , methods,_)) cp = create_MethodDecls methods $ create_FieldDecls fields $ insert_Class name cp

--Field Declarations:
create_FieldDecls :: [FieldDecl] -> CP_Infos -> CP_Infos
create_FieldDecls [] cp = cp
create_FieldDecls (akt_field : rest) cp = create_FieldDecls rest $ create_FieldDecl akt_field cp

create_FieldDecl :: FieldDecl -> CP_Infos -> CP_Infos
create_FieldDecl (FieldDecl(Type typ, name)) cp
            | elem (Utf8_Info TagUtf8 (length (typ_mapper typ)) (typ_mapper typ) "") cp == False = insert_FieldRef (3 + (length cp)) $ insert_NameAndType (1 + (length cp)) (2 + (length cp)) $ insert_Utf8 (typ_mapper typ) $ insert_Utf8 name cp
            | elem (Utf8_Info TagUtf8 (length  (typ_mapper typ)) (typ_mapper typ) "") cp == True = insert_FieldRef (2 + (length cp)) $ insert_NameAndType (1 + (length cp)) (elemIndex (Utf8_Info TagUtf8 (length (typ_mapper typ)) (typ_mapper typ) "") cp) $ insert_Utf8 name cp

typ_mapper :: String -> String
typ_mapper "void" = "V"
typ_mapper "bool" = "Z"
typ_mapper "int" = "I"
typ_mapper "long" = "L"
typ_mapper "char" = "C"
typ_mapper "float" = "F"
typ_mapper "double" = "D"
typ_mapper "Integer" = "Ljava/lang/Integer;"
typ_mapper "String" = "Ljava/lang/String;"
typ_mapper str = str



--Method Declarations:
create_MethodDecls :: [MethodDecl] -> CP_Infos -> CP_Infos
create_MethodDecls [] cp = cp
create_MethodDecls (akt_method : rest) cp = create_MethodDecls rest $ create_MethodDecl akt_method cp 

create_MethodDecl :: MethodDecl -> CP_Infos -> CP_Infos
create_MethodDecl (MethodDecl(Type typ, name, vars, stmt)) cp
    | elem (Utf8_Info TagUtf8 (length (get_MethodType typ vars)) (get_MethodType typ vars) "") cp == False = create_Stmt stmt $ insert_MethodRef 8 ((length cp) + 3) $ insert_NameAndType ((length cp) + 1) ((length cp) + 2) $ insert_Utf8 (get_MethodType typ vars) $ insert_Utf8 name cp
    | elem (Utf8_Info TagUtf8 (length (get_MethodType typ vars)) (get_MethodType typ vars) "") cp == True = create_Stmt stmt $ insert_MethodRef 8 ((length cp) + 2) $ insert_NameAndType ((length cp) + 1) (elemIndex (Utf8_Info TagUtf8 (length (get_MethodType typ vars)) (get_MethodType typ vars) "") cp) $ insert_Utf8 name cp 

create_Stmt :: Stmt -> CP_Infos -> CP_Infos
create_Stmt stmt cp = cp

get_MethodType :: String -> [(Type , String)] -> String
get_MethodType typ vars = "(" ++ (foldr (\ (Type a, name) b -> (b ++ (typ_mapper a))) "" vars) ++ ")" ++ typ_mapper typ

-- Name eingeben 
-- Typ berechnen z.B.(II)I
-- Nachschauen ob Typ rein muss
-- NameAndType anlegen
-- MethodRef anlegen


----- Abstrakter Bytecode (nur empty+variabler CP)

codegen :: Prg -> ClassFile
codegen prg =
    let cp = create_CP prg
    in ClassFile
        Magic 
        (MinorVersion 0)
        (MajorVersion 51)
        ((length cp) +1)  -- count constant pool
        cp                -- constant pool
        (AccessFlags [32])      -- access flags (?!)
        (ThisClass 8)
        (SuperClass 2)
        0                 -- count intefaces
        []                -- interfaces
        0                 -- count fields
        []                -- fields
        1                 -- count methods
        [Method_Info      -- methods
            (AccessFlags [0]) -- access flags
            3             -- <init>_Index_CP
            4             -- ()V_Index_CP
            1
            [AttributeCode
                5         -- code_Index_CP
                17        -- attribute_length
                127       -- max stack
                127       -- max locals
                5         -- code_length
                [0x2A,0xB7, 0x00, 0x01, 0xB1]  -- Code (fuer empty)
                0         -- exception_table_length
                []        -- exception_table
                0         -- attributes_count
                []        -- attributes
            ]
        ]
        0                 -- count attributes
        []                -- attributes


----- Fertige .Class -- encode aus Hackage: encodeClassFile :: FilePath -> ClassFile -> IO ()
iogen :: FilePath -> Prg -> IO ()
iogen = \path prg -> encodeClassFile path $ codegen prg



-- Hilfsfunktionen:

--ElemIndex als Endrekursion:
elemIndex :: Eq a => a -> [a] -> Int
elemIndex x as = elemIndexWorker 1 x as

elemIndexWorker :: Eq a => Int -> a -> [a] -> Int
elemIndexWorker n x [] = 0
elemIndexWorker n x (a: as)
    | x == a = n
    | otherwise = elemIndexWorker (n+1) x as




