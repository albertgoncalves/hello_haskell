{-# OPTIONS_GHC -Wall #-}

data Tree a = Leaf
            | Node Int (Tree a) a (Tree a)
  deriving (Show, Eq, Ord)

treeLevel :: Tree a -> Int
treeLevel Leaf           = 0
treeLevel (Node n _ _ _) = n

demo :: IO ()
demo = do
    let treeA = (Node 1 Leaf "A" Leaf) :: Tree String
    let treeB = (Node 2 Leaf "B" Leaf) :: Tree String
    print $ treeB > treeA
    print $ treeLevel treeA

-- foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
foldTree :: Ord a => [a] -> Tree a
foldTree xs = foldr makeBranch Leaf xs
  where
    makeBranch x Leaf           = Node 0 Leaf x Leaf
    makeBranch x (Node _ l y r)
        | l > r                 = Node (treeLevel newR + 1) l    y newR
        | otherwise             = Node (treeLevel newL + 1) newL y r
      where
        newL = makeBranch x l
        newR = makeBranch x r

main :: IO ()
main = print $ foldTree "ABCDEFGHIJKL"
