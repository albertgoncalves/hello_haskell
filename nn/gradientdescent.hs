{-# OPTIONS_GHC -Wall #-}

-- via https://github.com/octonion/examples/blob/master/gradient_descent/haskell/gradient_descent.hs

import qualified Data.List

hypothesis :: Num a => (a, a) -> a -> a
hypothesis (d1, d2) x = d1 + (d2 * x)

squareDiff :: Num a => (a, a) -> (a, a) -> a
squareDiff d (x, y) = diff' * diff'
  where diff' = diff d (x, y)

costFunc :: Fractional a => [(a, a)] -> (a, a) -> a
costFunc ts d = scaleFactor * sum squares
  where
    scaleFactor = 1.0 / (2 * Data.List.genericLength ts)
    squares     = map (squareDiff d) ts

diff :: Num a => (a, a) -> (a, a) -> a
diff d (x, y) = hypothesis d x - y

descendTheta :: Fractional a =>
    ((a, a) -> a) -> ((a, a) -> a) -> [(a, a)] -> a -> (a, a) -> a
descendTheta thetaFunc deltaFunc ts lr deltas =
    deltaFunc deltas - (scaleFactor * sum scaledDiffs)
  where
    scaleFactor = lr / Data.List.genericLength ts
    diffs       = map (diff deltas) ts
    scaledDiffs = map (\(x, y) -> x * thetaFunc y) $ zip diffs ts

singleDescend :: Fractional a => [(a, a)] -> a -> (a, a) -> (a, a)
singleDescend ts lr deltas = (thetaZero, thetaOne)
  where
    -- descendThetaZero = descendTheta (\_ -> 1) fst
    -- descendThetaOne  = descendTheta (fst)     snd
    -- thetaZero        = descendThetaZero ts lr deltas
    -- thetaOne         = descendThetaOne  ts lr deltas
    thetaZero = descendTheta (const 1) fst ts lr deltas
    thetaOne  = descendTheta fst     snd ts lr deltas

descend :: (Eq t1, Num t1) => (t2 -> t2) -> t2 -> t1 -> t2
descend func deltas i
    | i == 0    = deltas
    | otherwise = descend func (func deltas) (i - 1)

main :: IO ()
main = do
    let learningRate = 0.01  :: Double
    let i            = 5 :: Integer
    let trainingSet  = [(1.0, 10.0), (2.0, 20.0), (3.0, 30.0), (4.0, 40.0)]
    let descentFunc  = singleDescend trainingSet learningRate
    let deltas       = descend descentFunc (100, 1) i
    print deltas
