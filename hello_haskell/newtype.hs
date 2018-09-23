{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE DerivingStrategies #-}

newtype NewInt = NewInt Int
    deriving (Eq, Ord, Show, Bounded)
    deriving newtype Read

instance Num NewInt where
    fromInteger a       = NewInt $ fromInteger a
    negate a            = fromInteger (-1) * a
    abs (NewInt a)      = NewInt $ abs a
    NewInt a + NewInt b = NewInt (a + b)
    NewInt a * NewInt b = NewInt (a * b)
    signum              = error "A very helpful error message!"

myFun :: NewInt -> Int -> (NewInt, Int)
myFun myNewInt myInt = (myPower, myInt)
  where myPower      = myNewInt ^ (3 :: Int)

main :: IO ()
main = do
    let myInt'   =        (-3) * (negate $ abs $ 1 - 2)
    let myNewInt = NewInt (-3) * (negate $ abs $ NewInt 1 - NewInt 2)
    let myRead   = read "1" :: NewInt
    print $ myFun myNewInt myInt'     -- via Show (needed for any 'print'!)
    print $ (NewInt 3) /= (NewInt 4)  -- via Eq
    print $ myRead + (NewInt 3)       -- via Read
    print $ NewInt 3 < NewInt 0       -- via Ord
    print $ max (NewInt 3) (NewInt 4) -- via Ord
    print $ (maxBound :: NewInt)      -- via Bounded
