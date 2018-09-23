{-# OPTIONS_GHC -Wall #-}

quicksort :: (Ord a) => [a] -> [a]
quicksort []     = []
quicksort (x:xs) = quicksort smaller ++ [x] ++ quicksort larger
  where
    smaller = [a | a <- xs, a <= x]
    larger  = [b | b <- xs, b >  x]

main :: IO ()
main = do
    let myList = [1, 10, 9, 7, 4, 5, 3, 2] :: [Int]
    print $ quicksort myList
