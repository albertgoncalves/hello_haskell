{-# OPTIONS_GHC -Wall #-}

import Data.List (unfoldr)

-- unfoldr :: (b -> Maybe (a, b)) -> b -> [a]
    -- (appendedToList, consideredOnNextIteration)

fibLike :: Integral a => (a, a) -> Maybe (a, (a, a))
fibLike (a, b) = Just (a, (b, a + b))

-- in the 'fibLike' example, this tuple is simply wrapped in a Just, resulting
-- in an infinite list

-- the example below articulates a terminal condition with a 'if ... Nothing',
-- resulting in a finite list

finiteF :: Integral a => a -> Maybe (a, a)
finiteF x
    | x <= 0    = Nothing
    | otherwise = Just (x, x - 1)

main :: IO ()
main = do
    print $ unfoldr finiteF (10 :: Int)
    print $ take 8 $ unfoldr fibLike ((0, 1) :: (Int, Int)) -- classic Fibs
    print $ take 8 $ unfoldr fibLike ((2, 1) :: (Int, Int)) -- Lucas numbers!
