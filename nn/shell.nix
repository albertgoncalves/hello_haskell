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
        alias vimfzf='vim "$(fzf)"'
    '';
}
