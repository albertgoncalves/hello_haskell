{-# OPTIONS_GHC -Wall #-}

-- via http://hackage.haskell.org/package/tagsoup

import Network.HTTP
import Text.HTML.TagSoup

openURL :: String -> IO String
openURL x = getResponseBody =<< simpleHTTP (getRequest x)

fromFooter :: [Tag String] -> String
fromFooter = innerText . take 2 . dropWhile (~/= "<li id=lastmod>")

main :: IO ()
main = do
    let url = "http://wiki.haskell.org/Haskell"
    src <- openURL url
    let lastModifiedDateTime = fromFooter $ parseTags src
    mapM_ putStrLn [url, lastModifiedDateTime]
