{-# OPTIONS_GHC -Wall #-}

import Control.Monad (zipWithM_)
import Data.List (tails)

-- can't remember where this was pilfered from...
-- wish I could say it was my own handiwork
fiblike :: [Integer] -> [Integer]
fiblike st = xs
  where
    xs = st ++ map (sum . take n) (tails xs)
    n = length st

nstep :: Int -> [Integer]
nstep n = fiblike $ take n $ 1 : iterate (2 *) 1

main :: IO ()
main = do
    print $ take 10 $ fiblike [1, 1]
    print $ take 10 $ fiblike [2, 1]
    zipWithM_
        (\n name -> do
             putStr (name ++ "nacci -> ")
             print $ take 15 $ nstep n)
        [2 ..]
        (words "fibo tribo tetra penta hexa hepta octo nona deca")
