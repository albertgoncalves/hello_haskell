{-# OPTIONS_GHC -dcore-lint #-}
{-# OPTIONS_GHC -Wall #-}

dot :: Num a => [a] -> [a] -> a
dot v1 v2 = sum $ zipWith (*) v1 v2

main :: IO ()
main = do
    let range = 250000 :: Int
    let seed1   = 10   :: Int
    let seed2   = 20   :: Int

    let v1 = [seed1..(seed1 + range)] :: [Int]
    let v2 = [seed2..(seed2 + range)] :: [Int]

    print $ dot v1 v2
