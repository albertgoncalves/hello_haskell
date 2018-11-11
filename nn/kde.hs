{-# LANGUAGE OverloadedStrings #-}

-- via https://github.com/bos/statistics/tree/master/examples/kde

import qualified Data.Attoparsec.ByteString       as B
import qualified Data.Attoparsec.ByteString.Char8 as A
import qualified Data.ByteString                  as B
import qualified Data.ByteString.Lazy             as L
import qualified Data.Vector.Unboxed              as U
import qualified Data.Text.Lazy.IO                as TL
import Statistics.Sample.KernelDensity (kde)
import Text.Hastache         (MuType(..), defaultConfig, hastacheFile)
import Text.Hastache.Context (mkStrContext)

csv = do
    B.takeTill A.isEndOfLine
    (A.double `A.sepBy` A.char ',') `A.sepBy` A.endOfLine

main = do
    waits <- either error (U.fromList . map last . filter (not.null)) .
             A.parseOnly csv <$>
             B.readFile "data/faithful.csv"
    let xs = map (\(a, b) -> [a, b]) .
             U.toList .
             uncurry U.zip .
             kde 64 $ waits
    let context "data" = MuVariable . show $ xs
    s <- hastacheFile defaultConfig "kde.tpl" (mkStrContext context)
    TL.writeFile "kde.html" s
