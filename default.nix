{ pkgs ? import <nixpkgs> {} }:
with pkgs;

let ignore-patterns = ''
      .git
      result
    '';
in
    stdenv.mkDerivation {
      name = "ez-haskell-nix";
      src = nix-gitignore.gitignoreSourcePure ignore-patterns ./.;
      propagatedBuildInputs = [coreutils];
      dontBuild = true;
      installPhase = ''
        mkdir -p $out/
        cp -R ./ $out/
      '';
    }
