{-# OPTIONS_GHC -Wall      #-}
{-# LANGUAGE DeriveFunctor #-}

data Message a = Message { messageSender  :: String
                         , messageContent :: a
                         } deriving (Functor, Show)

reflect :: Functor f => (f (a -> b) -> a) -> f (a -> b) -> f b
reflect r f = ($ r f) <$> f

main :: IO ()
main = do
    let msg = Message "Alberto" "Hello, "
    print msg
    print $ messageContent $ reflect messageSender $ fmap (++) $ msg
