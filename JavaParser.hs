{-# OPTIONS_GHC -w #-}
module JavaParser (parse) where
import AbsSyn
import JavaLexer
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.5

data HappyAbsSyn t5 t6 t7
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7

action_0 (44) = happyShift action_6
action_0 (5) = happyGoto action_8
action_0 (6) = happyGoto action_4
action_0 (7) = happyGoto action_5
action_0 _ = happyFail

action_1 (44) = happyShift action_6
action_1 (5) = happyGoto action_7
action_1 (6) = happyGoto action_4
action_1 (7) = happyGoto action_5
action_1 _ = happyFail

action_2 (44) = happyShift action_6
action_2 (5) = happyGoto action_3
action_2 (6) = happyGoto action_4
action_2 (7) = happyGoto action_5
action_2 _ = happyFail

action_3 (75) = happyShift action_9
action_3 _ = happyFail

action_4 _ = happyReduce_2

action_5 _ = happyReduce_3

action_6 _ = happyReduce_5

action_7 (75) = happyShift action_9
action_7 (94) = happyAccept
action_7 _ = happyFail

action_8 (75) = happyShift action_9
action_8 (94) = happyAccept
action_8 _ = happyFail

action_9 (44) = happyShift action_10
action_9 _ = happyFail

action_10 _ = happyReduce_4

happyReduce_2 = happySpecReduce_1  5 happyReduction_2
happyReduction_2 _
	 =  HappyAbsSyn5
		 (
	)

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 _
	 =  HappyAbsSyn5
		 (
	)

happyReduce_4 = happySpecReduce_3  6 happyReduction_4
happyReduction_4 (HappyTerminal (IDENTIFIER happy_var_3))
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (QualifiedName(happy_var_1, happy_var_3)
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  7 happyReduction_5
happyReduction_5 (HappyTerminal (IDENTIFIER happy_var_1))
	 =  HappyAbsSyn7
		 (happy_var_1
	)
happyReduction_5 _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 94 94 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	ABSTRACT -> cont 8;
	BOOLEAN -> cont 9;
	BREAK -> cont 10;
	CASE -> cont 11;
	CATCH -> cont 12;
	CHAR -> cont 13;
	CLASS -> cont 14;
	CONTINUE -> cont 15;
	DEFAULT -> cont 16;
	DO -> cont 17;
	ELSE -> cont 18;
	EXTENDS -> cont 19;
	FINALLY -> cont 20;
	FOR -> cont 21;
	IF -> cont 22;
	INSTANCEOF -> cont 23;
	INT -> cont 24;
	NEW -> cont 25;
	PRIVATE -> cont 26;
	PROTECTED -> cont 27;
	PUBLIC -> cont 28;
	RETURN -> cont 29;
	STATIC -> cont 30;
	SUPER -> cont 31;
	SWITCH -> cont 32;
	THIS -> cont 33;
	THROW -> cont 34;
	THROWS -> cont 35;
	TRY -> cont 36;
	VOID -> cont 37;
	WHILE -> cont 38;
	INTLITERAL happy_dollar_dollar -> cont 39;
	BOOLLITERAL happy_dollar_dollar -> cont 40;
	JNULL -> cont 41;
	CHARLITERAL happy_dollar_dollar -> cont 42;
	STRINGLITERAL happy_dollar_dollar -> cont 43;
	IDENTIFIER happy_dollar_dollar -> cont 44;
	EQUAL -> cont 45;
	LESSEQUAL -> cont 46;
	GREATEREQUAL -> cont 47;
	NOTEQUAL -> cont 48;
	LOGICALOR -> cont 49;
	LOGICALAND -> cont 50;
	INCREMENT -> cont 51;
	DECREMENT -> cont 52;
	SHIFTLEFT -> cont 53;
	SHIFTRIGHT -> cont 54;
	UNSIGNEDSHIFTRIGHT -> cont 55;
	SIGNEDSHIFTRIGHT -> cont 56;
	PLUSEQUAL -> cont 57;
	MINUSEQUAL -> cont 58;
	TIMESEQUAL -> cont 59;
	DIVIDEEQUAL -> cont 60;
	ANDEQUAL -> cont 61;
	OREQUAL -> cont 62;
	XOREQUAL -> cont 63;
	MODULOEQUAL -> cont 64;
	SHIFTLEFTEQUAL -> cont 65;
	SIGNEDSHIFTRIGHTEQUAL -> cont 66;
	UNSIGNEDSHIFTRIGHTEQUAL -> cont 67;
	LBRACE -> cont 68;
	RBRACE -> cont 69;
	LBRACKET -> cont 70;
	RBRACKET -> cont 71;
	LSQBRACKET -> cont 72;
	RSQBRACKET -> cont 73;
	SEMICOLON -> cont 74;
	DOT -> cont 75;
	ASSIGN -> cont 76;
	LESS -> cont 77;
	GREATER -> cont 78;
	EXCLMARK -> cont 79;
	TILDE -> cont 80;
	QUESMARK -> cont 81;
	COLON -> cont 82;
	PLUS -> cont 83;
	MINUS -> cont 84;
	MUL -> cont 85;
	DIV -> cont 86;
	MOD -> cont 87;
	AND -> cont 88;
	OR -> cont 89;
	XOR -> cont 90;
	SHARP -> cont 91;
	ARROW -> cont 92;
	COMMA -> cont 93;
	_ -> happyError' (tk:tks)
	}

happyError_ 94 tk tks = happyError' tks
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

jparse tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn5 z -> happyReturn z; _other -> notHappyAtAll })

name tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_1 tks) (\x -> case x of {HappyAbsSyn5 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


jparse :: String -> Name
jparse = name . alexScanTokens
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
