{-# OPTIONS_GHC -Wall #-}

import System.IO

main :: IO ()
main = do
    let filename = "file.txt" :: String
    writeFile filename "Hello, world!"
    withFile filename ReadMode $ \handle -> do
        contents <- hGetContents handle
        print contents
