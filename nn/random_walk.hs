{-# OPTIONS_GHC -Wall #-}

import Data.Array.IArray (Array, accumArray, assocs)
import System.Random     (mkStdGen, Random, randomR, random, randoms, StdGen)
import System.Random.TF  (TFGen, seedTFGen)

-- one way
rollDice :: TFGen -> (Int, TFGen)
rollDice = randomR (1, 6)

getFirst :: TFGen -> Int
getFirst g = fst $ rollDice g

histogram :: [Int] -> Array Int Int
histogram l = accumArray (+) 0 (1, 6) $ do { x <- l; return (x, 1) }

betterSeed :: IO ()
betterSeed = do
    let results = map (\i -> getFirst $ seedTFGen (0, 0, 0, i)) [0..53667]
    mapM_ print $ assocs $ histogram results

-- or another
random1 :: (Random a) => Int -> (a, StdGen)
random1 seed = random (mkStdGen seed)

extractRandom :: (a, StdGen) -> a
extractRandom (x, _) = x

randomList :: (Random a) => Int -> [a]
randomList seed = randoms (mkStdGen seed)

getBounds :: Int -> Int -> (Float, Float, Float)
getBounds seed n = ( sum randList / fromIntegral n
                   , minimum randList
                   , maximum randList
                   )
  where
    randList = take n (randomList seed :: [Float])

simpleRand :: IO ()
simpleRand = do
    print $ extractRandom (random1 42 :: (Float, System.Random.StdGen))
    print $ getBounds 42 10000

main :: IO ()
main = do
    betterSeed
    simpleRand
