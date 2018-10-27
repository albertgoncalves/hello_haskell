# Hello, Haskell!

A home for code written along the long path to learning Haskell. Still a ways to go.

Needed things
---
  * GHC 8.4.3
  * [Data.Vector](http://hackage.haskell.org/package/vector-0.12.0.1/docs/Data-Vector.html)
  * [Text.Parser.Combinators](https://hackage.haskell.org/package/parsers-0.12.9/docs/Text-Parser-Combinators.html)
---
In order to ease installation pain, I took the route of getting started with the [Haskell Platform](https://www.haskell.org/platform/). A more reproducible (and efficient) approach is in the works. If you're cool with installing a large suite of libraries at the root level, this will get you up and running.

---
With the Haskell Platform installed, any given script can be compiled and run with:
```bash
$ ghc FILENAME.hs
$ ./FILENAME
```
Or interpretted at run-time with:
```bash
$ runhaskell FILENAME.hs
```
