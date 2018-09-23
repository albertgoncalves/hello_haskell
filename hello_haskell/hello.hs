{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    putStrLn "What is your name?"       -- print string
    name <- getLine                     -- store value from terminal
    putStrLn ("Hello, " ++ name ++ "!") -- print response with stored value
