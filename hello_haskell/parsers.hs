{-# OPTIONS_GHC -Wall #-}

import Control.Applicative ((<|>))
import Data.Char (isAsciiUpper, isDigit)
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

atLeastOneVowel :: ReadP String
atLeastOneVowel = many1 vowel

demo2 :: IO ()
demo2 = do
    print $ readP_to_S atLeastOneVowel "aouibcdef"
    print $ readP_to_S atLeastOneVowel "zabc"

airport :: ReadP String
airport = many1 $ satisfy isAsciiUpper

airport' :: ReadP String
airport' = do
    code <- many1 $ satisfy isAsciiUpper
    _ <- satisfy (== ' ')
    return code

demo3 :: IO ()
demo3 = do
    print $ readP_to_S airport "BIRK 281500Z 09014KT CAVOK M03/M06 Q0980"
    print $ readP_to_S airport' "BIRK 281500Z 09014KT CAVOK M03/M06 Q0980"

digit :: ReadP Char
digit = satisfy isDigit

timestamp :: ReadP (Int, Int, Int)
timestamp = do
    day <- count 2 digit
    hour <- count 2 digit
    minute <- count 2 digit
    _ <- string "Z "
    return (read day, read hour, read minute)

demo4 :: IO ()
demo4 = do
    print $ readP_to_S timestamp "302359Z "
    print $ readP_to_S timestamp "888990Z " -- doesn't parse correctly just yet

manualString :: ReadP String
manualString = do
    first <- satisfy ('h' ==)
    second <- satisfy ('i' ==)
    return [first, second]

string' :: String -> ReadP String
string' = traverse (\x -> satisfy (x ==))

demo5 :: IO ()
demo5 = do
    print $ readP_to_S manualString "hi"
    print $ readP_to_S (string' "hi") "hi"
    print $ readP_to_S (string "hi") "hi"
    print $ readP_to_S manualString "hello"
    print $ readP_to_S (string' "hello") "hi"
    print $ readP_to_S (string "hello") "hi"

numbers :: Int -> ReadP Int
numbers digits = fmap read (count digits digit)

timestamp' :: ReadP (Int, Int, Int)
timestamp' = do
    day <- numbers 2
    hour <- numbers 2
    minute <- numbers 2
    _ <- string' "Z "
    if day < 1 || day > 31 || hour > 23 || minute > 59
        then pfail
        else return (day, hour, minute)

demo6 :: IO ()
demo6 = do
    print $ readP_to_S timestamp' "302359Z "
    print $ readP_to_S timestamp' "888990Z " -- should be better now

toMPS :: String -> Int -> Maybe Int
toMPS "MPS" speed = Just speed
toMPS "KT" speed = Just (div speed 2)
toMPS _ _ = Nothing

maybeToMPS :: String -> Maybe Int -> Maybe Int
maybeToMPS _ Nothing = Nothing
maybeToMPS unit (Just speed) = toMPS unit speed

gustParser :: ReadP Int
gustParser = do
    _ <- satisfy ('G' ==)
    numbers 2 <|> numbers 3

windInfo :: ReadP (Int, Maybe Int, Maybe Int)
windInfo = do
    direction <- numbers 3
    speed <- numbers 2 <|> numbers 3
    gusts <- option Nothing (fmap Just gustParser)
    unit <- string' "KT" <|> string' "MPS"
    _ <- string' " "
    return (direction, toMPS unit speed, maybeToMPS unit gusts)

demo7 :: IO ()
demo7 = do
    print $ readP_to_S windInfo "09014KT "
    print $ readP_to_S windInfo "18027G31KT "

main :: IO ()
main = do
    demo1
    demo2
    demo3
    demo4
    demo5
    demo6
    demo7
