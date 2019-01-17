{-# OPTIONS_GHC -Wall #-}

import Data.Array
import Data.List
import Data.Ord (comparing)

-- via https://wiki.haskell.org/Euler_problems/11_to_20
syrs :: Integer -> Array Integer Integer
syrs n = a
  where
    a = listArray (1, n) $ 0 : map syr [2 .. n]
    syr x
        | collatz <= n = 1 + a ! collatz
        | otherwise = 1 + syr collatz
        -- collatz = if even x then x `div` 2 else 3 * x + 1
      where
        collatz
            | even x = x `div` 2
            | otherwise = 3 * x + 1

main :: IO ()
main = do
    let limit = 1000000 :: Integer
    print $ maximumBy (comparing snd) . assocs . syrs $ limit
