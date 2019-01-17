{-# OPTIONS_GHC -Wall #-}

fac :: Integral a => a -> a -> a
fac x acc
    | x <= 1 = acc
    | otherwise = fac (x - 1) (x * acc)

main :: IO ()
main = print $ fac (20 :: Integer) (1 :: Integer)
