{-# OPTIONS_GHC -Wall #-}

loop :: Integral b => (a -> a) -> a -> b -> a
loop f x n
    | n <= 0 = x
    | otherwise = loop' f x n
  where
    loop' f' x' 1 = f' x'
    loop' f' x' n' = loop' f' (f' x') (n' - 1)

main :: IO ()
main = print $ loop (\x -> x + (1 / x)) (0.01 :: Double) (1000000 :: Int)
