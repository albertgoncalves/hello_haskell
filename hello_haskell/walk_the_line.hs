{-# OPTIONS_GHC -Wall #-}

-- via http://learnyouahaskell.com/a-fistful-of-monads

type Birds = Int
type Pole  = (Birds, Birds)

landL :: Birds -> Pole -> Maybe Pole
landL n (l, r)
    | abs ((l + n) - r) < 4 = Just ((l + n), r)
    | otherwise             = Nothing

landR :: Birds -> Pole -> Maybe Pole
landR n (l, r)
    | abs (l - (r + n)) < 4 = Just (l, (r + n))
    | otherwise             = Nothing

demo1 :: IO ()
demo1 = do
    print $ landL   2  (0, 0)
    print $ landR   1  (1, 2)
    print $ landR (-1) (1, 2)

(-:) :: a -> (a -> b) -> b
x -: f = f x

demo2 :: IO ()
demo2 = do
    print $ (100 :: Int) -: (* 3)
    print $ True         -: not
    print $ (0, 0)       -: landL 2

demo3 :: IO ()
demo3 = do
    print $ Nothing        >>= landL 2
    print $ landR 1 (0, 0) >>= landL 2
    print $ return  (0, 0) >>= landR 2 >>= landL 2 >>= landR 2
    print $
        return (0, 0) >>= landL 1 >>= landR 4 >>= landL (-1) >>= landR (-2)
                                              -- this will trigger Nothing

banana :: Pole -> Maybe Pole
banana _ = Nothing

demo4 :: IO ()
demo4 = do
    print $ return (0, 0) >>= landL 1 >>= banana      >>= landR 1
    print $ return (0, 0) >>= landL 1 >>  Nothing     >>= landR 1
                                      -- generalized equivalent of 'banana'
    print $ return (0, 0) >>= landL 1 >>  Just (0, 0) >>= landR 1
                                      -- (>>) is something of a manual override

justH :: Maybe Char
justH = do
    (x:_) <- Just "Hello!"
    return x

demo5 :: IO ()
demo5 = do
    print justH

demo6 :: IO ()
demo6 = do
    print $ ([1, 2] :: [Int]) >>= \n -> ['a','b'] >>= \ch -> return (n,ch)
    let altDemo6 = do
        n  <- [1, 2] :: [Int]
        ch <- ['a', 'b']
        return (n, ch)
    print altDemo6
    print $ ([(n, ch) | n <- [1, 2], ch <- ['a', 'b']] :: [(Int, Char)])
    -- another alternative

routine :: Maybe Pole
routine = do
    start  <- return (0, 0)
    first  <- landL 2 start
    second <- landR 2 first
    landL 1 second

disaster :: Maybe Pole
disaster = do
    start  <- return (0, 0)
    first  <- landL 2 start
    _      <- Nothing       -- this interrupts the chain
    second <- landR 2 first -- still Nothing, despite calling 'first'
    landL 1 second          -- see (>>) above

main :: IO ()
main = do
    print routine
    print disaster
