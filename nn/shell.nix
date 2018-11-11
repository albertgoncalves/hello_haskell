{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "haskell";
    buildInputs = [ (haskell.packages.ghc844.ghcWithPackages (pkgs: [
                      pkgs.vector
                      pkgs.random
                      pkgs.tf-random
                      pkgs.hlint
                    ]))
                    libiconv
                    fzf
                  ];
    shellHook = ''
        withfzf() { $1 "$(fzf)"; }
        alias vimfzf="withfzf vim"
        alias runfzf="withfzf runhaskell"
        alias hlifzf="withfzf hlint -c=never"
    '';
}
