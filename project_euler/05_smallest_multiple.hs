{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    let range = [3 .. 20] :: [Integer]
    print $ foldr lcm 2 range
