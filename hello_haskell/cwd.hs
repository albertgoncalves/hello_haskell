{-# OPTIONS_GHC -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

import           System.Directory
import qualified Data.List as L
import qualified Data.Text as T

-- split on period and grab extension characters at index 1
splitExt :: String -> T.Text
splitExt x
    | '.' `notElem` x       = " "
    | Prelude.head x == '.' = " "
    | Prelude.last x == '.' = " "
    | otherwise             = T.splitOn (T.pack ".") (T.pack x) !! 1

-- good place to note: single quotations indicate Char, double quations [Char]
-- even in the event of single characters
dropHello :: String -> T.Text
dropHello x
    | "Hello_" `L.isPrefixOf` x = T.splitOn (T.pack "_") (T.pack x) !! 1
    | otherwise                 = T.pack x

readyString :: String -> String
readyString x = T.unpack $ dropHello x

main :: IO ()
main = do
    -- myFiles <- getDirectoryContents =<< getCurrentDirectory
    -- the above line is equivalent to the following 2 lines:
    currentDir <- getCurrentDirectory
    myFiles    <- getDirectoryContents currentDir

    let myFilter = [readyString x | x <- myFiles, splitExt x == "hs"]
    let myLen    = Prelude.length myFilter
    mapM_ putStrLn myFilter
    putStrLn $ " ... found " ++ show myLen ++ " .hs files in cwd"
