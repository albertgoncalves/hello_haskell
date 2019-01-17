{-# OPTIONS_GHC -Wall #-}

import qualified Control.Monad as CM

-- let's say a knight starts at (6, 2), can he get to (6, 1) in exactly three
-- moves?
class Monad m =>
      MonadPlus m
    where
    mzero :: m a
    mplus :: m a -> m a -> m a

instance MonadPlus [] where
    mzero = []
    mplus = (++)

guard :: MonadPlus m => Bool -> m ()
guard True = return ()
guard False = mzero

sevensOnly :: [Int]
sevensOnly = do
    x <- [1 .. 50]
    guard ('7' `elem` show x)
    return x

demo1 :: IO ()
demo1 = do
    print (guard ((5 :: Int) > (2 :: Int)) >> return "cool" :: [String])
    print $
        ([1 .. 50] :: [Int]) -- similar to a list comprehension
         >>=
        (\x -> guard ('7' `elem` show x) >> return x)
    print sevensOnly

type KnightPos = (Int, Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c, r) = filter onBoard moves
  where
    onBoard (c', r') = c' `elem` [1 .. 8] && r' `elem` [1 .. 8]
    moves =
        [ (c + 2, r - 1)
        , (c + 2, r + 1)
        , (c - 2, r - 1)
        , (c - 2, r + 1)
        , (c + 1, r - 2)
        , (c + 1, r + 2)
        , (c - 1, r - 2)
        , (c - 1, r + 2)
        ]

moveHistory :: [KnightPos] -> [[KnightPos]]
moveHistory [] = []
moveHistory (from:hist) = [[to] ++ [from] ++ hist | to <- moveKnight from]

demo2 :: IO ()
demo2 = do
    print $ moveKnight (1, 1)
    print $ moveKnight (5, 5)
    print $ moveHistory [(1, 1)]
    print [a : b | a:b <- moveHistory [(5, 5)], a == (3, 4)]

in3 :: KnightPos -> [KnightPos] -- list all possible destinations after 3 moves
in3 start = moveKnight start >>= moveKnight >>= moveKnight

in3Do :: KnightPos -> [KnightPos]
in3Do start = do
    first <- moveKnight start
    moveKnight first

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem` in3 start

safeHead :: [a] -> [a]
safeHead [] = []
safeHead (x:_) = [x]

demo3 :: IO ()
demo3
    -- let allPaths = moveHistory [(6, 2)] >>= moveHistory >>= moveHistory
 = do
    let allPaths = moveHistory [(6, 2)] >>= moveHistory >>= moveHistory
    print [reverse path | path <- allPaths, safeHead path == [(6, 1)]]

-- (.)   ::            (b -> c)   -> (a -> b)   -> a -> c
-- (<=<) :: Monad m => (b -> m c) -> (a -> m b) -> a -> m c
-- (>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c
canReachIn :: Int -> [KnightPos] -> [[KnightPos]]
canReachIn x = foldr (CM.<=<) return possibleMoves
  where
    possibleMoves = replicate x moveHistory

main :: IO ()
main = do
    let allPaths = canReachIn 3 [(6, 2)] -- dynamic version of canReachIn3
    print [reverse path | path <- allPaths, safeHead path == [(6, 1)]]
