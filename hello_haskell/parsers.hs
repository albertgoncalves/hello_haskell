{-# OPTIONS_GHC -Wall #-}

import Text.ParserCombinators.ReadP

-- via https://two-wrongs.com/parser-combinators-parsing-for-haskell-beginners.html

isVowel :: Char -> Bool
isVowel = flip elem "aouei"

vowel :: ReadP Char
vowel = satisfy isVowel

-- readP_to_S :: ReadP a -> String -> [(a, String)]

demo1 :: IO ()
demo1 = do
    print $ readP_to_S vowel "e"
    print $ readP_to_S vowel "k"
    print $ readP_to_S vowel "another"
    print $ readP_to_S vowel "did you see"

atLeastOneVowel :: ReadP [Char]
atLeastOneVowel = many1 vowel

demo2 :: IO ()
demo2 = do
    print $ readP_to_S atLeastOneVowel "aouibcdef"
    print $ readP_to_S atLeastOneVowel "zabc"

airport :: ReadP String
airport = many1 $ satisfy (\char' -> char' >= 'A' && char' <= 'Z')

airport' :: ReadP String
airport' = do
    code <- many1 $ satisfy (\char' -> char' >= 'A' && char' <= 'Z')
    _    <- satisfy (== ' ')
    return code

demo3 :: IO ()
demo3 = do
    print $ readP_to_S airport  "BIRK 281500Z 09014KT CAVOK M03/M06 Q0980"
    print $ readP_to_S airport' "BIRK 281500Z 09014KT CAVOK M03/M06 Q0980"

digit :: ReadP Char
digit = satisfy (\char' -> char' >= '0' && char' <= '9')

timestamp :: ReadP (Int, Int, Int)
timestamp = do
    day    <- count 2 digit
    hour   <- count 2 digit
    minute <- count 2 digit
    _      <- string "Z "
    return (read day, read hour, read minute)

demo4 :: IO ()
demo4 = do
    print $ readP_to_S timestamp "302359Z "
    print $ readP_to_S timestamp "888990Z " -- doesn't parse correctly just yet

manualString :: ReadP [Char]
manualString = do
    first   <- satisfy ('h' ==)
    second  <- satisfy ('i' ==)
    return [first, second]

string' :: [Char] -> ReadP [Char]
string' xs = sequenceA $ map (\x -> satisfy (x ==)) xs

demo5 :: IO ()
demo5 = do
    print $ readP_to_S manualString "hi"
    print $ readP_to_S (string' "hi") "hi"
    print $ readP_to_S (string  "hi") "hi"
    print $ readP_to_S manualString "hello"
    print $ readP_to_S (string' "hello") "hi"
    print $ readP_to_S (string  "hello") "hi"
