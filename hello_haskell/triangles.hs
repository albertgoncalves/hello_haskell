{-# OPTIONS_GHC -Wall #-}

-- Which right triangle that has integers for all sides and all sides equal to
-- or smaller than 10 has a perimeter of 24?
sqd :: Int -> Int
sqd x = x * x

main :: IO ()
main = do
    let rightTriangles = [(a, b, c) | c <- [1..10]
                                    , b <- [1.. c]
                                    , a <- [1.. b]
                                    , (sqd a) + (sqd b) == (sqd c)
                                    , a + b + c         == 24
                                    ] :: [(Int, Int, Int)]
    print $ rightTriangles
