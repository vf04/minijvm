{-# OPTIONS_GHC -w #-}
module JavaParser (parse) where
import AbsSyn
import JavaLexer
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t86 t87 t88
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn86 t86
	| HappyAbsSyn87 t87
	| HappyAbsSyn88 t88

action_0 (125) = happyShift action_87
action_0 (86) = happyGoto action_170
action_0 (87) = happyGoto action_85
action_0 (88) = happyGoto action_86
action_0 _ = happyFail

action_1 (125) = happyShift action_87
action_1 (86) = happyGoto action_169
action_1 (87) = happyGoto action_85
action_1 (88) = happyGoto action_86
action_1 _ = happyFail

action_2 (125) = happyShift action_87
action_2 (86) = happyGoto action_168
action_2 (87) = happyGoto action_85
action_2 (88) = happyGoto action_86
action_2 _ = happyFail

action_3 (125) = happyShift action_87
action_3 (86) = happyGoto action_167
action_3 (87) = happyGoto action_85
action_3 (88) = happyGoto action_86
action_3 _ = happyFail

action_4 (125) = happyShift action_87
action_4 (86) = happyGoto action_166
action_4 (87) = happyGoto action_85
action_4 (88) = happyGoto action_86
action_4 _ = happyFail

action_5 (125) = happyShift action_87
action_5 (86) = happyGoto action_165
action_5 (87) = happyGoto action_85
action_5 (88) = happyGoto action_86
action_5 _ = happyFail

action_6 (125) = happyShift action_87
action_6 (86) = happyGoto action_164
action_6 (87) = happyGoto action_85
action_6 (88) = happyGoto action_86
action_6 _ = happyFail

action_7 (125) = happyShift action_87
action_7 (86) = happyGoto action_163
action_7 (87) = happyGoto action_85
action_7 (88) = happyGoto action_86
action_7 _ = happyFail

action_8 (125) = happyShift action_87
action_8 (86) = happyGoto action_162
action_8 (87) = happyGoto action_85
action_8 (88) = happyGoto action_86
action_8 _ = happyFail

action_9 (125) = happyShift action_87
action_9 (86) = happyGoto action_161
action_9 (87) = happyGoto action_85
action_9 (88) = happyGoto action_86
action_9 _ = happyFail

action_10 (125) = happyShift action_87
action_10 (86) = happyGoto action_160
action_10 (87) = happyGoto action_85
action_10 (88) = happyGoto action_86
action_10 _ = happyFail

action_11 (125) = happyShift action_87
action_11 (86) = happyGoto action_159
action_11 (87) = happyGoto action_85
action_11 (88) = happyGoto action_86
action_11 _ = happyFail

action_12 (125) = happyShift action_87
action_12 (86) = happyGoto action_158
action_12 (87) = happyGoto action_85
action_12 (88) = happyGoto action_86
action_12 _ = happyFail

action_13 (125) = happyShift action_87
action_13 (86) = happyGoto action_157
action_13 (87) = happyGoto action_85
action_13 (88) = happyGoto action_86
action_13 _ = happyFail

action_14 (125) = happyShift action_87
action_14 (86) = happyGoto action_156
action_14 (87) = happyGoto action_85
action_14 (88) = happyGoto action_86
action_14 _ = happyFail

action_15 (125) = happyShift action_87
action_15 (86) = happyGoto action_155
action_15 (87) = happyGoto action_85
action_15 (88) = happyGoto action_86
action_15 _ = happyFail

action_16 (125) = happyShift action_87
action_16 (86) = happyGoto action_154
action_16 (87) = happyGoto action_85
action_16 (88) = happyGoto action_86
action_16 _ = happyFail

action_17 (125) = happyShift action_87
action_17 (86) = happyGoto action_153
action_17 (87) = happyGoto action_85
action_17 (88) = happyGoto action_86
action_17 _ = happyFail

action_18 (125) = happyShift action_87
action_18 (86) = happyGoto action_152
action_18 (87) = happyGoto action_85
action_18 (88) = happyGoto action_86
action_18 _ = happyFail

action_19 (125) = happyShift action_87
action_19 (86) = happyGoto action_151
action_19 (87) = happyGoto action_85
action_19 (88) = happyGoto action_86
action_19 _ = happyFail

action_20 (125) = happyShift action_87
action_20 (86) = happyGoto action_150
action_20 (87) = happyGoto action_85
action_20 (88) = happyGoto action_86
action_20 _ = happyFail

action_21 (125) = happyShift action_87
action_21 (86) = happyGoto action_149
action_21 (87) = happyGoto action_85
action_21 (88) = happyGoto action_86
action_21 _ = happyFail

action_22 (125) = happyShift action_87
action_22 (86) = happyGoto action_148
action_22 (87) = happyGoto action_85
action_22 (88) = happyGoto action_86
action_22 _ = happyFail

action_23 (125) = happyShift action_87
action_23 (86) = happyGoto action_147
action_23 (87) = happyGoto action_85
action_23 (88) = happyGoto action_86
action_23 _ = happyFail

action_24 (125) = happyShift action_87
action_24 (86) = happyGoto action_146
action_24 (87) = happyGoto action_85
action_24 (88) = happyGoto action_86
action_24 _ = happyFail

action_25 (125) = happyShift action_87
action_25 (86) = happyGoto action_145
action_25 (87) = happyGoto action_85
action_25 (88) = happyGoto action_86
action_25 _ = happyFail

action_26 (125) = happyShift action_87
action_26 (86) = happyGoto action_144
action_26 (87) = happyGoto action_85
action_26 (88) = happyGoto action_86
action_26 _ = happyFail

action_27 (125) = happyShift action_87
action_27 (86) = happyGoto action_143
action_27 (87) = happyGoto action_85
action_27 (88) = happyGoto action_86
action_27 _ = happyFail

action_28 (125) = happyShift action_87
action_28 (86) = happyGoto action_142
action_28 (87) = happyGoto action_85
action_28 (88) = happyGoto action_86
action_28 _ = happyFail

action_29 (125) = happyShift action_87
action_29 (86) = happyGoto action_141
action_29 (87) = happyGoto action_85
action_29 (88) = happyGoto action_86
action_29 _ = happyFail

action_30 (125) = happyShift action_87
action_30 (86) = happyGoto action_140
action_30 (87) = happyGoto action_85
action_30 (88) = happyGoto action_86
action_30 _ = happyFail

action_31 (125) = happyShift action_87
action_31 (86) = happyGoto action_139
action_31 (87) = happyGoto action_85
action_31 (88) = happyGoto action_86
action_31 _ = happyFail

action_32 (125) = happyShift action_87
action_32 (86) = happyGoto action_138
action_32 (87) = happyGoto action_85
action_32 (88) = happyGoto action_86
action_32 _ = happyFail

action_33 (125) = happyShift action_87
action_33 (86) = happyGoto action_137
action_33 (87) = happyGoto action_85
action_33 (88) = happyGoto action_86
action_33 _ = happyFail

action_34 (125) = happyShift action_87
action_34 (86) = happyGoto action_136
action_34 (87) = happyGoto action_85
action_34 (88) = happyGoto action_86
action_34 _ = happyFail

action_35 (125) = happyShift action_87
action_35 (86) = happyGoto action_135
action_35 (87) = happyGoto action_85
action_35 (88) = happyGoto action_86
action_35 _ = happyFail

action_36 (125) = happyShift action_87
action_36 (86) = happyGoto action_134
action_36 (87) = happyGoto action_85
action_36 (88) = happyGoto action_86
action_36 _ = happyFail

action_37 (125) = happyShift action_87
action_37 (86) = happyGoto action_133
action_37 (87) = happyGoto action_85
action_37 (88) = happyGoto action_86
action_37 _ = happyFail

action_38 (125) = happyShift action_87
action_38 (86) = happyGoto action_132
action_38 (87) = happyGoto action_85
action_38 (88) = happyGoto action_86
action_38 _ = happyFail

action_39 (125) = happyShift action_87
action_39 (86) = happyGoto action_131
action_39 (87) = happyGoto action_85
action_39 (88) = happyGoto action_86
action_39 _ = happyFail

action_40 (125) = happyShift action_87
action_40 (86) = happyGoto action_130
action_40 (87) = happyGoto action_85
action_40 (88) = happyGoto action_86
action_40 _ = happyFail

action_41 (125) = happyShift action_87
action_41 (86) = happyGoto action_129
action_41 (87) = happyGoto action_85
action_41 (88) = happyGoto action_86
action_41 _ = happyFail

action_42 (125) = happyShift action_87
action_42 (86) = happyGoto action_128
action_42 (87) = happyGoto action_85
action_42 (88) = happyGoto action_86
action_42 _ = happyFail

action_43 (125) = happyShift action_87
action_43 (86) = happyGoto action_127
action_43 (87) = happyGoto action_85
action_43 (88) = happyGoto action_86
action_43 _ = happyFail

action_44 (125) = happyShift action_87
action_44 (86) = happyGoto action_126
action_44 (87) = happyGoto action_85
action_44 (88) = happyGoto action_86
action_44 _ = happyFail

action_45 (125) = happyShift action_87
action_45 (86) = happyGoto action_125
action_45 (87) = happyGoto action_85
action_45 (88) = happyGoto action_86
action_45 _ = happyFail

action_46 (125) = happyShift action_87
action_46 (86) = happyGoto action_124
action_46 (87) = happyGoto action_85
action_46 (88) = happyGoto action_86
action_46 _ = happyFail

action_47 (125) = happyShift action_87
action_47 (86) = happyGoto action_123
action_47 (87) = happyGoto action_85
action_47 (88) = happyGoto action_86
action_47 _ = happyFail

action_48 (125) = happyShift action_87
action_48 (86) = happyGoto action_122
action_48 (87) = happyGoto action_85
action_48 (88) = happyGoto action_86
action_48 _ = happyFail

action_49 (125) = happyShift action_87
action_49 (86) = happyGoto action_121
action_49 (87) = happyGoto action_85
action_49 (88) = happyGoto action_86
action_49 _ = happyFail

action_50 (125) = happyShift action_87
action_50 (86) = happyGoto action_120
action_50 (87) = happyGoto action_85
action_50 (88) = happyGoto action_86
action_50 _ = happyFail

action_51 (125) = happyShift action_87
action_51 (86) = happyGoto action_119
action_51 (87) = happyGoto action_85
action_51 (88) = happyGoto action_86
action_51 _ = happyFail

action_52 (125) = happyShift action_87
action_52 (86) = happyGoto action_118
action_52 (87) = happyGoto action_85
action_52 (88) = happyGoto action_86
action_52 _ = happyFail

action_53 (125) = happyShift action_87
action_53 (86) = happyGoto action_117
action_53 (87) = happyGoto action_85
action_53 (88) = happyGoto action_86
action_53 _ = happyFail

action_54 (125) = happyShift action_87
action_54 (86) = happyGoto action_116
action_54 (87) = happyGoto action_85
action_54 (88) = happyGoto action_86
action_54 _ = happyFail

action_55 (125) = happyShift action_87
action_55 (86) = happyGoto action_115
action_55 (87) = happyGoto action_85
action_55 (88) = happyGoto action_86
action_55 _ = happyFail

action_56 (125) = happyShift action_87
action_56 (86) = happyGoto action_114
action_56 (87) = happyGoto action_85
action_56 (88) = happyGoto action_86
action_56 _ = happyFail

action_57 (125) = happyShift action_87
action_57 (86) = happyGoto action_113
action_57 (87) = happyGoto action_85
action_57 (88) = happyGoto action_86
action_57 _ = happyFail

action_58 (125) = happyShift action_87
action_58 (86) = happyGoto action_112
action_58 (87) = happyGoto action_85
action_58 (88) = happyGoto action_86
action_58 _ = happyFail

action_59 (125) = happyShift action_87
action_59 (86) = happyGoto action_111
action_59 (87) = happyGoto action_85
action_59 (88) = happyGoto action_86
action_59 _ = happyFail

action_60 (125) = happyShift action_87
action_60 (86) = happyGoto action_110
action_60 (87) = happyGoto action_85
action_60 (88) = happyGoto action_86
action_60 _ = happyFail

action_61 (125) = happyShift action_87
action_61 (86) = happyGoto action_109
action_61 (87) = happyGoto action_85
action_61 (88) = happyGoto action_86
action_61 _ = happyFail

action_62 (125) = happyShift action_87
action_62 (86) = happyGoto action_108
action_62 (87) = happyGoto action_85
action_62 (88) = happyGoto action_86
action_62 _ = happyFail

action_63 (125) = happyShift action_87
action_63 (86) = happyGoto action_107
action_63 (87) = happyGoto action_85
action_63 (88) = happyGoto action_86
action_63 _ = happyFail

action_64 (125) = happyShift action_87
action_64 (86) = happyGoto action_106
action_64 (87) = happyGoto action_85
action_64 (88) = happyGoto action_86
action_64 _ = happyFail

action_65 (125) = happyShift action_87
action_65 (86) = happyGoto action_105
action_65 (87) = happyGoto action_85
action_65 (88) = happyGoto action_86
action_65 _ = happyFail

action_66 (125) = happyShift action_87
action_66 (86) = happyGoto action_104
action_66 (87) = happyGoto action_85
action_66 (88) = happyGoto action_86
action_66 _ = happyFail

action_67 (125) = happyShift action_87
action_67 (86) = happyGoto action_103
action_67 (87) = happyGoto action_85
action_67 (88) = happyGoto action_86
action_67 _ = happyFail

action_68 (125) = happyShift action_87
action_68 (86) = happyGoto action_102
action_68 (87) = happyGoto action_85
action_68 (88) = happyGoto action_86
action_68 _ = happyFail

action_69 (125) = happyShift action_87
action_69 (86) = happyGoto action_101
action_69 (87) = happyGoto action_85
action_69 (88) = happyGoto action_86
action_69 _ = happyFail

action_70 (125) = happyShift action_87
action_70 (86) = happyGoto action_100
action_70 (87) = happyGoto action_85
action_70 (88) = happyGoto action_86
action_70 _ = happyFail

action_71 (125) = happyShift action_87
action_71 (86) = happyGoto action_99
action_71 (87) = happyGoto action_85
action_71 (88) = happyGoto action_86
action_71 _ = happyFail

action_72 (125) = happyShift action_87
action_72 (86) = happyGoto action_98
action_72 (87) = happyGoto action_85
action_72 (88) = happyGoto action_86
action_72 _ = happyFail

action_73 (125) = happyShift action_87
action_73 (86) = happyGoto action_97
action_73 (87) = happyGoto action_85
action_73 (88) = happyGoto action_86
action_73 _ = happyFail

action_74 (125) = happyShift action_87
action_74 (86) = happyGoto action_96
action_74 (87) = happyGoto action_85
action_74 (88) = happyGoto action_86
action_74 _ = happyFail

action_75 (125) = happyShift action_87
action_75 (86) = happyGoto action_95
action_75 (87) = happyGoto action_85
action_75 (88) = happyGoto action_86
action_75 _ = happyFail

action_76 (125) = happyShift action_87
action_76 (86) = happyGoto action_94
action_76 (87) = happyGoto action_85
action_76 (88) = happyGoto action_86
action_76 _ = happyFail

action_77 (125) = happyShift action_87
action_77 (86) = happyGoto action_93
action_77 (87) = happyGoto action_85
action_77 (88) = happyGoto action_86
action_77 _ = happyFail

action_78 (125) = happyShift action_87
action_78 (86) = happyGoto action_92
action_78 (87) = happyGoto action_85
action_78 (88) = happyGoto action_86
action_78 _ = happyFail

action_79 (125) = happyShift action_87
action_79 (86) = happyGoto action_91
action_79 (87) = happyGoto action_85
action_79 (88) = happyGoto action_86
action_79 _ = happyFail

action_80 (125) = happyShift action_87
action_80 (86) = happyGoto action_90
action_80 (87) = happyGoto action_85
action_80 (88) = happyGoto action_86
action_80 _ = happyFail

action_81 (125) = happyShift action_87
action_81 (86) = happyGoto action_89
action_81 (87) = happyGoto action_85
action_81 (88) = happyGoto action_86
action_81 _ = happyFail

action_82 (125) = happyShift action_87
action_82 (86) = happyGoto action_88
action_82 (87) = happyGoto action_85
action_82 (88) = happyGoto action_86
action_82 _ = happyFail

action_83 (125) = happyShift action_87
action_83 (86) = happyGoto action_84
action_83 (87) = happyGoto action_85
action_83 (88) = happyGoto action_86
action_83 _ = happyFail

action_84 (156) = happyShift action_171
action_84 _ = happyFail

action_85 _ = happyReduce_83

action_86 _ = happyReduce_84

action_87 _ = happyReduce_86

action_88 (156) = happyShift action_171
action_88 (175) = happyAccept
action_88 _ = happyFail

action_89 (156) = happyShift action_171
action_89 (175) = happyAccept
action_89 _ = happyFail

action_90 (156) = happyShift action_171
action_90 (175) = happyAccept
action_90 _ = happyFail

action_91 (156) = happyShift action_171
action_91 (175) = happyAccept
action_91 _ = happyFail

action_92 (156) = happyShift action_171
action_92 (175) = happyAccept
action_92 _ = happyFail

action_93 (156) = happyShift action_171
action_93 (175) = happyAccept
action_93 _ = happyFail

action_94 (156) = happyShift action_171
action_94 (175) = happyAccept
action_94 _ = happyFail

action_95 (156) = happyShift action_171
action_95 (175) = happyAccept
action_95 _ = happyFail

action_96 (156) = happyShift action_171
action_96 (175) = happyAccept
action_96 _ = happyFail

action_97 (156) = happyShift action_171
action_97 (175) = happyAccept
action_97 _ = happyFail

action_98 (156) = happyShift action_171
action_98 (175) = happyAccept
action_98 _ = happyFail

action_99 (156) = happyShift action_171
action_99 (175) = happyAccept
action_99 _ = happyFail

action_100 (156) = happyShift action_171
action_100 (175) = happyAccept
action_100 _ = happyFail

action_101 (156) = happyShift action_171
action_101 (175) = happyAccept
action_101 _ = happyFail

action_102 (156) = happyShift action_171
action_102 (175) = happyAccept
action_102 _ = happyFail

action_103 (156) = happyShift action_171
action_103 (175) = happyAccept
action_103 _ = happyFail

action_104 (156) = happyShift action_171
action_104 (175) = happyAccept
action_104 _ = happyFail

action_105 (156) = happyShift action_171
action_105 (175) = happyAccept
action_105 _ = happyFail

action_106 (156) = happyShift action_171
action_106 (175) = happyAccept
action_106 _ = happyFail

action_107 (156) = happyShift action_171
action_107 (175) = happyAccept
action_107 _ = happyFail

action_108 (156) = happyShift action_171
action_108 (175) = happyAccept
action_108 _ = happyFail

action_109 (156) = happyShift action_171
action_109 (175) = happyAccept
action_109 _ = happyFail

action_110 (156) = happyShift action_171
action_110 (175) = happyAccept
action_110 _ = happyFail

action_111 (156) = happyShift action_171
action_111 (175) = happyAccept
action_111 _ = happyFail

action_112 (156) = happyShift action_171
action_112 (175) = happyAccept
action_112 _ = happyFail

action_113 (156) = happyShift action_171
action_113 (175) = happyAccept
action_113 _ = happyFail

action_114 (156) = happyShift action_171
action_114 (175) = happyAccept
action_114 _ = happyFail

action_115 (156) = happyShift action_171
action_115 (175) = happyAccept
action_115 _ = happyFail

action_116 (156) = happyShift action_171
action_116 (175) = happyAccept
action_116 _ = happyFail

action_117 (156) = happyShift action_171
action_117 (175) = happyAccept
action_117 _ = happyFail

action_118 (156) = happyShift action_171
action_118 (175) = happyAccept
action_118 _ = happyFail

action_119 (156) = happyShift action_171
action_119 (175) = happyAccept
action_119 _ = happyFail

action_120 (156) = happyShift action_171
action_120 (175) = happyAccept
action_120 _ = happyFail

action_121 (156) = happyShift action_171
action_121 (175) = happyAccept
action_121 _ = happyFail

action_122 (156) = happyShift action_171
action_122 (175) = happyAccept
action_122 _ = happyFail

action_123 (156) = happyShift action_171
action_123 (175) = happyAccept
action_123 _ = happyFail

action_124 (156) = happyShift action_171
action_124 (175) = happyAccept
action_124 _ = happyFail

action_125 (156) = happyShift action_171
action_125 (175) = happyAccept
action_125 _ = happyFail

action_126 (156) = happyShift action_171
action_126 (175) = happyAccept
action_126 _ = happyFail

action_127 (156) = happyShift action_171
action_127 (175) = happyAccept
action_127 _ = happyFail

action_128 (156) = happyShift action_171
action_128 (175) = happyAccept
action_128 _ = happyFail

action_129 (156) = happyShift action_171
action_129 (175) = happyAccept
action_129 _ = happyFail

action_130 (156) = happyShift action_171
action_130 (175) = happyAccept
action_130 _ = happyFail

action_131 (156) = happyShift action_171
action_131 (175) = happyAccept
action_131 _ = happyFail

action_132 (156) = happyShift action_171
action_132 (175) = happyAccept
action_132 _ = happyFail

action_133 (156) = happyShift action_171
action_133 (175) = happyAccept
action_133 _ = happyFail

action_134 (156) = happyShift action_171
action_134 (175) = happyAccept
action_134 _ = happyFail

action_135 (156) = happyShift action_171
action_135 (175) = happyAccept
action_135 _ = happyFail

action_136 (156) = happyShift action_171
action_136 (175) = happyAccept
action_136 _ = happyFail

action_137 (156) = happyShift action_171
action_137 (175) = happyAccept
action_137 _ = happyFail

action_138 (156) = happyShift action_171
action_138 (175) = happyAccept
action_138 _ = happyFail

action_139 (156) = happyShift action_171
action_139 (175) = happyAccept
action_139 _ = happyFail

action_140 (156) = happyShift action_171
action_140 (175) = happyAccept
action_140 _ = happyFail

action_141 (156) = happyShift action_171
action_141 (175) = happyAccept
action_141 _ = happyFail

action_142 (156) = happyShift action_171
action_142 (175) = happyAccept
action_142 _ = happyFail

action_143 (156) = happyShift action_171
action_143 (175) = happyAccept
action_143 _ = happyFail

action_144 (156) = happyShift action_171
action_144 (175) = happyAccept
action_144 _ = happyFail

action_145 (156) = happyShift action_171
action_145 (175) = happyAccept
action_145 _ = happyFail

action_146 (156) = happyShift action_171
action_146 (175) = happyAccept
action_146 _ = happyFail

action_147 (156) = happyShift action_171
action_147 (175) = happyAccept
action_147 _ = happyFail

action_148 (156) = happyShift action_171
action_148 (175) = happyAccept
action_148 _ = happyFail

action_149 (156) = happyShift action_171
action_149 (175) = happyAccept
action_149 _ = happyFail

action_150 (156) = happyShift action_171
action_150 (175) = happyAccept
action_150 _ = happyFail

action_151 (156) = happyShift action_171
action_151 (175) = happyAccept
action_151 _ = happyFail

action_152 (156) = happyShift action_171
action_152 (175) = happyAccept
action_152 _ = happyFail

action_153 (156) = happyShift action_171
action_153 (175) = happyAccept
action_153 _ = happyFail

action_154 (156) = happyShift action_171
action_154 (175) = happyAccept
action_154 _ = happyFail

action_155 (156) = happyShift action_171
action_155 (175) = happyAccept
action_155 _ = happyFail

action_156 (156) = happyShift action_171
action_156 (175) = happyAccept
action_156 _ = happyFail

action_157 (156) = happyShift action_171
action_157 (175) = happyAccept
action_157 _ = happyFail

action_158 (156) = happyShift action_171
action_158 (175) = happyAccept
action_158 _ = happyFail

action_159 (156) = happyShift action_171
action_159 (175) = happyAccept
action_159 _ = happyFail

action_160 (156) = happyShift action_171
action_160 (175) = happyAccept
action_160 _ = happyFail

action_161 (156) = happyShift action_171
action_161 (175) = happyAccept
action_161 _ = happyFail

action_162 (156) = happyShift action_171
action_162 (175) = happyAccept
action_162 _ = happyFail

action_163 (156) = happyShift action_171
action_163 (175) = happyAccept
action_163 _ = happyFail

action_164 (156) = happyShift action_171
action_164 (175) = happyAccept
action_164 _ = happyFail

action_165 (156) = happyShift action_171
action_165 (175) = happyAccept
action_165 _ = happyFail

action_166 (156) = happyShift action_171
action_166 (175) = happyAccept
action_166 _ = happyFail

action_167 (156) = happyShift action_171
action_167 (175) = happyAccept
action_167 _ = happyFail

action_168 (156) = happyShift action_171
action_168 (175) = happyAccept
action_168 _ = happyFail

action_169 (156) = happyShift action_171
action_169 (175) = happyAccept
action_169 _ = happyFail

action_170 (156) = happyShift action_171
action_170 (175) = happyAccept
action_170 _ = happyFail

action_171 (125) = happyShift action_172
action_171 _ = happyFail

action_172 _ = happyReduce_85

happyReduce_83 = happySpecReduce_1  86 happyReduction_83
happyReduction_83 (HappyAbsSyn87  happy_var_1)
	 =  HappyAbsSyn86
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  86 happyReduction_84
happyReduction_84 (HappyAbsSyn88  happy_var_1)
	 =  HappyAbsSyn86
		 (happy_var_1
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_3  87 happyReduction_85
happyReduction_85 (HappyTerminal (IDENTIFIER happy_var_3))
	_
	(HappyAbsSyn86  happy_var_1)
	 =  HappyAbsSyn87
		 (QualifiedName(happy_var_1, Identifier(happy_var_3))
	)
happyReduction_85 _ _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  88 happyReduction_86
happyReduction_86 (HappyTerminal (IDENTIFIER happy_var_1))
	 =  HappyAbsSyn88
		 (SimpleName(Identifier(happy_var_1))
	)
happyReduction_86 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 175 175 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	ABSTRACT -> cont 89;
	BOOLEAN -> cont 90;
	BREAK -> cont 91;
	CASE -> cont 92;
	CATCH -> cont 93;
	CHAR -> cont 94;
	CLASS -> cont 95;
	CONTINUE -> cont 96;
	DEFAULT -> cont 97;
	DO -> cont 98;
	ELSE -> cont 99;
	EXTENDS -> cont 100;
	FINALLY -> cont 101;
	FOR -> cont 102;
	IF -> cont 103;
	INSTANCEOF -> cont 104;
	INT -> cont 105;
	NEW -> cont 106;
	PRIVATE -> cont 107;
	PROTECTED -> cont 108;
	PUBLIC -> cont 109;
	RETURN -> cont 110;
	STATIC -> cont 111;
	SUPER -> cont 112;
	SWITCH -> cont 113;
	THIS -> cont 114;
	THROW -> cont 115;
	THROWS -> cont 116;
	TRY -> cont 117;
	VOID -> cont 118;
	WHILE -> cont 119;
	INTLITERAL happy_dollar_dollar -> cont 120;
	BOOLLITERAL happy_dollar_dollar -> cont 121;
	JNULL -> cont 122;
	CHARLITERAL happy_dollar_dollar -> cont 123;
	STRINGLITERAL happy_dollar_dollar -> cont 124;
	IDENTIFIER happy_dollar_dollar -> cont 125;
	EQUAL -> cont 126;
	LESSEQUAL -> cont 127;
	GREATEREQUAL -> cont 128;
	NOTEQUAL -> cont 129;
	LOGICALOR -> cont 130;
	LOGICALAND -> cont 131;
	INCREMENT -> cont 132;
	DECREMENT -> cont 133;
	SHIFTLEFT -> cont 134;
	SHIFTRIGHT -> cont 135;
	UNSIGNEDSHIFTRIGHT -> cont 136;
	SIGNEDSHIFTRIGHT -> cont 137;
	PLUSEQUAL -> cont 138;
	MINUSEQUAL -> cont 139;
	TIMESEQUAL -> cont 140;
	DIVIDEEQUAL -> cont 141;
	ANDEQUAL -> cont 142;
	OREQUAL -> cont 143;
	XOREQUAL -> cont 144;
	MODULOEQUAL -> cont 145;
	SHIFTLEFTEQUAL -> cont 146;
	SIGNEDSHIFTRIGHTEQUAL -> cont 147;
	UNSIGNEDSHIFTRIGHTEQUAL -> cont 148;
	LBRACE -> cont 149;
	RBRACE -> cont 150;
	LBRACKET -> cont 151;
	RBRACKET -> cont 152;
	LSQBRACKET -> cont 153;
	RSQBRACKET -> cont 154;
	SEMICOLON -> cont 155;
	DOT -> cont 156;
	ASSIGN -> cont 157;
	LESS -> cont 158;
	GREATER -> cont 159;
	EXCLMARK -> cont 160;
	TILDE -> cont 161;
	QUESMARK -> cont 162;
	COLON -> cont 163;
	PLUS -> cont 164;
	MINUS -> cont 165;
	MUL -> cont 166;
	DIV -> cont 167;
	MOD -> cont 168;
	AND -> cont 169;
	OR -> cont 170;
	XOR -> cont 171;
	SHARP -> cont 172;
	ARROW -> cont 173;
	COMMA -> cont 174;
	_ -> happyError' (tk:tks)
	}

happyError_ 175 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = return
    (<*>) = ap
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

compilationunit tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

typedeclarations tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

name tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_2 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

typedeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_3 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

qualifiedname tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_4 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

simplename tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_5 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classdeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_6 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classbody tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_7 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

modifiers tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_8 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

modifier tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_9 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classbodydeclarations tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_10 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classtype tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_11 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classbodydeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_12 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classorinterfacetype tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_13 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classmemberdeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_14 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

constructordeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_15 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

fielddeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_16 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

methoddeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_17 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

block tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_18 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

constructordeclarator tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_19 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

constructorbody tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_20 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

methodheader tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_21 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

variabledeclarators tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_22 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

methodbody tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_23 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

blockstatements tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_24 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

formalparameterlist tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_25 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

explicitconstructorinvocation tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_26 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classtypelist tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_27 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

methoddeclarator tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_28 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

primitivetype tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_29 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

referencetype tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_30 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

variabledeclarator tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_31 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

blockstatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_32 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

formalparameter tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_33 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

argumentlist tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_34 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

numerictype tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_35 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

variabledeclaratorid tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_36 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

variableinitializer tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_37 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

localvariabledeclarationstatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_38 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

statement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_39 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

expression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_40 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

integraltype tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_41 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

localvariabledeclaration tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_42 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

statementwithouttrailingsubstatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_43 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

ifthenstatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_44 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

ifthenelsestatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_45 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

whilestatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_46 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

assignmentexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_47 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

emptystatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_48 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

expressionstatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_49 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

returnstatement tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_50 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

statementnoshortif tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_51 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

conditionalexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_52 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

assignment tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_53 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

statementexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_54 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

ifthenelsestatementnoshortif tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_55 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

whilestatementnoshortif tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_56 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

conditionalorexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_57 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

lefthandside tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_58 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

assignmentoperator tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_59 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

preincrementexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_60 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

predecrementexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_61 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

postincrementexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_62 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

postdecrementexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_63 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

methodinvocation tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_64 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

classinstancecreationexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_65 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

conditionalandexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_66 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

fieldaccess tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_67 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

unaryexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_68 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

postfixexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_69 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

primary tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_70 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

inclusiveorexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_71 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

primarynonewarray tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_72 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

unaryexpressionnotplusminus tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_73 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

exclusiveorexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_74 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

literal tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_75 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

castexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_76 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

andexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_77 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

equalityexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_78 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

relationalexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_79 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

shiftexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_80 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

additiveexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_81 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

multiplicativeexpression tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_82 tks) (\x -> case x of {HappyAbsSyn86 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parse = name . alexScanTokens
parseError :: [Token] -> a
parseError _ = error "Parse error"
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
# 1 "/usr/include/stdc-predef.h" 1 3 4

# 17 "/usr/include/stdc-predef.h" 3 4















































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "/usr/lib/ghc-7.10.3/include/ghcversion.h" #-}

















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 

{-# LINE 13 "templates/GenericTemplate.hs" #-}

{-# LINE 46 "templates/GenericTemplate.hs" #-}








{-# LINE 67 "templates/GenericTemplate.hs" #-}

{-# LINE 77 "templates/GenericTemplate.hs" #-}

{-# LINE 86 "templates/GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 256 "templates/GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 322 "templates/GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
