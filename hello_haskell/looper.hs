{-# OPTIONS_GHC -Wall #-}

loop :: Integral b => (a -> a) -> a -> b -> a
loop f x n
    | n <= 0 = x
    | otherwise = loop' f x n
  where
    loop' f' x' 1 = f' x'
    loop' f' x' n' = loop' f' (f' x') (n' - 1)

main :: IO ()
main = do
    let f x' = x' + (1 / x')
    let x = 0.01 :: Double
    let n = 1000000 :: Int
    print $ loop f x n
