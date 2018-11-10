{-# OPTIONS_GHC -Wall #-}

import Data.Char (isLetter, isSpace)
import Data.List (groupBy)

notDelim :: Char -> Char -> Bool
notDelim a b = all isLetter [a, b] || (a == b)

process :: String -> [String]
process = filter (any $ not . isSpace) . groupBy notDelim

passage :: String
passage =
    "Moreover,\n\n because\nphilosophy \nhas its \n\n,, \n\n\n being ..."

demo :: IO ()
demo = mapM_ putStrLn $ process passage

main :: IO ()
main = interact $ unlines . process
