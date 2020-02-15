#!/bin/sh

set -e

# Disable HTTP2 (related to https://github.com/NixOS/nix/issues/2733)
echo 'http2 = false' >> /etc/nix/nix.conf
nix-channel --add https://nixos.org/channels/nixos-19.09 nixpkgs
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs-unstable
nix-channel --update
nix-env -iA nixpkgs.openssh nixpkgs.git nixpkgs.docker nixpkgs.cabal2nix
cabal2nix . > pkg.nix
# cabal2nix https://github.com/coingaming/persistent-migration.git > persistent-migration.nix
# cabal2nix https://github.com/coingaming/HaskellNet.git > haskell-net.nix
mkdir -p $HOME/.ssh/
echo "$ROBOT_SSH_KEY" | base64 -d > $HOME/.ssh/id_rsa.robot && chmod 600 $HOME/.ssh/id_rsa.robot && ssh-add $HOME/.ssh/id_rsa.robot
echo -e "Host *\n IdentityFile $HOME/.ssh/id_rsa.robot\n IdentitiesOnly yes" > $HOME/.ssh/config
ssh-keyscan github.com >> $HOME/.ssh/known_hosts
# git submodule foreach git pull && git submodule update --init --recursive
NIXPKGS_ALLOW_BROKEN=1 nix-build docker.nix

