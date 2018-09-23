{-# OPTIONS_GHC -Wall #-}

showLen :: [a] -> String
showLen lst = (show (theLen)) ++ (if theLen == 1 then " item" else " items")
  where theLen = length lst

main :: IO ()
main = do
    let myList = [1..5] :: [Int]
    print $ showLen myList
