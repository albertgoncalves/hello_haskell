{-# OPTIONS_GHC -Wall #-}

import Data.List

solve :: String -> String
solve rawInput = show minSum ++ " " ++ show maxSum
  where
    numInput = sort $ map read $ words rawInput :: [Int]
    n        = length numInput
    minSum   = sum  $ take (n - 1) numInput
    maxSum   = sum  $ tail numInput

main :: IO ()
main = interact solve
