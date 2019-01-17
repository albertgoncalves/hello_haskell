{-# OPTIONS_GHC -Wall #-}

combine :: Show a => String -> a -> String
combine word number
    | word == "" = show number
    | otherwise = word

main :: IO ()
main = do
    let fizzes = cycle ["", "", "fizz"] :: [String]
    let buzzes = cycle ["", "", "", "", "buzz"] :: [String]
    let cycles = zipWith (++) fizzes buzzes :: [String]
    let duration = [1 ..] :: [Int]
    print $ take 20 $ zipWith combine cycles duration
