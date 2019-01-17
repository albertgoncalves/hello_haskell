{-# OPTIONS_GHC -Wall #-}

import qualified Data.ByteString.Lazy as L

-- via http://hackage.haskell.org/package/http-conduit-2.3.2/docs/Network-HTTP-Conduit.html
import Network.HTTP.Conduit

main :: IO ()
main = simpleHttp "http://www.haskell.org/" >>= L.putStr
