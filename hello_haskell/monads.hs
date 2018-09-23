{-# OPTIONS_GHC -Wall #-}

-- via https://www.youtube.com/watch?v=t1e8gqXLbsU

-- Let's define an arbitrary data type to simply perform integer (well, *int*)
-- division.
data Expr = Val Int
          | Div Expr Expr
  deriving (Show)

-- But wait, this function can fail! (m == 0)
    -- How might be make our program 'safer'?
evalA :: Expr -> Int
evalA (Val n)   = n
evalA (Div n m) = div (evalA n) (evalA m)


-- -*-


-- First, it will be helpful to have a safer division function.
safeDiv :: Int -> Int -> Maybe Int
safeDiv _ 0 = Nothing
safeDiv n m = Just $ div n m

-- The wrapping of our returned Int value in a Maybe provides a framework for
-- maintaining well-defined values. In the case of 'div _ 0', we will simply be
-- giving a Nothing, otherwise we will get back Just _, the result of the
-- division statement. Already, just at a glance, our code looks safe and we
-- know a lot about what it does.

-- With our now function, we will need to handle all the possible scenarios
-- that could arise en route to using our new function.
evalB :: Expr -> Maybe Int
evalB (Val n)   = Just n
evalB (Div n m) = case (evalB n) of
                    Nothing -> Nothing
                    Just x  -> case (evalB m) of
                      Nothing -> Nothing
                      Just y  -> safeDiv x y

-- This is indeed safer, but it is ugly and we can see a repeative pattern at
-- play in the definition of (Div n m).

-- So, how might we be able to rewrite this function?


-- -*-


-- This abstracts the repeated pattern in the above solution with the use of
-- '>>=' + lambda functions.
evalC :: Expr -> Maybe Int
evalC (Val n)   = return n -- syntactic sugar for 'Just n'
evalC (Div n m) = (evalC n) >>= (\x ->
                  (evalC m) >>= (\y -> safeDiv x y))

-- The definition of (Div n m) here can be read exactly the same as the
-- corresponding definition in evalB:
    -- apply evalC to n,
        -- if Nothing, give back a Nothing and stop there
        -- else, apply evalC to m and follow the same logic
            -- if both have yielded Just _, apply safeDiv to these two values
-- Note that safeDiv takes two Int values, not two Maybe Int values; this is
-- the 'Maybe Monad' in action!

-- Syntactic sugar; this is the same as the evalC. This looks very clean!
evalD :: Expr -> Maybe Int
evalD (Val n)   = return n
evalD (Div n m) = do x <- (evalD n)
                     y <- (evalD m)
                     safeDiv x y

-- evalC and evalD are examples of the 'Maybe Monad', which defined by two
-- operations:
    -- Maybe Monad
        -- return :: a -> Maybe a
        -- >>=    :: Maybe a -> (a -> Maybe b) -> Maybe b
            -- (referred to as 'sequencing')

-- This acts as a bridge from the pure world of values to the impure world of
-- things-that-could-go-wrong.

main :: IO ()
main = do
    let myJustInt   = ((Val 3), (Val 1))
    let myNothing   = ((Val 3), (Val 0))
    let myVals      = [myJustInt, myNothing] :: [(Expr, Expr)]
    let mySafeEvals = [evalB, evalC, evalD]  :: [Expr -> Maybe Int]
    let uncurryDiv  = uncurry Div

    print $ evalA $ uncurryDiv myJustInt
    print $ "error" -- result of 'evalA $ uncurryDiv myNothing'
    print $ [f $ uncurryDiv a | f <- mySafeEvals, a <- myVals]

-- A few points on Monads:
    -- This structure can be applied to other effects (not specific to Maybe),
    -- can be used with IO, mutable state, system environments, wrting to file,
    -- etc..
        -- This gives a uniform framework for programming with effects.

    -- This allows for pure programming with effects.

    -- The use of effects is explicit in the types. We can reason about what
    -- this code does simply by looking at its type design.

    -- This framework additionally allows us to write functions that support
    -- *any* collection of effects; i.e. 'effect polymorphism'.
