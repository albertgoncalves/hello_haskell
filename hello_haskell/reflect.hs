{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE DeriveFunctor #-}

data Message a = Message
    { messageSender :: String
    , messageContent :: a
    } deriving (Functor, Show)

reflect :: Functor f => (f (a -> b) -> a) -> f (a -> b) -> f b
reflect r f = ($ r f) <$> f

formatMsg :: String -> String -> String
formatMsg a b = "message: " ++ a ++ "\nfrom: " ++ b

main :: IO ()
main = do
    let msg = Message "Alberto" "Hello!"
    print msg
    putStrLn $ messageContent $ reflect messageSender $ fmap formatMsg msg
