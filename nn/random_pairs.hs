{-# OPTIONS_GHC -Wall #-}

import System.Random

randomNum :: (Random a) => Int -> (a, StdGen)
randomNum seed = random (mkStdGen seed)

getRandom :: (a, StdGen) -> a
getRandom (x, _) = x

exampleRand :: IO ()
exampleRand = do
    print (getRandom $ randomNum 1 :: Int)
    print (getRandom $ randomNum 1 :: Float)

randomList :: Random a => Int -> [a]
randomList seed = randoms (mkStdGen seed)

randomPairs :: Int -> Int -> [(Float, Float)]
randomPairs seed n = take n $ zip randList' randList''
  where
    newSeed    = getRandom $ randomNum seed
    randList'  = randomList seed
    randList'' = randomList newSeed

mapPairs :: (t -> b) -> [(t, t)] -> [(b, b)]
mapPairs f = map (\(x, y) -> (f x, f y))

addPairs :: (Float, Float) -> (Float, Float) -> (Float, Float)
addPairs (a, b) (c, d) = (a + c, b + d)

sumListPairs :: Foldable t => t (Float, Float) -> (Float, Float)
sumListPairs = foldr addPairs (0, 0)

main :: IO ()
main = do
    let exPairs    = randomPairs 1 3
    let mapExPairs = mapPairs (+ 100.0) exPairs
    print exPairs
    print $ sumListPairs exPairs
    print mapExPairs
    print $ sumListPairs mapExPairs
