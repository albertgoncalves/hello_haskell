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
        hlintnc() { hlint -c=never $1; }
        strcd()   { cd "$(dirname $1)"; }
        withfzf() {
            local h
            h=$(fzf)
            if (( $? == 0 )); then
                $1 "$h"
            fi
        }

        alias  cdfzf="withfzf strcd"
        alias hlifzf="withfzf hlintnc"
        alias runfzf="withfzf runhaskell"
        alias vimfzf="withfzf vim"

        export -f withfzf
    '';
}
