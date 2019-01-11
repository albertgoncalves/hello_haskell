{-# OPTIONS_GHC -Wall #-}

import Text.Read

diagDiff :: Int -> [Int] -> Int
diagDiff n lst = abs $ l - r
  where
    i = 1
    ind = [i..(n * n)]
    l = sum [y | (x, y) <- zip ind lst
               , mod (x - 1) (n + 1) == 0
               ]
    r = sum [y | (x, y) <- zip ind lst
               , mod (x - 1) (n - 1) == 0
               , x /= i
               , x /= (n * n)
               ]

apply :: [Int] -> Int
apply numInput = diagDiff (head numInput) (tail numInput)

readInt :: String -> Maybe Int
readInt = readMaybe

filterOutput :: Maybe Int -> String
filterOutput = maybe failString show
  where
    failString = "Non-numeric input found, that's not going to fly."

solve :: String -> String
solve "" = "Input *is* nothing."
solve rawInput = filterOutput solution
  where
    numInput = map readInt $ words rawInput :: [Maybe Int]
    solution = apply <$> sequence numInput :: Maybe Int

main :: IO ()
main = interact solve
