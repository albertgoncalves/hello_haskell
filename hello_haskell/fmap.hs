{-# OPTIONS_GHC -Wall #-}

sumMaybe :: Num a => [Maybe a] -> Maybe a
sumMaybe = fmap sum . sequence

main :: IO ()
main = do
    let myInt = 1 :: Int
    print $ sumMaybe [Just myInt, Nothing   ]
    print $ sumMaybe [Just myInt, Just myInt]
    print $ sum <$>    sequence ([Just 3, Just 4]  :: [Maybe Int])
    print $ fmap sum $ sequence ([Just 3, Just 4]  :: [Maybe Int])
    print $ fmap sum $ sequence ([Just 3, Nothing] :: [Maybe Int])
