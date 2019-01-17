{-# OPTIONS_GHC -Wall #-}

import Data.Array

main :: IO ()
main = do
    let lst = [0 .. 4] :: [Int]
    let a = array (0, 4) [(i, 0) | i <- lst] :: Array Int Int
    putStrLn $ "emp: " ++ show a
    let a' = a // [(4, 100)]
    putStrLn $ "set: " ++ show a'
    putStrLn $ "get: " ++ show (a' ! 4)
    putStrLn $ "len: " ++ show ((+ 1) . snd . bounds $ a')
    let b = array (0, 4) [(i, i + 1) | i <- lst]
    putStrLn $ "dcl: " ++ show b
    let c =
            array
                ((0, 0), (1, 2))
                [((i, j), i + j) | i <- [0 .. 1], j <- [0 .. 2]] :: Array ( Int
                                                                          , Int) Int
    putStrLn $ "2d : " ++ show c
