{-# OPTIONS_GHC -Wall #-}

import Control.Applicative

-- via http://learnyouahaskell.com/a-fistful-of-monads
f :: Int -> Int
f = (* 3)

f' :: Int -> Int -> Int
f' = (*)

f'' :: Int -> Maybe Int
f'' x = Just $ f x

maybeHead :: [a] -> Maybe a
maybeHead [] = Nothing
maybeHead (x:_) = Just x

-- the Maybe instance of >>=
applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing _ = Nothing
applyMaybe (Just x) ff = ff x

main :: IO ()
main = do
    print $ f <$> Just 3
    print $ (<*>) (Just f) (Just 3)
    print $ liftA2 f' (Just 3) (Just 3)
    print $ f' <$> Just 3 <*> Just 3
    print $ maybeHead $ f' <$> [3] <*> [3]
    print $ applyMaybe (Just 3) f'' -- i.e. Just 3 >>= f''
