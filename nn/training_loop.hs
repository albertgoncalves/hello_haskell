{-# OPTIONS_GHC -Wall #-}

newtype NumLoops = NumLoops Int
newtype LoopVal  = LoopVal  Double deriving (Show)
newtype Constant = Constant Double

f' :: Constant -> Maybe LoopVal -> Maybe LoopVal
f' (Constant c) (Just (LoopVal x)) = Just $ LoopVal (x - (x * c))
f' _            _                  = Nothing

validateN :: NumLoops -> Maybe Int
validateN (NumLoops n)
    | n <= 0    = Nothing
    | otherwise = Just n

loopFun :: (Constant -> Maybe LoopVal -> Maybe LoopVal) ->
           NumLoops -> LoopVal -> Constant -> Maybe LoopVal
loopFun f n x c = do n' <- validateN n
                     foldr f (Just x) $ replicate n' c

main :: IO ()
main = do
    let x' = LoopVal  1.0
    let c' = Constant 10.0

    print $ loopFun f' (NumLoops 10) x' c'
    print $ loopFun f' (NumLoops 0 ) x' c' -- returns 'Nothing' --> can't run a
                                           -- loop zero/negative times!
