{-# OPTIONS_GHC -Wall #-}

isPrime :: [Integer] -> Integer -> Bool
isPrime primes' n = foldr (\p r -> p*p > n || (rem n p /= 0 && r)) True primes'

primes :: [Integer]
primes = 2 : filter (isPrime primes) [3..]

main :: IO ()
main = do
    print $ sum $ takeWhile (2000000 >) $ primes
