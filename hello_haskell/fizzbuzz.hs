{-# OPTIONS_GHC -Wall #-}

combine :: Show a => [Char] -> a -> String
combine word number
    | word == "" = show number
    | otherwise  = word

main :: IO ()
main = do
    let fizzes   = cycle ["", "", "fizz"]         :: [[Char]]
    let buzzes   = cycle ["", "", "", "", "buzz"] :: [[Char]]
    let cycles   = zipWith (++) fizzes buzzes     :: [[Char]]
    let duration = [1..]                          ::  [Int]

    print $ take 20 $ zipWith combine cycles duration
