{-# OPTIONS_GHC -Wall #-}

-- via https://www.stackage.org/package/wai

import qualified Data.ByteString.Char8      as B8
import qualified Data.ByteString.Lazy.Char8 as LB8
import           Data.CaseInsensitive (mk)

import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp (run)

contentType :: [(HeaderName, B8.ByteString)]
contentType = [(mk $ B8.pack "Content-Type", B8.pack "text/html")]

file :: Response
file = responseFile status200 contentType "index.html" Nothing

index :: String -> Response
index path = responseLBS status200 contentType $ LB8.pack path

notFound :: Response
notFound = responseLBS status404 contentType (LB8.pack "404 - Not Found")

app :: Application
app request respond = do
    putStrLn "I've done some IO here."
    respond $ route $ B8.unpack $ rawPathInfo request
  where
    indexes = ["/", "/index", "/index/"]
    route "/file"             = file
    route path
        | path `elem` indexes = index path
        | otherwise           = notFound

main :: IO ()
main = do
    putStrLn "http://localhost:8080/"
    run 8080 app
