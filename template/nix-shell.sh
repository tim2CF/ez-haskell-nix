#!/bin/sh

export IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
echo "host is $IP"
echo "starting nixos container..."
# enable for GUI apps
# xhost + $IP
docker run -it --rm \
  -e DISPLAY=$IP:0 \
  -e NIXPKGS_ALLOW_BROKEN=1 \
  -v "$(pwd):/app" \
  -v "nix:/nix" \
  -v "stack:/root/.stack" \
  -v "cabal:/root/.cabal" \
  -v "hoogle:/root/.hoogle" \
  -w "/app" nixos/nix:2.3 sh -c "
  nix-channel --update &&
  nix-env -iA cachix -f https://cachix.org/api/v1/install &&
  cachix use all-hies &&
  nix-shell --pure
  "
