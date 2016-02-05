module ByteCodeDefs where

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

