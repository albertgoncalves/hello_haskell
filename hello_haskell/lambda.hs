{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    let ints = [1, 2, 3, 4, 5] :: [Int]
    print $ map (\x -> "the " ++ show x) ints
