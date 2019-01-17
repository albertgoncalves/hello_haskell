{-# OPTIONS_GHC -Wall #-}

import Data.Semigroup

type Indexed a = (Min Int, a)

strToIndex :: String -> [Indexed Char]
strToIndex = zip [0 ..]

mkToken :: [Indexed Char] -> Indexed String
mkToken = sequenceA

main :: IO ()
main = print $ mkToken . strToIndex $ "Hello, world!"
