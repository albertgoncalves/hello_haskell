{-# OPTIONS_GHC -Wall #-}

-- import qualified Data.Char as DC

doNothing :: String -> String
doNothing x = x

main :: IO ()
main = do
    -- interact $ fmap DC.toUpper
    interact doNothing
