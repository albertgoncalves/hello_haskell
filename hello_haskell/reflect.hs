{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE DeriveFunctor #-}

import Text.Printf (printf)

data Message a b = Message
    { messageSender :: String
    , messageFoo :: a
    , messageBar :: b
    } deriving (Functor, Show)

reflect :: Functor f => (f (a -> b) -> a) -> f (a -> b) -> f b
reflect r f = fmap ($ (r f)) f
-- reflect r f = (flip ($) (r f)) <$> f

format :: String -> String -> String
format = printf "message: %s\nfrom: %s"

x :: Message String String
x = Message "Alberto" "Foo" "Bar"

main :: IO ()
main = (print . reflect messageSender . fmap format) x
