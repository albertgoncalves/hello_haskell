{-# OPTIONS_GHC -Wall #-}

-- via http://learnyouahaskell.com/for-a-few-monads-more
import Control.Monad.Writer

type Food = String

type Price = Sum Int

isBigGang :: Int -> (Bool, String)
isBigGang x = (x > 9, "Compared to gang to size 9.")

applyLog :: (a, String) -> (a -> (b, String)) -> (b, String)
applyLog (x, oldLog) f = (y, oldLog ++ newLog)
  where
    (y, newLog) = f x

demo1 :: IO ()
demo1 = do
    print $ isBigGang 10
    print $ isBigGang 8
    print $ applyLog (3, "Smallish gang.") isBigGang
    print $ applyLog (30, "A freaking platoon.") isBigGang
    print $
        applyLog
            ("Tobin", "Got outlaw name.")
            (\x -> (length x, "Applied length."))

applyLog' :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog' (x, oldLog) f = (y, mappend oldLog newLog) -- monoids!
  where
    (y, newLog) = f x

demo2 :: IO ()
demo2 = do
    print $ mappend (Sum (3 :: Int)) (Sum 9)
    print $ applyLog' (30, "A freaking platoon.") isBigGang

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)

demo3 :: IO ()
demo3 = do
    print $ applyLog' ("beans", Sum (10 :: Int)) addDrink
    print $ applyLog' ("jerky", Sum (25 :: Int)) addDrink
    print $
        ("dogmeat", Sum (5 :: Int)) `applyLog'` addDrink `applyLog'` addDrink

demo4 :: IO ()
demo4 = do
    print $ runWriter (return 3 :: Writer String Int)
    print $ runWriter (return 3 :: Writer (Sum Int) Int)
    print $ runWriter (return 3 :: Writer (Product Int) Int)

logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
    a <- logNumber 3
    b <- logNumber 5
    return (a * b)

multWithLog' :: Writer [String] Int
multWithLog' = do
    a <- logNumber 3
    b <- logNumber 5
    tell ["Gonna multiply these two."]
    return (a * b)

demo5 :: IO ()
demo5 = do
    print $ runWriter multWithLog
    print $ runWriter multWithLog'

gcd' :: Int -> Int -> Int
gcd' a b
    | b == 0 = a
    | otherwise = gcd' b (mod a b)

gcd'' :: Int -> Int -> Writer [String] Int
gcd'' a b
    | b == 0 = do
        tell ["Finish with " ++ show a]
        return a
    | otherwise = do
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (mod a b)]
        gcd'' b (mod a b)

main :: IO ()
main = do
    print $ fst $ runWriter (gcd'' 8 3)
    mapM_ putStrLn $ snd $ runWriter (gcd'' 8 3)
    mapM_ putStrLn ["Hello,", " world!"] -- hmm, checkout 'mapM_'...
