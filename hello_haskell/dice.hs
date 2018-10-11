{-# OPTIONS_GHC -Wall #-}

import Data.List (sort)
import Data.Map  (fromListWith, toList)

frequency :: (Ord a) => [a] -> [(a, Int)]
frequency xs = toList (fromListWith (+) [(x, 1) | x <- xs])

roll_2 :: [([Int], Int)]
roll_2 = [(k, xy) | x <- [1..6]
                  , y <- [1..6]
                  , let xy = x + y
                  , let k  = sort [x, y]
                  ]

roll_3 :: [([Int], Int)]
roll_3 = [(k, xyz) | x <- [1..6]
                   , y <- [1..6]
                   , z <- [1..6]
                   , let xyz = x + y + z
                   , let k   = sort [x, y, z]
                   ]

allDifferent :: (Eq a) => [a] -> Bool
allDifferent []     = True
allDifferent (x:xs) = x `notElem` xs && allDifferent xs

uniques :: (Eq a) => (([a], b), c) -> Bool
uniques ((xs, _), _) = allDifferent xs

notUniques :: (Eq a) => (([a], b), c) -> Bool
notUniques ((xs, _), _) = not $ allDifferent xs

main :: IO ()
main = do
    print $ filter notUniques $ frequency roll_2
    print $ filter notUniques $ frequency roll_3
