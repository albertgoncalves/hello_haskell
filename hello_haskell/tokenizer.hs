{-# OPTIONS_GHC -Wall #-}

import Data.Semigroup

type Indexed a = (Min Int, a)

strToIndex :: String -> [Indexed Char]
strToIndex a = zip [0..] a

mkToken :: [Indexed Char] -> Indexed [Char]
mkToken = sequenceA

main :: IO ()
main = print $ mkToken . strToIndex $ "Hello, world!"
