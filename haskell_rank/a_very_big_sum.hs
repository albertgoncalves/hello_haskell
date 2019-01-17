{-# OPTIONS_GHC -Wall #-}

-- via https://www.youtube.com/watch?v=h_D4P-KRNKs
showInt :: Int -> String
showInt = show

main :: IO ()
main = interact $ showInt . sum . map read . tail . words
