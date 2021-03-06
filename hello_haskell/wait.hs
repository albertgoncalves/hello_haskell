{-# OPTIONS_GHC -Wall #-}

import Control.Concurrent (forkIO, threadDelay)
import Control.Concurrent.MVar (newEmptyMVar, putMVar, takeMVar)

sleepSeconds :: Int -> IO ()
sleepSeconds n = threadDelay (n * (10 ^ (6 :: Integer)))

main :: IO ()
main = do
    result <- newEmptyMVar
    let seconds = 3 :: Int
    -- A do-notation statement discarded a result of type
    --       ‘GHC.Conc.Sync.ThreadId’
    --     Suppress this warning by saying
    --       ‘_ <- forkIO (...)
    _ <-
        forkIO
            (do sleepSeconds seconds -- let's pretend there is
                putStrLn "Calculated result!" -- some actual work to do
                putMVar result (42 :: Int))
    putStrLn $ "Waiting ~" ++ show seconds ++ " seconds..."
    value <- takeMVar result
    putStrLn $ "The answer is... " ++ show value ++ "!"
