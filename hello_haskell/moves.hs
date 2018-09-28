{-# OPTIONS_GHC -Wall #-}

moves :: (Int, Int) -> [(Int, Int)]
moves (l, r) = combos
  where
    xy     = [1,  2]
    ij     = [1, -1]
    combos = [(ll, rr) | x <-         xy
                       , y <- reverse xy
                       , i <-         ij
                       , j <- reverse ij
                       , x /= y
                       , let ll = (l + (x * i))
                       , let rr = (r + (y * j))
                       , let board = [1..8]
                       , elem ll board
                       , elem rr board
                       ]

main :: IO ()
main = do
    print $ moves (7, 7)
