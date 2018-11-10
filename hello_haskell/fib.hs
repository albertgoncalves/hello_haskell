{-# OPTIONS_GHC -Wall #-}

fibComp :: [Int]
fibComp = 0 : 1 : [a + b | (a, b) <- zip fibComp (tail fibComp)]

fibGen :: Int -> Int -> Int -> Int
fibGen a b n
    | n <= 0    = a
    | otherwise = fibGen b (a + b) (n - 1)

main :: IO ()
main = do
    let n = 20
    let fibComp' = take n fibComp
    let fibGen'  = fibGen 0 1 (n - 1)
    print fibComp'
    print fibGen'
