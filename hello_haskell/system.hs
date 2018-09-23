{-# OPTIONS_GHC -Wall #-}

import qualified Data.Time        as DT
import qualified System.Directory as SD

main :: IO ()
main = do
    SD.getCurrentDirectory       >>= print
    SD.getHomeDirectory          >>= print
    SD.getUserDocumentsDirectory >>= print

    DT.getCurrentTime            >>= print
    -- this is the same as:
    print =<< DT.getCurrentTime
