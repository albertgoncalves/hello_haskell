{-# OPTIONS_GHC -Wall #-}

pairWith :: (a -> a -> b) -> [a] -> [b]
pairWith f (x1:xs@(x2:_)) = f x1 x2 : pairWith f xs
pairWith _ _ = []

pairList :: a -> a -> [a]
pairList a a' = [a, a']

mapPair :: (a -> b) -> a -> a -> [b]
mapPair f a a' = map f $ pairList a a'

main :: IO ()
main = do
    let ints = [1 .. 3] :: [Int]
    mapM_ print $ pairWith (flip subtract) ints
    print $ pairWith (++) $ map (: []) "Hello, world!"
    print $ pairWith (mapPair (* 3)) ints
    print $ map (* 3) <$> pairWith pairList ints
    print $ map (* 3) <$> pairWith (++) (map (: []) ints)
    print $ ((* 3) <$>) <$> pairWith (++) (map (: []) ints)
    print $ ((*) <$> [3, 3] <*>) <$> pairWith (++) (map (: []) ints)
    print $ ((*) <$> Just 3 <*>) <$> map Just (pairWith (curry fst) ints)
