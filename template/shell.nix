let overlays = [(import ./overlay.nix)];
    vimrc-awesome = import (fetchTarball "https://github.com/tim2CF/vimrc/tarball/master") {};
    all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
    hie = all-hies.unstable.selection { selector = p: { inherit (p) ghc865; }; };
in

{ pkgs ? import <nixpkgs> {inherit overlays;} }:
with pkgs;

let ghc = pkgs.haskellPackages.ghcWithPackages (hpkgs: with hpkgs;
  [
    stack
    cabal-install
    zlib
  ]
);
in

stdenv.mkDerivation {
  name = "p88lnd-env";
  buildInputs = [
    /* haskell */
    ghc
    /* editor */
    hie
    vimrc-awesome
    nodejs
    haskellPackages.ormolu
    haskellPackages.brittany
    haskellPackages.hindent
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.apply-refact
    /* other */
    curl
    postgresql
    nix
    less
    cacert
    xxd
    git
  ];

  TERM="xterm-256color";
  NIX_SSL_CERT_FILE = "${cacert}/etc/ssl/certs/ca-bundle.crt";
  shellHook = ''
    source ./export-dev-envs.sh
    sh ./reset-dev-data.sh
    sh ./spawn-dev-deps.sh

    export HOOGLEDB=/root/.hoogle
    if [ "$(ls -A $HOOGLEDB)" ]; then
      echo "hoogle database already exists..."
    else
      echo "building hoogle database..."
      stack --stack-yaml=/app/stack.yaml exec hoogle generate
    fi
  '';
}
