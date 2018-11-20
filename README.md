# Hello, Haskell!

A home for code written along the long path to learning Haskell. Still a ways to go.

Needed things
---
  * GHC 8.4.3
  * [random](http://hackage.haskell.org/package/random-1.1/docs/System-Random.html)
  * [tf-random](http://hackage.haskell.org/package/tf-random-0.5/docs/System-Random-TF.html)
  * [vector](http://hackage.haskell.org/package/vector-0.12.0.1/docs/Data-Vector.html)
  * or [Nix](https://nixos.org/nix/)!
---
In order to ease installation pain, I took the route of getting started with the [Haskell Platform](https://www.haskell.org/platform/). A more reproducible (and efficient) approach is in the works. If you're cool with installing a large suite of libraries at the root level, that will get you up and running.

Alternatively, if you have **Nix**,
```
$ nix-shell
```
will get you going... but only in the subdirectories that contain a `shell.nix` file.

---
With the Haskell Platform installed or a `nix-shell`, any given script can be compiled and run with:
```bash
$ ghc FILENAME.hs
$ ./FILENAME
```
Or interpreted at run-time with:
```bash
$ runhaskell FILENAME.hs
```
