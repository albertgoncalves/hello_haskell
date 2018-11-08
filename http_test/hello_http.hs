{-# OPTIONS_GHC -Wall #-}

-- via http://hackage.haskell.org/package/http-conduit-2.3.2/docs/Network-HTTP-Conduit.html

import Network.HTTP.Conduit
import qualified Data.ByteString.Lazy as L

main :: IO ()
main = simpleHttp "http://www.haskell.org/" >>= L.putStr
