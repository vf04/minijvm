module CodeGen where

--main = putStrLn("Erfolg")
--Datendefinitionen:
import AbsSyn
--import ByteCodeDefs jetzt in ClassFormat


--Hifsfunktionen:
--import Others -- bisher keine gebraucht



-- Hackage -> https://hackage.haskell.org/package/dbjava
import ClassFormat
import BinaryClass

--encode jetzt in BinaryClass vorhanden; Brauche noch folgende? (tun nicht)
--import PrettyClass
--import UU.Pretty
--import System
--import System.Cmd


----- Insert            
insert_Class :: String -> CP_Infos -> CP_Infos
insert_Class name cp =  insert_Utf8 name $ cp ++ [(Class_Info TagClass ((length cp) + 2) "")]

insert_Utf8 :: String -> CP_Infos -> CP_Infos
insert_Utf8 name cp = cp ++ [(Utf8_Info TagUtf8 (length name) name "")]

----- Create

create_CP :: Prg -> CP_Infos

{-create_CP program =
   let init_CP =  [(MethodRef_Info TagMethodRef (Index_Constant_Pool 2) (Index_Constant_Pool 6) ""),
                   (Class_Info TagClass (Index_Constant_Pool 7) ""),
                   (Utf8_Info TagUtf8 6 "<init>" ""),
                   (Utf8_Info TagUtf8 3 "()V" ""),
                   (Utf8_Info TagUtf8 4 "Code" ""),
                   (NameAndType_Info TagNameAndType (Index_Constant_Pool 3) (Index_Constant_Pool 4) ""),
                   (Utf8_Info TagUtf8 16 "java/lang/Object" "")]
   in create_Prg program init_CP
(nach ByteCodeDefs alt)-}

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
create_Prg [] cp = cp
create_Prg (akt_class : rest) cp = create_Prg rest $ create_Class akt_class cp


create_Class :: Class -> CP_Infos -> CP_Infos --Erstellt CP fuer eine Klasse.
create_Class (Class(Type name, fields , methods,_)) cp = create_MethodDecls methods $ create_FieldDecls fields $ insert_Class name cp

--Field Declarations:
create_FieldDecls :: [FieldDecl] -> CP_Infos -> CP_Infos
create_FieldDecls [] cp = cp
create_FieldDecls (akt_field : rest) cp = create_FieldDecls rest $ create_FieldDecl akt_field cp

create_FieldDecl :: FieldDecl -> CP_Infos -> CP_Infos --Typennamen mappen!!!
create_FieldDecl (FieldDecl(Type typ, name)) cp
            | elem (Utf8_Info TagUtf8 (length typ) (typ_mapper typ) "") cp == False = insert_Utf8 (typ_mapper typ) $ insert_Utf8 name cp
            | elem (Utf8_Info TagUtf8 (length typ) (typ_mapper typ) "") cp == True = insert_Utf8 name cp

typ_mapper :: String -> String
typ_mapper "bool" = "Z"
typ_mapper "integer" = "I"
typ_mapper "char" = "C"
typ_mapper str = str



--Method Declarations:
create_MethodDecls :: [MethodDecl] -> CP_Infos -> CP_Infos
create_MethodDecls [] cp = cp

--create_MethodDecl :: MethodDecl -> CP_Infos


----- Abstrakter Bytecode (nur empty+variabler CP)

codegen :: Prg -> ClassFile -- magic????
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
                0         -- code_length
                [42,749569,177]  -- Code (fuer empty)
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


