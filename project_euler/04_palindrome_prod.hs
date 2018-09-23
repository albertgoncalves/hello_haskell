{-# OPTIONS_GHC -Wall #-}

checkPalindrome :: Int -> Bool
checkPalindrome x
    | (mod x 10 == 0)                = False
    | (reverse $ show x) == (show x) = True
    | otherwise                      = False

main :: IO ()
main = do
    -- print $ checkPalindrome 101
    -- print $ checkPalindrome 100
    print $ maximum [(x * y) | x <- [100..999]
                             -- , y <- [100..999]
                             , y <- [x  ..999]
                             -- , x < y
                             , checkPalindrome (x * y)
                             ]
