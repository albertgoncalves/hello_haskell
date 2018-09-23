{-# OPTIONS_GHC -Wall #-}

-- if we consider the numbers 1 thru 10, in what cases does the smaller number
-- have a longer word?
    -- 6 > 3 but length "six" < length "three"

-- from the same list of numbers, what numbers required more letters than their
-- numeric value?
    -- 1 < length "one"

main :: IO ()
main = do
    let ns  = [1..10] :: [Int]
    let nws = [ "one"
              , "two"
              , "three"
              , "four"
              , "five"
              , "six"
              , "seven"
              , "eight"
              , "nine"
              , "ten"
              ] :: [String]

    let ans1 = [(n1, n2) | (n1, lw1) <- zip ns (map length nws)
                         , (n2, lw2) <- zip ns (map length nws)
                         , n1  < n2
                         , lw1 > lw2
                         ]

    let ans2 = [(n, w) | (n, (w, lw)) <- zip ns (zip nws (map length nws))
                       , lw > n
                       ]

    print $ ans1
    print $ ans2
