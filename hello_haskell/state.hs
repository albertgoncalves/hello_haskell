{-# OPTIONS_GHC -Wall #-}

import Control.Monad.State

type Stack = [Int]

pop :: Stack -> (Int, Stack)
pop (x:xs) = (x, xs)
pop _      = undefined

push :: Int -> Stack -> ((), Stack)
push a xs = ((), a:xs)

stackManip :: Stack -> (Int, Stack)
stackManip stack = let
    ((), newStack1) = push 3 stack
    (_ , newStack2) = pop newStack1
    in pop newStack2

stackManip' :: Stack -> (Int, Stack)
stackManip' stack = pop newStack2
  where
    ((), newStack1) = push 3 stack
    (_ , newStack2) = pop newStack1

demo1 :: IO ()
demo1 = do
    print $ stackManip  [5, 8, 2, 1]
    print $ stackManip' [5, 8, 2, 1]

pop' :: State Stack Int
pop' = state $ \(x:xs) -> (x, xs)

push' :: Int -> State Stack ()
push' a = state $ \xs -> ((), a:xs)

stackManip'' :: State Stack Int
stackManip'' = do
    push' 3
    _ <- pop'
    pop'

demo2 :: IO ()
demo2 = print $ runState stackManip'' [5, 8, 2, 1]

stackStuff :: State Stack ()
stackStuff = do
    a <- pop'
    if a == 5
        then push' 5
        else do
            push' 3
            push' 8

demo3 :: IO ()
demo3 = do
    print $ runState stackStuff [9, 0, 2, 1, 0]
    print $ runState stackStuff [5, 0, 2, 1, 0]
