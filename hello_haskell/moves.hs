{-# OPTIONS_GHC -Wall #-}

moves :: (Int, Int) -> [(Int, Int)]
moves (l, r) = combos
  where
    xy        = [ 1 ,  2 ]
    direction = [(+), (-)]
    board     = [ 1..  8 ]
    combos    = [(ll, rr) | x  <- xy
                          , y  <- xy
                          , d  <- direction
                          , d' <- direction
                          , x /= y
                          , let ll = d  l x
                          , let rr = d' r y
                          , elem ll board
                          , elem rr board
                          ]

main :: IO ()
main = do
    print $ moves (7, 7)
