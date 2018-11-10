{-# OPTIONS_GHC -Wall #-}

main :: IO ()
main = do
    let xs     = [1..5] :: [Int]
    let index  = [1.. ] :: [Int]
    let combos = [(x, y) | (ix, x) <- zip index xs
                         , (iy, y) <- zip index xs
                         , ix < iy -- all unique combinations from list
                         ]
    print combos
