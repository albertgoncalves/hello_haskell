{-# OPTIONS_GHC -Wall #-}

import Control.Monad (unless)
import UI.NCurses

waitFor :: Window -> (Event -> Bool) -> Curses ()
waitFor w p = loop
  where
    loop = do
        ev <- getEvent w Nothing
        case ev of
            Nothing -> loop
            Just ev' -> unless (p ev') loop

main :: IO ()
main =
    runCurses $ do
        setEcho False
        w <- defaultWindow
        updateWindow w $ do
            moveCursor 1 10
            drawString "Hello world!"
            moveCursor 3 10
            drawString "(press q to quit)"
            moveCursor 0 0
        render
        waitFor w (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')
