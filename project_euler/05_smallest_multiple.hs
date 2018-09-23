{-# OPTIONS_GHC -Wall #-}

-- checkRem :: Int -> [Int] -> Bool
-- checkRem _ []      = True
-- checkRem n (x:xs)
--     | mod n x == 0 = checkRem n xs
--     | otherwise    = False

main :: IO ()
main = do
    -- print $ checkRem 2520 [1..10]
    -- print $ head $ take 1 [m | m <-       [1..  ]
    --                          , checkRem m [1..20]
    --                          ]
    let range = [3..20] :: [Integer]
    print $ foldr lcm 2 range -- wow.
