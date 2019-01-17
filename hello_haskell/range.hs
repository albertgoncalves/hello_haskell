{-# OPTIONS_GHC -Wall #-}

range :: Int -> Int -> [Int]
range x y
    | x > y = []
    | otherwise = x : range (x + 1) y

main :: IO ()
main = print $ range 1 4
