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
        withfzf() { $1 "$(fzf)"; }
        hlintnc() { hlint -c=never $1; }
        alias vimfzf="withfzf vim"
        alias runfzf="withfzf runhaskell"
        alias hlifzf="withfzf hlintnc"
    '';
}
