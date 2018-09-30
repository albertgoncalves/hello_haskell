{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    let ints = [1, 2, 3, 4, 5] :: [Int]
    mapM_ (\x -> putStrLn $ "the " ++ show x) ints
