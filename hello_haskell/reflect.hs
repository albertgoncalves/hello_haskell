{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE DeriveFunctor #-}

data Message a = Message
    { messageSender :: String
    , messageContent :: a
    } deriving (Functor, Show)

reflect :: Functor f => (f (a -> b) -> a) -> f (a -> b) -> f b
reflect r f = ($ r f) <$> f

format :: String -> String -> String
format a = (++) ("message: " ++ a ++ "\nfrom: ")

x :: Message String
x = Message "Alberto" "Hello!"

main :: IO ()
main = (putStrLn . messageContent . reflect messageSender . fmap format) x
