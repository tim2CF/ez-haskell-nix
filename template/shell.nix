let overlays = [(import ./overlay.nix)];
    haskell-ide = import (fetchTarball "https://github.com/tim2CF/vimrc/tarball/master") {};
in

{ pkgs ? import <nixpkgs> {inherit overlays;} }:
with pkgs;

stdenv.mkDerivation {
  name = "TODO_DEFINE_APP-env";
  buildInputs = [
    /* IDE */
    haskell-ide
    /* Apps */
    postgresql
    /* Utils */
    cacert
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
