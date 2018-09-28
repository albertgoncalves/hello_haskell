{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    let f = (+) <$> (* 2) <*> (+ 10)
    print $ f (3 :: Int) -- (3 * 2) + (3 + 10)
