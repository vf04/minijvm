{-# OPTIONS_GHC -w #-}
module JavaParser (parse) where
import AbsSyn
import JavaLexer
import JavaParserHelper
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t86 t87 t88 t89 t90 t91 t92 t93 t94 t95 t96 t97 t98 t99 t100 t101 t102 t103 t104 t105 t106 t107 t108 t109 t110 t111 t112 t113 t114
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn86 t86
	| HappyAbsSyn87 t87
	| HappyAbsSyn88 t88
	| HappyAbsSyn89 t89
	| HappyAbsSyn90 t90
	| HappyAbsSyn91 t91
	| HappyAbsSyn92 t92
	| HappyAbsSyn93 t93
	| HappyAbsSyn94 t94
	| HappyAbsSyn95 t95
	| HappyAbsSyn96 t96
	| HappyAbsSyn97 t97
	| HappyAbsSyn98 t98
	| HappyAbsSyn99 t99
	| HappyAbsSyn100 t100
	| HappyAbsSyn101 t101
	| HappyAbsSyn102 t102
	| HappyAbsSyn103 t103
	| HappyAbsSyn104 t104
	| HappyAbsSyn105 t105
	| HappyAbsSyn106 t106
	| HappyAbsSyn107 t107
	| HappyAbsSyn108 t108
	| HappyAbsSyn109 t109
	| HappyAbsSyn110 t110
	| HappyAbsSyn111 t111
	| HappyAbsSyn112 t112
	| HappyAbsSyn113 t113
	| HappyAbsSyn114 t114

action_0 (121) = happyShift action_87
action_0 (86) = happyGoto action_170
action_0 (87) = happyGoto action_84
action_0 (89) = happyGoto action_85
action_0 (92) = happyGoto action_86
action_0 _ = happyFail

action_1 (121) = happyShift action_87
action_1 (86) = happyGoto action_169
action_1 (87) = happyGoto action_84
action_1 (89) = happyGoto action_85
action_1 (92) = happyGoto action_86
action_1 _ = happyFail

action_2 (121) = happyShift action_87
action_2 (86) = happyGoto action_168
action_2 (87) = happyGoto action_84
action_2 (89) = happyGoto action_85
action_2 (92) = happyGoto action_86
action_2 _ = happyFail

action_3 (121) = happyShift action_87
action_3 (86) = happyGoto action_167
action_3 (87) = happyGoto action_84
action_3 (89) = happyGoto action_85
action_3 (92) = happyGoto action_86
action_3 _ = happyFail

action_4 (121) = happyShift action_87
action_4 (86) = happyGoto action_166
action_4 (87) = happyGoto action_84
action_4 (89) = happyGoto action_85
action_4 (92) = happyGoto action_86
action_4 _ = happyFail

action_5 (121) = happyShift action_87
action_5 (86) = happyGoto action_165
action_5 (87) = happyGoto action_84
action_5 (89) = happyGoto action_85
action_5 (92) = happyGoto action_86
action_5 _ = happyFail

action_6 (121) = happyShift action_87
action_6 (86) = happyGoto action_164
action_6 (87) = happyGoto action_84
action_6 (89) = happyGoto action_85
action_6 (92) = happyGoto action_86
action_6 _ = happyFail

action_7 (121) = happyShift action_87
action_7 (86) = happyGoto action_163
action_7 (87) = happyGoto action_84
action_7 (89) = happyGoto action_85
action_7 (92) = happyGoto action_86
action_7 _ = happyFail

action_8 (121) = happyShift action_87
action_8 (86) = happyGoto action_162
action_8 (87) = happyGoto action_84
action_8 (89) = happyGoto action_85
action_8 (92) = happyGoto action_86
action_8 _ = happyFail

action_9 (121) = happyShift action_87
action_9 (86) = happyGoto action_161
action_9 (87) = happyGoto action_84
action_9 (89) = happyGoto action_85
action_9 (92) = happyGoto action_86
action_9 _ = happyFail

action_10 (121) = happyShift action_87
action_10 (86) = happyGoto action_160
action_10 (87) = happyGoto action_84
action_10 (89) = happyGoto action_85
action_10 (92) = happyGoto action_86
action_10 _ = happyFail

action_11 (121) = happyShift action_87
action_11 (86) = happyGoto action_159
action_11 (87) = happyGoto action_84
action_11 (89) = happyGoto action_85
action_11 (92) = happyGoto action_86
action_11 _ = happyFail

action_12 (121) = happyShift action_87
action_12 (86) = happyGoto action_158
action_12 (87) = happyGoto action_84
action_12 (89) = happyGoto action_85
action_12 (92) = happyGoto action_86
action_12 _ = happyFail

action_13 (121) = happyShift action_87
action_13 (86) = happyGoto action_157
action_13 (87) = happyGoto action_84
action_13 (89) = happyGoto action_85
action_13 (92) = happyGoto action_86
action_13 _ = happyFail

action_14 (121) = happyShift action_87
action_14 (86) = happyGoto action_156
action_14 (87) = happyGoto action_84
action_14 (89) = happyGoto action_85
action_14 (92) = happyGoto action_86
action_14 _ = happyFail

action_15 (121) = happyShift action_87
action_15 (86) = happyGoto action_155
action_15 (87) = happyGoto action_84
action_15 (89) = happyGoto action_85
action_15 (92) = happyGoto action_86
action_15 _ = happyFail

action_16 (121) = happyShift action_87
action_16 (86) = happyGoto action_154
action_16 (87) = happyGoto action_84
action_16 (89) = happyGoto action_85
action_16 (92) = happyGoto action_86
action_16 _ = happyFail

action_17 (121) = happyShift action_87
action_17 (86) = happyGoto action_153
action_17 (87) = happyGoto action_84
action_17 (89) = happyGoto action_85
action_17 (92) = happyGoto action_86
action_17 _ = happyFail

action_18 (121) = happyShift action_87
action_18 (86) = happyGoto action_152
action_18 (87) = happyGoto action_84
action_18 (89) = happyGoto action_85
action_18 (92) = happyGoto action_86
action_18 _ = happyFail

action_19 (121) = happyShift action_87
action_19 (86) = happyGoto action_151
action_19 (87) = happyGoto action_84
action_19 (89) = happyGoto action_85
action_19 (92) = happyGoto action_86
action_19 _ = happyFail

action_20 (121) = happyShift action_87
action_20 (86) = happyGoto action_150
action_20 (87) = happyGoto action_84
action_20 (89) = happyGoto action_85
action_20 (92) = happyGoto action_86
action_20 _ = happyFail

action_21 (121) = happyShift action_87
action_21 (86) = happyGoto action_149
action_21 (87) = happyGoto action_84
action_21 (89) = happyGoto action_85
action_21 (92) = happyGoto action_86
action_21 _ = happyFail

action_22 (121) = happyShift action_87
action_22 (86) = happyGoto action_148
action_22 (87) = happyGoto action_84
action_22 (89) = happyGoto action_85
action_22 (92) = happyGoto action_86
action_22 _ = happyFail

action_23 (121) = happyShift action_87
action_23 (86) = happyGoto action_147
action_23 (87) = happyGoto action_84
action_23 (89) = happyGoto action_85
action_23 (92) = happyGoto action_86
action_23 _ = happyFail

action_24 (121) = happyShift action_87
action_24 (86) = happyGoto action_146
action_24 (87) = happyGoto action_84
action_24 (89) = happyGoto action_85
action_24 (92) = happyGoto action_86
action_24 _ = happyFail

action_25 (121) = happyShift action_87
action_25 (86) = happyGoto action_145
action_25 (87) = happyGoto action_84
action_25 (89) = happyGoto action_85
action_25 (92) = happyGoto action_86
action_25 _ = happyFail

action_26 (121) = happyShift action_87
action_26 (86) = happyGoto action_144
action_26 (87) = happyGoto action_84
action_26 (89) = happyGoto action_85
action_26 (92) = happyGoto action_86
action_26 _ = happyFail

action_27 (121) = happyShift action_87
action_27 (86) = happyGoto action_143
action_27 (87) = happyGoto action_84
action_27 (89) = happyGoto action_85
action_27 (92) = happyGoto action_86
action_27 _ = happyFail

action_28 (121) = happyShift action_87
action_28 (86) = happyGoto action_142
action_28 (87) = happyGoto action_84
action_28 (89) = happyGoto action_85
action_28 (92) = happyGoto action_86
action_28 _ = happyFail

action_29 (121) = happyShift action_87
action_29 (86) = happyGoto action_141
action_29 (87) = happyGoto action_84
action_29 (89) = happyGoto action_85
action_29 (92) = happyGoto action_86
action_29 _ = happyFail

action_30 (121) = happyShift action_87
action_30 (86) = happyGoto action_140
action_30 (87) = happyGoto action_84
action_30 (89) = happyGoto action_85
action_30 (92) = happyGoto action_86
action_30 _ = happyFail

action_31 (121) = happyShift action_87
action_31 (86) = happyGoto action_139
action_31 (87) = happyGoto action_84
action_31 (89) = happyGoto action_85
action_31 (92) = happyGoto action_86
action_31 _ = happyFail

action_32 (121) = happyShift action_87
action_32 (86) = happyGoto action_138
action_32 (87) = happyGoto action_84
action_32 (89) = happyGoto action_85
action_32 (92) = happyGoto action_86
action_32 _ = happyFail

action_33 (121) = happyShift action_87
action_33 (86) = happyGoto action_137
action_33 (87) = happyGoto action_84
action_33 (89) = happyGoto action_85
action_33 (92) = happyGoto action_86
action_33 _ = happyFail

action_34 (121) = happyShift action_87
action_34 (86) = happyGoto action_136
action_34 (87) = happyGoto action_84
action_34 (89) = happyGoto action_85
action_34 (92) = happyGoto action_86
action_34 _ = happyFail

action_35 (121) = happyShift action_87
action_35 (86) = happyGoto action_135
action_35 (87) = happyGoto action_84
action_35 (89) = happyGoto action_85
action_35 (92) = happyGoto action_86
action_35 _ = happyFail

action_36 (121) = happyShift action_87
action_36 (86) = happyGoto action_134
action_36 (87) = happyGoto action_84
action_36 (89) = happyGoto action_85
action_36 (92) = happyGoto action_86
action_36 _ = happyFail

action_37 (121) = happyShift action_87
action_37 (86) = happyGoto action_133
action_37 (87) = happyGoto action_84
action_37 (89) = happyGoto action_85
action_37 (92) = happyGoto action_86
action_37 _ = happyFail

action_38 (121) = happyShift action_87
action_38 (86) = happyGoto action_132
action_38 (87) = happyGoto action_84
action_38 (89) = happyGoto action_85
action_38 (92) = happyGoto action_86
action_38 _ = happyFail

action_39 (121) = happyShift action_87
action_39 (86) = happyGoto action_131
action_39 (87) = happyGoto action_84
action_39 (89) = happyGoto action_85
action_39 (92) = happyGoto action_86
action_39 _ = happyFail

action_40 (121) = happyShift action_87
action_40 (86) = happyGoto action_130
action_40 (87) = happyGoto action_84
action_40 (89) = happyGoto action_85
action_40 (92) = happyGoto action_86
action_40 _ = happyFail

action_41 (121) = happyShift action_87
action_41 (86) = happyGoto action_129
action_41 (87) = happyGoto action_84
action_41 (89) = happyGoto action_85
action_41 (92) = happyGoto action_86
action_41 _ = happyFail

action_42 (121) = happyShift action_87
action_42 (86) = happyGoto action_128
action_42 (87) = happyGoto action_84
action_42 (89) = happyGoto action_85
action_42 (92) = happyGoto action_86
action_42 _ = happyFail

action_43 (121) = happyShift action_87
action_43 (86) = happyGoto action_127
action_43 (87) = happyGoto action_84
action_43 (89) = happyGoto action_85
action_43 (92) = happyGoto action_86
action_43 _ = happyFail

action_44 (121) = happyShift action_87
action_44 (86) = happyGoto action_126
action_44 (87) = happyGoto action_84
action_44 (89) = happyGoto action_85
action_44 (92) = happyGoto action_86
action_44 _ = happyFail

action_45 (121) = happyShift action_87
action_45 (86) = happyGoto action_125
action_45 (87) = happyGoto action_84
action_45 (89) = happyGoto action_85
action_45 (92) = happyGoto action_86
action_45 _ = happyFail

action_46 (121) = happyShift action_87
action_46 (86) = happyGoto action_124
action_46 (87) = happyGoto action_84
action_46 (89) = happyGoto action_85
action_46 (92) = happyGoto action_86
action_46 _ = happyFail

action_47 (121) = happyShift action_87
action_47 (86) = happyGoto action_123
action_47 (87) = happyGoto action_84
action_47 (89) = happyGoto action_85
action_47 (92) = happyGoto action_86
action_47 _ = happyFail

action_48 (121) = happyShift action_87
action_48 (86) = happyGoto action_122
action_48 (87) = happyGoto action_84
action_48 (89) = happyGoto action_85
action_48 (92) = happyGoto action_86
action_48 _ = happyFail

action_49 (121) = happyShift action_87
action_49 (86) = happyGoto action_121
action_49 (87) = happyGoto action_84
action_49 (89) = happyGoto action_85
action_49 (92) = happyGoto action_86
action_49 _ = happyFail

action_50 (121) = happyShift action_87
action_50 (86) = happyGoto action_120
action_50 (87) = happyGoto action_84
action_50 (89) = happyGoto action_85
action_50 (92) = happyGoto action_86
action_50 _ = happyFail

action_51 (121) = happyShift action_87
action_51 (86) = happyGoto action_119
action_51 (87) = happyGoto action_84
action_51 (89) = happyGoto action_85
action_51 (92) = happyGoto action_86
action_51 _ = happyFail

action_52 (121) = happyShift action_87
action_52 (86) = happyGoto action_118
action_52 (87) = happyGoto action_84
action_52 (89) = happyGoto action_85
action_52 (92) = happyGoto action_86
action_52 _ = happyFail

action_53 (121) = happyShift action_87
action_53 (86) = happyGoto action_117
action_53 (87) = happyGoto action_84
action_53 (89) = happyGoto action_85
action_53 (92) = happyGoto action_86
action_53 _ = happyFail

action_54 (121) = happyShift action_87
action_54 (86) = happyGoto action_116
action_54 (87) = happyGoto action_84
action_54 (89) = happyGoto action_85
action_54 (92) = happyGoto action_86
action_54 _ = happyFail

action_55 (121) = happyShift action_87
action_55 (86) = happyGoto action_115
action_55 (87) = happyGoto action_84
action_55 (89) = happyGoto action_85
action_55 (92) = happyGoto action_86
action_55 _ = happyFail

action_56 (121) = happyShift action_87
action_56 (86) = happyGoto action_114
action_56 (87) = happyGoto action_84
action_56 (89) = happyGoto action_85
action_56 (92) = happyGoto action_86
action_56 _ = happyFail

action_57 (121) = happyShift action_87
action_57 (86) = happyGoto action_113
action_57 (87) = happyGoto action_84
action_57 (89) = happyGoto action_85
action_57 (92) = happyGoto action_86
action_57 _ = happyFail

action_58 (121) = happyShift action_87
action_58 (86) = happyGoto action_112
action_58 (87) = happyGoto action_84
action_58 (89) = happyGoto action_85
action_58 (92) = happyGoto action_86
action_58 _ = happyFail

action_59 (121) = happyShift action_87
action_59 (86) = happyGoto action_111
action_59 (87) = happyGoto action_84
action_59 (89) = happyGoto action_85
action_59 (92) = happyGoto action_86
action_59 _ = happyFail

action_60 (121) = happyShift action_87
action_60 (86) = happyGoto action_110
action_60 (87) = happyGoto action_84
action_60 (89) = happyGoto action_85
action_60 (92) = happyGoto action_86
action_60 _ = happyFail

action_61 (121) = happyShift action_87
action_61 (86) = happyGoto action_109
action_61 (87) = happyGoto action_84
action_61 (89) = happyGoto action_85
action_61 (92) = happyGoto action_86
action_61 _ = happyFail

action_62 (121) = happyShift action_87
action_62 (86) = happyGoto action_108
action_62 (87) = happyGoto action_84
action_62 (89) = happyGoto action_85
action_62 (92) = happyGoto action_86
action_62 _ = happyFail

action_63 (121) = happyShift action_87
action_63 (86) = happyGoto action_107
action_63 (87) = happyGoto action_84
action_63 (89) = happyGoto action_85
action_63 (92) = happyGoto action_86
action_63 _ = happyFail

action_64 (121) = happyShift action_87
action_64 (86) = happyGoto action_106
action_64 (87) = happyGoto action_84
action_64 (89) = happyGoto action_85
action_64 (92) = happyGoto action_86
action_64 _ = happyFail

action_65 (121) = happyShift action_87
action_65 (86) = happyGoto action_105
action_65 (87) = happyGoto action_84
action_65 (89) = happyGoto action_85
action_65 (92) = happyGoto action_86
action_65 _ = happyFail

action_66 (121) = happyShift action_87
action_66 (86) = happyGoto action_104
action_66 (87) = happyGoto action_84
action_66 (89) = happyGoto action_85
action_66 (92) = happyGoto action_86
action_66 _ = happyFail

action_67 (121) = happyShift action_87
action_67 (86) = happyGoto action_103
action_67 (87) = happyGoto action_84
action_67 (89) = happyGoto action_85
action_67 (92) = happyGoto action_86
action_67 _ = happyFail

action_68 (121) = happyShift action_87
action_68 (86) = happyGoto action_102
action_68 (87) = happyGoto action_84
action_68 (89) = happyGoto action_85
action_68 (92) = happyGoto action_86
action_68 _ = happyFail

action_69 (121) = happyShift action_87
action_69 (86) = happyGoto action_101
action_69 (87) = happyGoto action_84
action_69 (89) = happyGoto action_85
action_69 (92) = happyGoto action_86
action_69 _ = happyFail

action_70 (121) = happyShift action_87
action_70 (86) = happyGoto action_100
action_70 (87) = happyGoto action_84
action_70 (89) = happyGoto action_85
action_70 (92) = happyGoto action_86
action_70 _ = happyFail

action_71 (121) = happyShift action_87
action_71 (86) = happyGoto action_99
action_71 (87) = happyGoto action_84
action_71 (89) = happyGoto action_85
action_71 (92) = happyGoto action_86
action_71 _ = happyFail

action_72 (121) = happyShift action_87
action_72 (86) = happyGoto action_98
action_72 (87) = happyGoto action_84
action_72 (89) = happyGoto action_85
action_72 (92) = happyGoto action_86
action_72 _ = happyFail

action_73 (121) = happyShift action_87
action_73 (86) = happyGoto action_97
action_73 (87) = happyGoto action_84
action_73 (89) = happyGoto action_85
action_73 (92) = happyGoto action_86
action_73 _ = happyFail

action_74 (121) = happyShift action_87
action_74 (86) = happyGoto action_96
action_74 (87) = happyGoto action_84
action_74 (89) = happyGoto action_85
action_74 (92) = happyGoto action_86
action_74 _ = happyFail

action_75 (121) = happyShift action_87
action_75 (86) = happyGoto action_95
action_75 (87) = happyGoto action_84
action_75 (89) = happyGoto action_85
action_75 (92) = happyGoto action_86
action_75 _ = happyFail

action_76 (121) = happyShift action_87
action_76 (86) = happyGoto action_94
action_76 (87) = happyGoto action_84
action_76 (89) = happyGoto action_85
action_76 (92) = happyGoto action_86
action_76 _ = happyFail

action_77 (121) = happyShift action_87
action_77 (86) = happyGoto action_93
action_77 (87) = happyGoto action_84
action_77 (89) = happyGoto action_85
action_77 (92) = happyGoto action_86
action_77 _ = happyFail

action_78 (121) = happyShift action_87
action_78 (86) = happyGoto action_92
action_78 (87) = happyGoto action_84
action_78 (89) = happyGoto action_85
action_78 (92) = happyGoto action_86
action_78 _ = happyFail

action_79 (121) = happyShift action_87
action_79 (86) = happyGoto action_91
action_79 (87) = happyGoto action_84
action_79 (89) = happyGoto action_85
action_79 (92) = happyGoto action_86
action_79 _ = happyFail

action_80 (121) = happyShift action_87
action_80 (86) = happyGoto action_90
action_80 (87) = happyGoto action_84
action_80 (89) = happyGoto action_85
action_80 (92) = happyGoto action_86
action_80 _ = happyFail

action_81 (121) = happyShift action_87
action_81 (86) = happyGoto action_89
action_81 (87) = happyGoto action_84
action_81 (89) = happyGoto action_85
action_81 (92) = happyGoto action_86
action_81 _ = happyFail

action_82 (121) = happyShift action_87
action_82 (86) = happyGoto action_88
action_82 (87) = happyGoto action_84
action_82 (89) = happyGoto action_85
action_82 (92) = happyGoto action_86
action_82 _ = happyFail

action_83 (121) = happyShift action_87
action_83 (87) = happyGoto action_84
action_83 (89) = happyGoto action_85
action_83 (92) = happyGoto action_86
action_83 _ = happyFail

action_84 (121) = happyShift action_87
action_84 (89) = happyGoto action_172
action_84 (92) = happyGoto action_86
action_84 _ = happyReduce_83

action_85 _ = happyReduce_84

action_86 _ = happyReduce_88

action_87 (151) = happyShift action_171
action_87 _ = happyFail

action_88 (201) = happyAccept
action_88 _ = happyFail

action_89 (201) = happyAccept
action_89 _ = happyFail

action_90 (201) = happyAccept
action_90 _ = happyFail

action_91 (201) = happyAccept
action_91 _ = happyFail

action_92 (201) = happyAccept
action_92 _ = happyFail

action_93 (201) = happyAccept
action_93 _ = happyFail

action_94 (201) = happyAccept
action_94 _ = happyFail

action_95 (201) = happyAccept
action_95 _ = happyFail

action_96 (201) = happyAccept
action_96 _ = happyFail

action_97 (201) = happyAccept
action_97 _ = happyFail

action_98 (201) = happyAccept
action_98 _ = happyFail

action_99 (201) = happyAccept
action_99 _ = happyFail

action_100 (201) = happyAccept
action_100 _ = happyFail

action_101 (201) = happyAccept
action_101 _ = happyFail

action_102 (201) = happyAccept
action_102 _ = happyFail

action_103 (201) = happyAccept
action_103 _ = happyFail

action_104 (201) = happyAccept
action_104 _ = happyFail

action_105 (201) = happyAccept
action_105 _ = happyFail

action_106 (201) = happyAccept
action_106 _ = happyFail

action_107 (201) = happyAccept
action_107 _ = happyFail

action_108 (201) = happyAccept
action_108 _ = happyFail

action_109 (201) = happyAccept
action_109 _ = happyFail

action_110 (201) = happyAccept
action_110 _ = happyFail

action_111 (201) = happyAccept
action_111 _ = happyFail

action_112 (201) = happyAccept
action_112 _ = happyFail

action_113 (201) = happyAccept
action_113 _ = happyFail

action_114 (201) = happyAccept
action_114 _ = happyFail

action_115 (201) = happyAccept
action_115 _ = happyFail

action_116 (201) = happyAccept
action_116 _ = happyFail

action_117 (201) = happyAccept
action_117 _ = happyFail

action_118 (201) = happyAccept
action_118 _ = happyFail

action_119 (201) = happyAccept
action_119 _ = happyFail

action_120 (201) = happyAccept
action_120 _ = happyFail

action_121 (201) = happyAccept
action_121 _ = happyFail

action_122 (201) = happyAccept
action_122 _ = happyFail

action_123 (201) = happyAccept
action_123 _ = happyFail

action_124 (201) = happyAccept
action_124 _ = happyFail

action_125 (201) = happyAccept
action_125 _ = happyFail

action_126 (201) = happyAccept
action_126 _ = happyFail

action_127 (201) = happyAccept
action_127 _ = happyFail

action_128 (201) = happyAccept
action_128 _ = happyFail

action_129 (201) = happyAccept
action_129 _ = happyFail

action_130 (201) = happyAccept
action_130 _ = happyFail

action_131 (201) = happyAccept
action_131 _ = happyFail

action_132 (201) = happyAccept
action_132 _ = happyFail

action_133 (201) = happyAccept
action_133 _ = happyFail

action_134 (201) = happyAccept
action_134 _ = happyFail

action_135 (201) = happyAccept
action_135 _ = happyFail

action_136 (201) = happyAccept
action_136 _ = happyFail

action_137 (201) = happyAccept
action_137 _ = happyFail

action_138 (201) = happyAccept
action_138 _ = happyFail

action_139 (201) = happyAccept
action_139 _ = happyFail

action_140 (201) = happyAccept
action_140 _ = happyFail

action_141 (201) = happyAccept
action_141 _ = happyFail

action_142 (201) = happyAccept
action_142 _ = happyFail

action_143 (201) = happyAccept
action_143 _ = happyFail

action_144 (201) = happyAccept
action_144 _ = happyFail

action_145 (201) = happyAccept
action_145 _ = happyFail

action_146 (201) = happyAccept
action_146 _ = happyFail

action_147 (201) = happyAccept
action_147 _ = happyFail

action_148 (201) = happyAccept
action_148 _ = happyFail

action_149 (201) = happyAccept
action_149 _ = happyFail

action_150 (201) = happyAccept
action_150 _ = happyFail

action_151 (201) = happyAccept
action_151 _ = happyFail

action_152 (201) = happyAccept
action_152 _ = happyFail

action_153 (201) = happyAccept
action_153 _ = happyFail

action_154 (201) = happyAccept
action_154 _ = happyFail

action_155 (201) = happyAccept
action_155 _ = happyFail

action_156 (201) = happyAccept
action_156 _ = happyFail

action_157 (201) = happyAccept
action_157 _ = happyFail

action_158 (201) = happyAccept
action_158 _ = happyFail

action_159 (201) = happyAccept
action_159 _ = happyFail

action_160 (201) = happyAccept
action_160 _ = happyFail

action_161 (201) = happyAccept
action_161 _ = happyFail

action_162 (201) = happyAccept
action_162 _ = happyFail

action_163 (201) = happyAccept
action_163 _ = happyFail

action_164 (201) = happyAccept
action_164 _ = happyFail

action_165 (201) = happyAccept
action_165 _ = happyFail

action_166 (201) = happyAccept
action_166 _ = happyFail

action_167 (201) = happyAccept
action_167 _ = happyFail

action_168 (201) = happyAccept
action_168 _ = happyFail

action_169 (201) = happyAccept
action_169 _ = happyFail

action_170 (201) = happyAccept
action_170 _ = happyFail

action_171 (177) = happyShift action_174
action_171 (93) = happyGoto action_173
action_171 _ = happyFail

action_172 _ = happyReduce_85

action_173 _ = happyReduce_91

action_174 (116) = happyShift action_185
action_174 (120) = happyShift action_186
action_174 (131) = happyShift action_187
action_174 (178) = happyShift action_188
action_174 (95) = happyGoto action_175
action_174 (97) = happyGoto action_176
action_174 (99) = happyGoto action_177
action_174 (100) = happyGoto action_178
action_174 (101) = happyGoto action_179
action_174 (105) = happyGoto action_180
action_174 (106) = happyGoto action_181
action_174 (108) = happyGoto action_182
action_174 (109) = happyGoto action_183
action_174 (110) = happyGoto action_184
action_174 _ = happyFail

action_175 (116) = happyShift action_185
action_175 (120) = happyShift action_186
action_175 (131) = happyShift action_187
action_175 (178) = happyShift action_198
action_175 (97) = happyGoto action_197
action_175 (99) = happyGoto action_177
action_175 (100) = happyGoto action_178
action_175 (101) = happyGoto action_179
action_175 (105) = happyGoto action_180
action_175 (106) = happyGoto action_181
action_175 (108) = happyGoto action_182
action_175 (109) = happyGoto action_183
action_175 (110) = happyGoto action_184
action_175 _ = happyFail

action_176 _ = happyReduce_96

action_177 _ = happyReduce_103

action_178 _ = happyReduce_105

action_179 (151) = happyShift action_196
action_179 (102) = happyGoto action_192
action_179 (103) = happyGoto action_193
action_179 (104) = happyGoto action_194
action_179 (112) = happyGoto action_195
action_179 _ = happyFail

action_180 _ = happyReduce_106

action_181 (177) = happyShift action_191
action_181 (107) = happyGoto action_189
action_181 (111) = happyGoto action_190
action_181 _ = happyFail

action_182 _ = happyReduce_108

action_183 _ = happyReduce_117

action_184 _ = happyReduce_118

action_185 _ = happyReduce_116

action_186 _ = happyReduce_120

action_187 _ = happyReduce_119

action_188 _ = happyReduce_92

action_189 _ = happyReduce_113

action_190 _ = happyReduce_115

action_191 (178) = happyShift action_202
action_191 _ = happyFail

action_192 (181) = happyShift action_200
action_192 (200) = happyShift action_201
action_192 _ = happyFail

action_193 _ = happyReduce_109

action_194 _ = happyReduce_111

action_195 _ = happyReduce_114

action_196 (175) = happyShift action_199
action_196 _ = happyReduce_112

action_197 _ = happyReduce_97

action_198 _ = happyReduce_93

action_199 (116) = happyShift action_185
action_199 (120) = happyShift action_186
action_199 (131) = happyShift action_187
action_199 (176) = happyShift action_208
action_199 (101) = happyGoto action_205
action_199 (108) = happyGoto action_182
action_199 (109) = happyGoto action_183
action_199 (110) = happyGoto action_184
action_199 (113) = happyGoto action_206
action_199 (114) = happyGoto action_207
action_199 _ = happyFail

action_200 _ = happyReduce_107

action_201 (151) = happyShift action_204
action_201 (103) = happyGoto action_203
action_201 (104) = happyGoto action_194
action_201 _ = happyFail

action_202 _ = happyReduce_121

action_203 _ = happyReduce_110

action_204 _ = happyReduce_112

action_205 (151) = happyShift action_204
action_205 (104) = happyGoto action_211
action_205 _ = happyFail

action_206 (176) = happyShift action_209
action_206 (200) = happyShift action_210
action_206 _ = happyFail

action_207 _ = happyReduce_124

action_208 _ = happyReduce_122

action_209 _ = happyReduce_123

action_210 (116) = happyShift action_185
action_210 (120) = happyShift action_186
action_210 (131) = happyShift action_187
action_210 (101) = happyGoto action_205
action_210 (108) = happyGoto action_182
action_210 (109) = happyGoto action_183
action_210 (110) = happyGoto action_184
action_210 (114) = happyGoto action_212
action_210 _ = happyFail

action_211 _ = happyReduce_126

action_212 _ = happyReduce_125

happyReduce_83 = happySpecReduce_1  86 happyReduction_83
happyReduction_83 (HappyAbsSyn87  happy_var_1)
	 =  HappyAbsSyn86
		 (happy_var_1
	)
happyReduction_83 _  = notHappyAtAll 

happyReduce_84 = happySpecReduce_1  87 happyReduction_84
happyReduction_84 (HappyAbsSyn89  happy_var_1)
	 =  HappyAbsSyn87
		 ([happy_var_1]
	)
happyReduction_84 _  = notHappyAtAll 

happyReduce_85 = happySpecReduce_2  87 happyReduction_85
happyReduction_85 (HappyAbsSyn89  happy_var_2)
	(HappyAbsSyn87  happy_var_1)
	 =  HappyAbsSyn87
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_85 _ _  = notHappyAtAll 

happyReduce_86 = happySpecReduce_1  88 happyReduction_86
happyReduction_86 (HappyAbsSyn90  happy_var_1)
	 =  HappyAbsSyn88
		 (happy_var_1
	)
happyReduction_86 _  = notHappyAtAll 

happyReduce_87 = happySpecReduce_1  88 happyReduction_87
happyReduction_87 (HappyAbsSyn91  happy_var_1)
	 =  HappyAbsSyn88
		 (happy_var_1
	)
happyReduction_87 _  = notHappyAtAll 

happyReduce_88 = happySpecReduce_1  89 happyReduction_88
happyReduction_88 (HappyAbsSyn92  happy_var_1)
	 =  HappyAbsSyn89
		 (happy_var_1
	)
happyReduction_88 _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  90 happyReduction_89
happyReduction_89 (HappyTerminal (IDENTIFIER happy_var_3))
	_
	(HappyAbsSyn88  happy_var_1)
	 =  HappyAbsSyn90
		 (happy_var_1 ++ [happy_var_3]
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_1  91 happyReduction_90
happyReduction_90 (HappyTerminal (IDENTIFIER happy_var_1))
	 =  HappyAbsSyn91
		 ([happy_var_1]
	)
happyReduction_90 _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  92 happyReduction_91
happyReduction_91 (HappyAbsSyn93  happy_var_3)
	(HappyTerminal (IDENTIFIER happy_var_2))
	_
	 =  HappyAbsSyn92
		 (Class(Type(happy_var_2), fst(happy_var_3), snd(happy_var_3))
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_2  93 happyReduction_92
happyReduction_92 _
	_
	 =  HappyAbsSyn93
		 (([], [])
	)

happyReduce_93 = happySpecReduce_3  93 happyReduction_93
happyReduction_93 _
	(HappyAbsSyn95  happy_var_2)
	_
	 =  HappyAbsSyn93
		 (happy_var_2
	)
happyReduction_93 _ _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_1  94 happyReduction_94
happyReduction_94 (HappyAbsSyn96  happy_var_1)
	 =  HappyAbsSyn94
		 ([happy_var_1]
	)
happyReduction_94 _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_2  94 happyReduction_95
happyReduction_95 (HappyAbsSyn96  happy_var_2)
	(HappyAbsSyn94  happy_var_1)
	 =  HappyAbsSyn94
		 (happy_var_1 ++ [happy_var_2]
	)
happyReduction_95 _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_1  95 happyReduction_96
happyReduction_96 (HappyAbsSyn97  happy_var_1)
	 =  HappyAbsSyn95
		 (happy_var_1
	)
happyReduction_96 _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_2  95 happyReduction_97
happyReduction_97 (HappyAbsSyn97  happy_var_2)
	(HappyAbsSyn95  happy_var_1)
	 =  HappyAbsSyn95
		 ((fst(happy_var_1) ++ fst(happy_var_2), snd(happy_var_1) ++ snd(happy_var_2))
	)
happyReduction_97 _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_1  96 happyReduction_98
happyReduction_98 _
	 =  HappyAbsSyn96
		 (Public
	)

happyReduce_99 = happySpecReduce_1  96 happyReduction_99
happyReduction_99 _
	 =  HappyAbsSyn96
		 (Protected
	)

happyReduce_100 = happySpecReduce_1  96 happyReduction_100
happyReduction_100 _
	 =  HappyAbsSyn96
		 (Private
	)

happyReduce_101 = happySpecReduce_1  96 happyReduction_101
happyReduction_101 _
	 =  HappyAbsSyn96
		 (Static
	)

happyReduce_102 = happySpecReduce_1  96 happyReduction_102
happyReduction_102 _
	 =  HappyAbsSyn96
		 (Abstract
	)

happyReduce_103 = happySpecReduce_1  97 happyReduction_103
happyReduction_103 (HappyAbsSyn99  happy_var_1)
	 =  HappyAbsSyn97
		 (happy_var_1
	)
happyReduction_103 _  = notHappyAtAll 

happyReduce_104 = happySpecReduce_1  98 happyReduction_104
happyReduction_104 (HappyAbsSyn88  happy_var_1)
	 =  HappyAbsSyn98
		 (happy_var_1
	)
happyReduction_104 _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_1  99 happyReduction_105
happyReduction_105 (HappyAbsSyn100  happy_var_1)
	 =  HappyAbsSyn99
		 (fieldDeclToList(happy_var_1)
	)
happyReduction_105 _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  99 happyReduction_106
happyReduction_106 (HappyAbsSyn105  happy_var_1)
	 =  HappyAbsSyn99
		 (methodDeclToList(happy_var_1)
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_3  100 happyReduction_107
happyReduction_107 _
	(HappyAbsSyn102  happy_var_2)
	(HappyAbsSyn101  happy_var_1)
	 =  HappyAbsSyn100
		 (FieldDecl(happy_var_1 , happy_var_2)
	)
happyReduction_107 _ _ _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_1  101 happyReduction_108
happyReduction_108 (HappyAbsSyn108  happy_var_1)
	 =  HappyAbsSyn101
		 (happy_var_1
	)
happyReduction_108 _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_1  102 happyReduction_109
happyReduction_109 (HappyAbsSyn103  happy_var_1)
	 =  HappyAbsSyn102
		 (happy_var_1
	)
happyReduction_109 _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_3  102 happyReduction_110
happyReduction_110 (HappyAbsSyn103  happy_var_3)
	_
	(HappyAbsSyn102  happy_var_1)
	 =  HappyAbsSyn102
		 (happy_var_1 ++ ", " ++ happy_var_3
	)
happyReduction_110 _ _ _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_1  103 happyReduction_111
happyReduction_111 (HappyAbsSyn104  happy_var_1)
	 =  HappyAbsSyn103
		 (happy_var_1
	)
happyReduction_111 _  = notHappyAtAll 

happyReduce_112 = happySpecReduce_1  104 happyReduction_112
happyReduction_112 (HappyTerminal (IDENTIFIER happy_var_1))
	 =  HappyAbsSyn104
		 (happy_var_1
	)
happyReduction_112 _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_2  105 happyReduction_113
happyReduction_113 (HappyAbsSyn107  happy_var_2)
	(HappyAbsSyn106  happy_var_1)
	 =  HappyAbsSyn105
		 (MethodDecl(fst(happy_var_1), fst(snd(happy_var_1)), snd(snd(happy_var_1)), happy_var_2)
	)
happyReduction_113 _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_2  106 happyReduction_114
happyReduction_114 (HappyAbsSyn112  happy_var_2)
	(HappyAbsSyn101  happy_var_1)
	 =  HappyAbsSyn106
		 ((happy_var_1, happy_var_2)
	)
happyReduction_114 _ _  = notHappyAtAll 

happyReduce_115 = happySpecReduce_1  107 happyReduction_115
happyReduction_115 _
	 =  HappyAbsSyn107
		 (Block([Empty])
	)

happyReduce_116 = happySpecReduce_1  108 happyReduction_116
happyReduction_116 _
	 =  HappyAbsSyn108
		 (Type("bool")
	)

happyReduce_117 = happySpecReduce_1  108 happyReduction_117
happyReduction_117 (HappyAbsSyn109  happy_var_1)
	 =  HappyAbsSyn108
		 (happy_var_1
	)
happyReduction_117 _  = notHappyAtAll 

happyReduce_118 = happySpecReduce_1  109 happyReduction_118
happyReduction_118 (HappyAbsSyn110  happy_var_1)
	 =  HappyAbsSyn109
		 (happy_var_1
	)
happyReduction_118 _  = notHappyAtAll 

happyReduce_119 = happySpecReduce_1  110 happyReduction_119
happyReduction_119 _
	 =  HappyAbsSyn110
		 (Type("int")
	)

happyReduce_120 = happySpecReduce_1  110 happyReduction_120
happyReduction_120 _
	 =  HappyAbsSyn110
		 (Type("char")
	)

happyReduce_121 = happySpecReduce_2  111 happyReduction_121
happyReduction_121 _
	_
	 =  HappyAbsSyn111
		 (Block([Empty])
	)

happyReduce_122 = happySpecReduce_3  112 happyReduction_122
happyReduction_122 _
	_
	(HappyTerminal (IDENTIFIER happy_var_1))
	 =  HappyAbsSyn112
		 ((happy_var_1, [])
	)
happyReduction_122 _ _ _  = notHappyAtAll 

happyReduce_123 = happyReduce 4 112 happyReduction_123
happyReduction_123 (_ `HappyStk`
	(HappyAbsSyn113  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (IDENTIFIER happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn112
		 ((happy_var_1, happy_var_3)
	) `HappyStk` happyRest

happyReduce_124 = happySpecReduce_1  113 happyReduction_124
happyReduction_124 (HappyAbsSyn114  happy_var_1)
	 =  HappyAbsSyn113
		 ([happy_var_1]
	)
happyReduction_124 _  = notHappyAtAll 

happyReduce_125 = happySpecReduce_3  113 happyReduction_125
happyReduction_125 (HappyAbsSyn114  happy_var_3)
	_
	(HappyAbsSyn113  happy_var_1)
	 =  HappyAbsSyn113
		 (happy_var_1 ++[happy_var_3]
	)
happyReduction_125 _ _ _  = notHappyAtAll 

happyReduce_126 = happySpecReduce_2  114 happyReduction_126
happyReduction_126 (HappyAbsSyn104  happy_var_2)
	(HappyAbsSyn101  happy_var_1)
	 =  HappyAbsSyn114
		 ((happy_var_1, happy_var_2)
	)
happyReduction_126 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 201 201 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	ABSTRACT -> cont 115;
	BOOLEAN -> cont 116;
	BREAK -> cont 117;
	CASE -> cont 118;
	CATCH -> cont 119;
	CHAR -> cont 120;
	CLASS -> cont 121;
	CONTINUE -> cont 122;
	DEFAULT -> cont 123;
	DO -> cont 124;
	ELSE -> cont 125;
	EXTENDS -> cont 126;
	FINALLY -> cont 127;
	FOR -> cont 128;
	IF -> cont 129;
	INSTANCEOF -> cont 130;
	INT -> cont 131;
	NEW -> cont 132;
	PRIVATE -> cont 133;
	PROTECTED -> cont 134;
	PUBLIC -> cont 135;
	RETURN -> cont 136;
	STATIC -> cont 137;
	SUPER -> cont 138;
	SWITCH -> cont 139;
	THIS -> cont 140;
	THROW -> cont 141;
	THROWS -> cont 142;
	TRY -> cont 143;
	VOID -> cont 144;
	WHILE -> cont 145;
	INTLITERAL happy_dollar_dollar -> cont 146;
	BOOLLITERAL happy_dollar_dollar -> cont 147;
	JNULL -> cont 148;
	CHARLITERAL happy_dollar_dollar -> cont 149;
	STRINGLITERAL happy_dollar_dollar -> cont 150;
	IDENTIFIER happy_dollar_dollar -> cont 151;
	EQUAL -> cont 152;
	LESSEQUAL -> cont 153;
	GREATEREQUAL -> cont 154;
	NOTEQUAL -> cont 155;
	LOGICALOR -> cont 156;
	LOGICALAND -> cont 157;
	INCREMENT -> cont 158;
	DECREMENT -> cont 159;
	SHIFTLEFT -> cont 160;
	SHIFTRIGHT -> cont 161;
	UNSIGNEDSHIFTRIGHT -> cont 162;
	SIGNEDSHIFTRIGHT -> cont 163;
	PLUSEQUAL -> cont 164;
	MINUSEQUAL -> cont 165;
	TIMESEQUAL -> cont 166;
	DIVIDEEQUAL -> cont 167;
	ANDEQUAL -> cont 168;
	OREQUAL -> cont 169;
	XOREQUAL -> cont 170;
	MODULOEQUAL -> cont 171;
	SHIFTLEFTEQUAL -> cont 172;
	SIGNEDSHIFTRIGHTEQUAL -> cont 173;
	UNSIGNEDSHIFTRIGHTEQUAL -> cont 174;
	LBRACE -> cont 175;
	RBRACE -> cont 176;
	LBRACKET -> cont 177;
	RBRACKET -> cont 178;
	LSQBRACKET -> cont 179;
	RSQBRACKET -> cont 180;
	SEMICOLON -> cont 181;
	DOT -> cont 182;
	ASSIGN -> cont 183;
	LESS -> cont 184;
	GREATER -> cont 185;
	EXCLMARK -> cont 186;
	TILDE -> cont 187;
	QUESMARK -> cont 188;
	COLON -> cont 189;
	PLUS -> cont 190;
	MINUS -> cont 191;
	MUL -> cont 192;
	DIV -> cont 193;
	MOD -> cont 194;
	AND -> cont 195;
	OR -> cont 196;
	XOR -> cont 197;
	SHARP -> cont 198;
	ARROW -> cont 199;
	COMMA -> cont 200;
	_ -> happyError' (tk:tks)
	}

happyError_ 201 tk tks = happyError' tks
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


parse = compilationunit . alexScanTokens

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
