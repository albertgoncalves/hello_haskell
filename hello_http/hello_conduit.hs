{-# OPTIONS_GHC -Wall #-}

import Conduit ((.|), runConduit)
import Control.Monad.Trans.Resource (runResourceT)

-- via http://hackage.haskell.org/package/http-conduit-2.3.2/docs/Network-HTTP-Conduit.html
import Data.Conduit.Binary (sinkFile) -- Exported from the package
import Network.HTTP.Conduit -- conduit-extra

main :: IO ()
main = do
    request <- parseRequest "http://google.com/"
    manager <- newManager tlsManagerSettings
    runResourceT $ do
        response <- http request manager
        runConduit $ responseBody response .| sinkFile "google.html"
