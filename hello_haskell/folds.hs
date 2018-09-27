{-# OPTIONS_GHC -Wall #-}

apply :: [(a -> b)] -> a -> [b]
apply []     _ = []
apply (f:fs) x = [f x] ++ apply fs x

main :: IO ()
main = do
    let x = ["H", "e", "l", "l", "o"]

    let folds = [ foldl (++) "!"
                , foldr (++) "!"
                , foldl (++) "!" . reverse
                , foldr (++) "!" . reverse
                ]

    print x
    print $ apply folds x
