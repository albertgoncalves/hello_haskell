{-# OPTIONS_GHC -Wall #-}

-- via https://www.youtube.com/watch?v=rlwSBNI9bXE

import Data.List (permutations)

data Op = Add
        | Sub
        | Mul
        | Div

type Result = (Expr, Int)

instance Show Op where
    show Add = "+"
    show Sub = "-"
    show Mul = "*"
    show Div = "/"

instance Show Expr where
   show (Val n)     = show n
   show (App o l r) = bracket l ++ show o ++ bracket r
                      where
                         bracket (Val n) = show n
                         bracket e       = "(" ++ show e ++ ")"

data Expr = Val Int
          | App Op Expr Expr

apply :: Op -> Int -> Int -> Int
apply Add x y = x + y
apply Sub x y = x - y
apply Mul x y = x * y
apply Div x y = div x y

valid :: Op -> Int -> Int -> Bool
valid Add x y = x <= y
valid Sub x y = x >  y
valid Mul x y = x <= y       && x > 1 && y > 1
valid Div x y = mod x y == 0 && x > 1 && y > 1

subsets :: [a] -> [[a]]
subsets x = concatMap permutations $ subsets' x
  where
    subsets' []     = [[]]
    subsets' (y:ys) = subsets' ys ++ map (y:) (subsets' ys)

split :: [a] -> [([a], [a])]
split ns = map (flip splitAt ns) [1..(length ns) - 1]

results :: [Int] -> [Result]
results [] = []
results [n] = [(Val n, n) | n > 0]
results ns = [res | (ls, rs) <- split ns
                  , lx       <- results ls
                  , ry       <- results rs
                  , res      <- combine lx ry
                  ]

combine :: Result -> Result -> [Result]
combine (l, x) (r, y) = [(App o l r, apply o x y) | o <- [Add, Sub, Mul, Div]
                                                  , valid o x y
                                                  ]

solutions :: [Int] -> Int -> [Expr]
solutions ns n = [e | ns'    <- subsets ns
                    , (e, m) <- results ns'
                    , m == n
                    ]

main :: IO ()
main = do
    let inputs = [1, 3, 7, 10, 25, 50] :: [Int]
    let target = 765 :: Int
    let solutions' = solutions inputs target
    putStrLn ""
    mapM_ (putStrLn . show) solutions'
    putStrLn $ "\n" ++ (show . length $ solutions') ++ " solutions found.\n"
