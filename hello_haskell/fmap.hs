{-# OPTIONS_GHC -Wall #-}

sumMaybe :: Num a => [Maybe a] -> Maybe a
sumMaybe = fmap sum . sequence

main :: IO ()
main = do
    let f = (* 5)
    let g = (+ 3)
    print $ fmap f g (8 :: Int)
    let myInt = 1 :: Int
    print $ sumMaybe [Just myInt, Nothing]
    print $ sumMaybe [Just myInt, Just myInt]
    print $ sum <$> sequence ([Just 3, Just 4] :: [Maybe Int])
    print $ sum <$> sequence ([Just 3, Nothing] :: [Maybe Int])
