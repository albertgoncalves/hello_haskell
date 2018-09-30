{-# OPTIONS_GHC -Wall #-}

-- via https://wiki.haskell.org/99_questions/1_to_10

maybeLast :: [a] -> Maybe a
maybeLast []     = Nothing
maybeLast (x:[]) = Just x
maybeLast (_:xs) = maybeLast xs

q1 :: IO ()
q1 = do
    print $ maybeLast ([]     :: [Int])
    print $ maybeLast ([1..5] :: [Int])

maybe2ndLast :: [a] -> Maybe a
maybe2ndLast []       = Nothing
maybe2ndLast (_:[]  ) = Nothing
maybe2ndLast (x:_:[]) = Just x
maybe2ndLast (_:xs  ) = maybe2ndLast xs

q2 :: IO ()
q2 = do
    print $ maybe2ndLast ([1]    :: [Int])
    print $ maybe2ndLast ([1..5] :: [Int])
