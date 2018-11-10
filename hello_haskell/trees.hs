{-# OPTIONS_GHC -Wall #-}

data Tree a = Leaf
            | Node Int (Tree a) a (Tree a)
  deriving (Show, Eq, Ord)

treeLevel :: Tree a -> Int
treeLevel Leaf           = 0
treeLevel (Node n _ _ _) = n

demo1 :: IO ()
demo1 = do
    let treeA = Node 1 Leaf "A" Leaf :: Tree String
    let treeB = Node 2 Leaf "B" Leaf :: Tree String
    print $ treeB > treeA
    print $ treeLevel treeA

makeBranch :: Ord a => a -> Tree a -> Tree a
makeBranch x Leaf           = Node 0 Leaf x Leaf
makeBranch x (Node _ l y r)
    | l < r                 = Node (treeLevel newL + 1) newL y r
    | otherwise             = Node (treeLevel newR + 1) l    y newR
  where
    newL = makeBranch x l
    newR = makeBranch x r

demo2 :: IO ()
demo2 = do
    print $ makeBranch "A" $ makeBranch "B" Leaf
    print $ makeBranch "A" $ makeBranch "B" $ makeBranch "C" Leaf
    print $
        makeBranch "A" $ makeBranch "B" $ makeBranch "C" $ makeBranch "D" Leaf

-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
foldTree :: Ord a => [a] -> Tree a
foldTree = foldr makeBranch Leaf

main :: IO ()
main = do
    print $ foldTree "ABCD"
    print $ foldTree "ABCDEFGHIJKL"
