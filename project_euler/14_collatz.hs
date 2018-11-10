{-# OPTIONS_GHC -Wall #-}

import Data.Function
import Data.List

collatz :: Integer -> Integer
collatz n
    | odd n     = (3 * n) + 1
    | otherwise = div n 2

collatzLoop :: Integer -> Integer
collatzLoop n
    | n <= 1    = 0
    | otherwise = 1 + collatzLoop (collatz n)

collatzCheck :: Integer -> (Integer, Integer)
collatzCheck 1 = (1, 0)
collatzCheck n = maximumBy (compare `on` snd) $ zip ind (map collatzLoop ind)
  where
    ind  = [1..n]

main :: IO ()
main =
    -- print $ collatzLoop  93571393692802302
    print $ collatzCheck 1000000
