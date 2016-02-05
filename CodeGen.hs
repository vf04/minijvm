--main = putStrLn("Erfolg")
--Datendefinitionen:
import AbsSyn
import ByteCodeDefs

--Hifsfunktionen:
--import Others


-- Hackage -> https://hackage.haskell.org/package/dbjava



----- Insert            
insert_Class :: String -> CP_Infos -> CP_Infos
insert_Class name cp =  insert_Utf8 name $ cp ++ [(Class_Info TagClass (Index_Constant_Pool((length cp) + 2)) "")]

insert_Utf8 :: String -> CP_Infos -> CP_Infos
insert_Utf8 name cp = cp ++ [(Utf8_Info TagUtf8 (length name) name "")]

----- Create

create_CP :: Prg -> CP_Infos

create_CP program =
   let init_CP =  [(MethodRef_Info TagMethodRef (Index_Constant_Pool 2) (Index_Constant_Pool 6) ""),
                   (Class_Info TagClass (Index_Constant_Pool 7) ""),
                   (Utf8_Info TagUtf8 6 "<init>" ""),
                   (Utf8_Info TagUtf8 3 "()V" ""),
                   (Utf8_Info TagUtf8 4 "Code" ""),
                   (NameAndType_Info TagNameAndType (Index_Constant_Pool 3) (Index_Constant_Pool 4) ""),
                   (Utf8_Info TagUtf8 16 "java/lang/Object" "")]
   in create_Prg program init_CP

create_Prg :: Prg -> CP_Infos -> CP_Infos --Geht alle Klassen durch.
create_Prg [] cp = cp
create_Prg (akt_class : rest) cp = create_Prg rest $ create_Class akt_class cp


create_Class :: Class -> CP_Infos -> CP_Infos --Erstellt CP fuer eine Klasse.
create_Class (Class(Type name, fields , methods,_)) cp = create_MethodDecls methods $ create_FieldDecls fields $ insert_Class name cp


create_FieldDecls :: [FieldDecl] -> CP_Infos -> CP_Infos
create_FieldDecls [] cp = cp
--create_FieldDecls (x : rest) cp =

--create_FieldDecl :: FieldDecl -> CP_Infos -> CP_Infos

create_MethodDecls :: [MethodDecl] -> CP_Infos -> CP_Infos
create_MethodDecls [] cp = cp

--create_MethodDecl :: MethodDecl -> CP_Infos


----- Abstrakter Bytecode







