{-# OPTIONS_GHC -Wall #-}

import qualified Data.Map as Map

phoneBook :: Map.Map Int [Char]
phoneBook = Map.fromList [ ((1234 :: Int), "Erik")
                         , ((5678 :: Int), "Patrik")
                         ]

main :: IO ()
main = do
    print $ phoneBook
    print $ (Map.empty :: Map.Map Int Int)
    print $ Map.lookup    (1234 :: Int) phoneBook
    print $ Map.singleton (3 :: Int) (5 :: Int)
    print $ Map.insert    (1 :: Int) "abc" Map.empty
    print $ Map.null   phoneBook
    print $ Map.size   phoneBook
    print $ Map.toList phoneBook
    print $ Map.keys   phoneBook
    print $ Map.elems  phoneBook
