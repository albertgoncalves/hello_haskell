{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "haskell";
    buildInputs = [ (haskell.packages.ghc822.ghcWithPackages (pkgs: [
                      pkgs.vector
                      pkgs.random
                      pkgs.tf-random
                      pkgs.statistics
                      pkgs.hastache
                    ]))
                    libiconv
                    fzf
                    haskellPackages.hlint
                  ];
    shellHook = ''
        withfzf() { $1 "$(fzf)"; }
        hlintnc() { hlint -c=never $1; }
        alias vimfzf="withfzf vim"
        alias runfzf="withfzf runhaskell"
        alias hlifzf="withfzf hlintnc"
    '';
}
