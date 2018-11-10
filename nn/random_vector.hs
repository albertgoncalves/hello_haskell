{-# OPTIONS_GHC -Wall #-}

import qualified Data.Vector.Unboxed as U
import           System.Random    (randoms)
import           System.Random.TF (seedTFGen)

listRandomFloats :: Int -> [Float]
listRandomFloats n = take n $ randoms $ seedTFGen (0, 0, 0, 0)

convertToVec :: [Float] -> U.Vector Float
convertToVec = U.fromList
-- not the fastest solution, but usable for now

-- provides the benefit of using a seed value as well as not requiring any
-- additional packages

myRandVec :: U.Vector Float
myRandVec = convertToVec $ listRandomFloats 10000

main :: IO ()
main = do
    print $ U.sum     myRandVec / fromIntegral (U.length myRandVec)
    print $ U.minimum myRandVec
    print $ U.maximum myRandVec
