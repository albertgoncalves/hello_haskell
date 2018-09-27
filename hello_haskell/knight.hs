{-# OPTIONS_GHC -Wall #-}

-- let's say a knight starts at (6, 2), can he get to (6, 1) in exactly three
-- moves?

class Monad m => MonadPlus m where
    mzero :: m a
    mplus :: m a -> m a -> m a

instance MonadPlus [] where
    mzero = []
    mplus = (++)

guard :: (MonadPlus m) => Bool -> m ()
guard True = return ()
guard False = mzero

type KnightPos = (Int, Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c, r) = do
    (c', r') <- [ (c + 2, r - 1)
                , (c + 2, r + 1)
                , (c - 2, r - 1)
                , (c - 2, r + 1)
                , (c + 1, r + 2)
                , (c + 1, r - 2)
                , (c - 1, r + 2)
                , (c - 1, r - 2)
                ]
    guard  (c' `elem` [1..8] && r' `elem` [1..8])
    return (c', r')

moveHistory :: KnightPos -> [[KnightPos]]
moveHistory from = [[to, from] | to <- moveKnight from]

demo :: IO ()
demo = do
    print $ moveKnight  (1, 1)
    print $ moveKnight  (5, 5)
    print $ moveHistory (1, 1)
    print $ [a:b | a:b <- moveHistory (5, 5), a == (3, 4)]

in3 :: KnightPos -> [KnightPos] -- list all possible destinations afte 3 moves
in3 start = return start >>= moveKnight >>= moveKnight >>= moveKnight

in3Do :: KnightPos -> [KnightPos]
in3Do start = do
    first  <- moveKnight start
    second <- moveKnight first
    return second

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start
