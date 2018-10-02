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
    print $ pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e']

encode :: Eq a => [a] -> [(Int, a)]
encode = encode' 1
  where
    encode' _ []           = []
    encode' n (x:[])       = [(n, x)]
    encode' n (x:ya@(y:_))
        | x == y           = encode' (n + 1) ya
        | otherwise        = [(n, x)] ++ encode' 1 ya

q10 :: IO ()
q10 = do
    print $ encode "aaaabccaadeeee"

data ListItem a = Single a | Multiple Int a
    deriving (Show)

encodeMod :: Eq a => [a] -> [Maybe (ListItem a)]
encodeMod = encodeMod' 1
  where
    encodeMod' _ []           = [Nothing]
    encodeMod' n (x:[])       = [Just (Multiple n x)]
    encodeMod' n (x:ya@(y:_))
        | x == y              = encodeMod' (n + 1) ya
        | n == 1 && x /= y    = [Just (Single     x)] ++ encodeMod' 1 ya
        | otherwise           = [Just (Multiple n x)] ++ encodeMod' 1 ya

q11 :: IO ()
q11 = do
    print $ encodeMod "aaaabccaadeeee"

decodeMod :: [ListItem a] -> [a]
decodeMod = concatMap decodeMod'
  where
    decodeMod' (Single     x) = [x]
    decodeMod' (Multiple n x)
        | n > 1               = [x] ++ decodeMod' (Multiple (n - 1) x)
        | otherwise           = [x]

q12 :: IO ()
q12 = do
    print $ decodeMod [ Multiple 4 'a'
                      , Single 'b'
                      , Multiple 2 'c'
                      , Multiple 2 'a'
                      , Single 'd'
                      , Multiple 4 'e'
                      ]

dupli :: [a] -> [a]
dupli []     = []
dupli (x:xs) = [x, x] ++ dupli xs

q14 :: IO ()
q14 = do
    print $ dupli ([1..5] :: [Int])

repli :: [a] -> Int -> [a]
repli []     _   = []
repli (x:xs) n
    | n <= 0     = []
    | n >= 1     = (repli' x n) ++ repli xs n
    | otherwise  = [x]          ++ repli xs n
  where
    repli' x' 1  = [x']
    repli' x' n' = [x'] ++ repli' x (n' - 1)

q15 :: IO ()
q15 = do
    print $ repli "abc" 3

dropNth :: [a] -> Int -> [a]
dropNth xs n = [x | (x, i) <- zip xs ([1..] :: [Int])
                  , (mod i n) /= 0
                  ]

q16 :: IO ()
q16 = do
    print $ dropNth "abcdefghik" 3

split :: [a] -> Int -> ([a], [a])
split xa n                     = split' ([], xa) n
  where
    split' (xa', []       ) _  = (xa', [])
    split' (xa', ya@(y:ys)) n'
        | n' > 0               = split' (xa' ++ [y], ys) (n' - 1)
        | otherwise            = (xa', ya)

q17 :: IO ()
q17 = do
    print $ split "abcdefghik" 3

slice :: [a] -> Int -> Int -> [a]
slice xa i j = slice' xa i j 1
  where
    slice' []     _  _  _ = []
    slice' (x:xs) i' j' n
        | i' >  n         = slice' xs i' j' (n + 1)
        | n  >= j'        = [x]
        | otherwise       = [x] ++ slice' xs i' j' (n + 1)

q18 :: IO ()
q18 = do
    print $ slice ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'k'] 3 7

rotate :: [a] -> Int -> [a]
rotate [] _        = []
rotate xa 0        = xa
rotate xa@(x:xs) n
    | n > 0        = rotate (xs ++ [x]) (n - 1)
    | n < 0        = rotate xa $ (length xa) + n
    | otherwise    = xa

q19 :: IO ()
q19 = do
    print $ rotate ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']   3
    print $ rotate ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'] (-2)

removeAt :: [a] -> Int -> Maybe (a, [a])
removeAt xa n = removeAt' [] xa n
  where
    removeAt' _  []     _  = Nothing
    removeAt' ya (x:xs) n'
        | n' <= 0          = Nothing
        | n' == 1          = Just (x, ya ++ xs)
        | otherwise        = removeAt' (ya ++ [x]) xs (n' - 1)

q20 :: IO ()
q20 = do
    print $ removeAt "abcd" 2
    print $ removeAt "abcd" 5
