{-# OPTIONS_GHC -Wall #-}

-- via https://wiki.haskell.org/Euler_problems/11_to_20

import Data.List (group)

primes :: [Integer]
primes = 2 : filter (null . tail . primeFactors) [3, 5..]

primeFactors :: Integer -> [Integer]
primeFactors n' = factor n' primes
  where
    factor _ []          = []
    factor n (p:ps)
        | p*p > n        = [n]
        | n `mod` p == 0 = p : factor (n `div` p) (p:ps)
        | otherwise      =     factor n ps

problem_12 :: Integer
problem_12 = head $ filter ((> 500) . nDivisors) triangleNumbers
  where
    nDivisors n = product $ map ((+1) . length) (group (primeFactors n))
    triangleNumbers = scanl1 (+) [1..]

main :: IO ()
main = do
    print $ problem_12
