{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    let myLines = ["Hello,", "world!"]
    print $ unlines myLines
    print $ lines $ unlines myLines
