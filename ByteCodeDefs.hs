--wird nicht mehr gebraucht, jetzt in ClassFormat.hs
module ByteCodeDefs where



data ClassFile = ClassFile { magic            :: Magic              -- CAFEBABE
                           , minver           :: MinorVersion       -- Versionen
                           , maxver           :: MajorVersion       -- ''
                           , count_cp         :: ConstantPool_Count -- Anz. Eintr. Konst.pool
                           , array_cp         :: CP_Infos           -- Konstantenpool
                           , acfg             :: AccessFlags        -- Berechtigungen
                           , this             :: ThisClass          -- This-Klasse
                           , super            :: SuperClass         -- Super-Klasse
                           , count_interfaces :: Interfaces_Count   -- Anz. Interfaces
                           , array_interfaces :: Interfaces         -- Interfaces
                           , count_fields     :: Fields_Count       -- Anzahl Fields
                           , array_fields     :: Field_Infos        -- Fields
                           , count_methods    :: Methods_Count      -- Anz. Methoden
                           , array_methods    :: Method_Infos       -- Methoden
                           , count_attributes :: Attributes_Count   -- Anz. Attribute
                           , array_attributes :: Attribute_Infos    -- Attribute
}



type Interfaces      = [Interface]
type Field_Infos     = [Field_Info]
type Method_Infos    = [Method_Info]
type Attribute_Infos = [Attribute_Info]

type ConstantPool_Count = Int
type Interfaces_Count   = Int
type Fields_Count       = Int
type Methods_Count      = Int
type Attributes_Count   = Int



data Magic = Magic
data MinorVersion = MinorVersion {numMinVer :: Int}
data MajorVersion = MajorVersion {numMaxVer :: Int}




data CP_Info =
    Class_Info
        { tag_cp :: Tag
        , index_cp :: Index_Constant_Pool
        , desc :: String }
    | FieldRef_Info
        { tag_cp :: Tag
        , index_name_cp :: Index_Constant_Pool
        , index_nameandtype_cp :: Index_Constant_Pool
        , desc :: String }
    | MethodRef_Info
        { tag_cp :: Tag
        , index_name_cp :: Index_Constant_Pool
        , index_nameandtype_cp :: Index_Constant_Pool
        , desc :: String }
    | InterfaceMethodRef_Info
        { tag_cp :: Tag
        , index_name_cp :: Index_Constant_Pool
        , index_nameandtype_cp :: Index_Constant_Pool
        , desc :: String }
    | String_Info
        { tag_cp :: Tag
        , index_cp :: Index_Constant_Pool
        , desc :: String }
    | Integer_Info
        { tag_cp :: Tag
        , numi_cp :: Int
        , desc :: String }
    | Float_Info
        { tag_cp :: Tag
        , numf_cp :: Float
        , desc :: String }
    | Long_Info
        { tag_cp :: Tag
        , numi_l1_cp :: Int
        , numi_l2_cp :: Int
        , desc :: String }
    | Double_Info
        {tag_cp :: Tag
        , numi_d1_cp :: Int
        , numi_d2_cp :: Int
        , desc :: String }
    | NameAndType_Info
        { tag_cp :: Tag
        , index_name_cp :: Index_Constant_Pool
        , index_descr_cp :: Index_Constant_Pool
        , desc :: String }
    | Utf8_Info
        { tag_cp :: Tag
        , tam_cp :: Int
        , cad_cp :: String
        , desc :: String }
    deriving(Show,Eq)

data Index_Constant_Pool = Index_Constant_Pool {index :: Int} deriving(Show,Eq)

data Tag = TagClass
    | TagFieldRef
    | TagMethodRef
    | TagInterfaceMethodRef
    | TagString
    | TagInteger
    | TagFloat
    | TagLong
    | TagDouble
    | TagNameAndType
    | TagUtf8
    deriving(Show, Eq)

type CP_Infos = [CP_Info]

{-
instance Eq Tag where
  TagFieldRef == TagFieldRef = True
  TagMethodRef == TagMethodRef = True
  TagInterfaceMethodRef == TagInterfaceMethodRef = True
  TagString == TagString = True
  TagInteger == TagInteger = True
  TagFloat == TagFloat = True
  TagLong == TagLong = True
  TagDouble == TagDouble = True
  TagNameAndType == TagNameAndType = True
  TagUtf8 == TagUtf8 = True
  x == y = False
-}

