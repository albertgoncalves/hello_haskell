{-# OPTIONS_GHC -Wall #-}

moves :: (Int, Int) -> [(Int, Int)]
moves (l, r) = combos
  where
    xy     = [1,  2]
    ij     = [1, -1]
    combos = [(l + (x * i), r + (y * j)) | x <-         xy
                                         , y <- reverse xy
                                         , i <-         ij
                                         , j <- reverse ij
                                         , x /= y
                                         ]

main :: IO ()
main = do
    print $ moves (5, 5)
