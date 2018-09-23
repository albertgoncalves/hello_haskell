{-# OPTIONS_GHC -Wall #-}

raise2 :: Integer -> Integer
raise2 x = x ^ (2 :: Integer)

main :: IO ()
main = do
    let nums = [1..100] :: [Integer]
    let sum_squares = sum $ map raise2 nums
    let square_sum  = raise2 $ sum nums
    print $ abs $ sum_squares - square_sum
