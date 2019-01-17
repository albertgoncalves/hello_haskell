{-# OPTIONS_GHC -Wall #-}

import Control.Applicative (liftA2)
import Control.Monad (foldM)

-- apply :: [a -> b] -> [a] -> [b]
-- apply fs vals = fs <*> vals
apply' :: [a -> b] -> a -> [b]
apply' [] _ = []
apply' (f:fs) x = f x : apply' fs x -- don't need the firepower above...

main :: IO ()
main = do
    let maybeInts = map Just [3, 4] :: [Maybe Int]
    let fs =
            [ fmap sum . sequence
            , foldl (liftA2 (+)) (Just 0)
            , foldM (fmap . (+)) 0
            ] -- foldM is analogous to foldl, except that its result is
               -- encapsulated in a monad
    print $ apply' fs maybeInts
    print [f maybeInts | f <- fs] -- an alternative to prev line
    -- the above is a chained-together version of the following:
        -- print $ fmap sum . sequence         $ maybeInts
        -- print $ foldl (liftA2 (+)) (Just 0) $ maybeInts
        -- print $ foldM (fmap . (+)) 0        $ maybeInts
