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
maybe2ndLast (x:_:[]) = Just x
maybe2ndLast (_:xs  ) = maybe2ndLast xs
maybe2ndLast _        = Nothing

q2 :: IO ()
q2 = do
    print $ maybe2ndLast ([1]    :: [Int])
    print $ maybe2ndLast ([1..5] :: [Int])

elementAt :: [a] -> Int -> Maybe a
elementAt [] _     = Nothing
elementAt (x:xs) n
    | n <  1       = Nothing
    | n == 1       = Just x
    | otherwise    = elementAt xs (n - 1)

q3 :: IO ()
q3 = do
    print $ elementAt ([1..5] :: [Int]) 0
    print $ elementAt ([1..5] :: [Int]) 1
    print $ elementAt ([1..5] :: [Int]) 5
    print $ elementAt ([1..5] :: [Int]) 6

myLength :: [a] -> Int
myLength = foldr (\_ -> (+1)) 0

q4 :: IO ()
q4 = do
    print $ myLength []
    print $ myLength ([1..5] :: [Int])

myReverse :: [a] -> [a]
myReverse = foldl (flip (:)) []

q5 :: IO ()
q5 = do
    print $ myReverse ([]     :: [Int])
    print $ myReverse ([1]    :: [Int])
    print $ myReverse ([1..5] :: [Int])

data NestedList a = Elem a
                  | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (List [])     = []
flatten (Elem x)      = [x]
flatten (List (x:xs)) = (flatten x) ++ (flatten (List xs))

q7 :: IO ()
q7 = do
    let nestedList = ( List [ Elem 1
                            , List [Elem 2, List [Elem 3, Elem 4], Elem 5]
                            ]
                     ) :: NestedList Int
    print $ flatten nestedList

compress :: Eq a => [a] -> [a]
compress (x:ya@(y:_))
    | x == y    = compress ya
    | otherwise = [x] ++ compress ya
compress x      = x

q8 :: IO ()
q8 = do
    print $ compress "aaaabccaadeeee"

pack :: Eq a => [a] -> [[a]]
pack []       = []
pack xa@(x:_) = [a] ++ pack b
  where
    (a, b) = span (== x) xa

q9 :: IO ()
q9 = do
    print $ pack [ 'a'
                 , 'a'
                 , 'a'
                 , 'a'
                 , 'b'
                 , 'c'
                 , 'c'
                 , 'a'
                 , 'a'
                 , 'd'
                 , 'e'
                 , 'e'
                 , 'e'
                 , 'e'
                 ]
