{ pkgs ? import <nixpkgs> {} }:

with pkgs; mkShell {
    name = "haskell";
    buildInputs = [ (haskell.packages.ghc844.ghcWithPackages (pkgs: [
                      pkgs.http-conduit
                      pkgs.HTTP
                      pkgs.tagsoup
                      pkgs.hlint
                    ]))
                    fzf
                  ];
    shellHook = ''
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }
        hlintnc() { hlint -c=never $1; }
        strcd() { cd "$(dirname $1)"; }
        alias cdfzf="withfzf strcd"
        alias vimfzf="withfzf vim"
        alias runfzf="withfzf runhaskell"
        alias hlifzf="withfzf hlintnc"
    '';
}
