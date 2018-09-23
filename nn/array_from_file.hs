{-# OPTIONS_GHC -Wall #-}

listStrToInt :: [String] -> [Int]
listStrToInt = map read

listStr :: [String] -> [[String]]
listStr = map words

transformList :: [Int] -> [Int]
transformList (a:b:c) = (map (*2) [a, b]) ++ c ++ [1]
transformList [_]     = []
transformList []      = []

listInt :: [[String]] -> [[Int]]
listInt = map $ transformList . listStrToInt

replaceChar :: Char -> Char -> Char -> Char
replaceChar x outChar inChar
    | x == outChar = inChar
    | otherwise    = x

replaceComma :: Char -> Char
replaceComma x = replaceChar x ',' ' '

addComma :: Char -> Char
addComma x = replaceChar x ' ' ','

replaceBrackets :: String -> String
replaceBrackets x = filter (not . flip elem "[]") x

cleanInput :: [Char] -> (String, [String])
cleanInput x = (head lines', tail lines')
  where
    lines' = lines $ map replaceComma x

processInput :: [String] -> [[Int]]
processInput x = listInt $ listStr x

prepareOutput :: [[Int]] -> String
prepareOutput x = replaceBrackets $ unlines $ map show x

addHeader :: String -> String -> String
addHeader header x = header ++ "\n" ++ x

routine :: String -> String
routine x = (addHeader header'') . prepareOutput . processInput $ input'
  where
    (header', input') = cleanInput x
    header''          = map addComma (header' ++ " y2")

main :: IO ()
main = do
    -- withFile filename ReadMode $ \handle -> do
    --     contents <- hGetContents handle
    --     print $ routine contents
    interact $ routine
