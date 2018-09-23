{-# OPTIONS_GHC -Wall #-}

import Data.Vector.Unboxed as U

dot :: (Unbox a, Num a) => Vector a -> Vector a -> a
-- dot v1 v2 = U.sum $ U.zipWith (*) v1 v2

-- slightly faster than above, both very fast
dot v1 v2 = U.ifoldl func 0 v2
  where func acc i el = acc + el * (v1 U.! i)

range :: Int
range = 250000

v1' :: Int
v1' = 10

v2' :: Int
v2' = 20

main :: IO ()
main = do
    -- both faster than equivalent operation with Numpy
        -- let v1 = fromList ([v1'..(v1' + range)] :: [Int])
        -- let v2 = fromList ([v2'..(v2' + range)] :: [Int])

    -- of the pair, much faster with lower memory cost
    let v1 = (enumFromN v1' (range + 1) :: Vector Int)
    let v2 = (enumFromN v2' (range + 1) :: Vector Int)

    print $ dot v1 v2
