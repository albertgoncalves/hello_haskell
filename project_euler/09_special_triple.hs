{-# OPTIONS_GHC -Wall #-}

sqd :: Int -> Int
sqd x = x * x

solutions :: [Int]
solutions =
    [ a * b * c
    | c <- [1 ..] :: [Int]
    , b <- [1 .. c - 1] :: [Int]
    , a <- [1 .. b - 1] :: [Int]
    , a < b
    , b < c
    , (a + b + c) == 1000
    , sqd a + sqd b == sqd c
    ] :: [Int]

main :: IO ()
main = print $ head $ take 1 solutions
