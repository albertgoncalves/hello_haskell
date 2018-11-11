{-# OPTIONS_GHC -Wall #-}

import Data.Char (isAlphaNum, isControl, isPunctuation, isSpace)

process :: String -> [String]
process [] = []
process passage'@(x:xs)
    | unwanted x      = process xs
    | x == '.'        = dots : process more
    | isPunctuation x = [x]  : process xs
    | otherwise       = word : process more'
  where
    unwanted x'   = isSpace x' || isControl x'
    (dots, more ) = span (=='.')    passage'
    (word, more') = span isAlphaNum passage'

passage :: String
passage =
    "Moreover,\n\n because\nphilosophy \nhas its \n\n,, \n\n\n being ..."

demo :: IO ()
demo = mapM_ putStrLn $ process passage

main :: IO ()
main = interact $ unlines . process
