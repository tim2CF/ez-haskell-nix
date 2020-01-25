let pkg = import ./. {};
in

{ pkgs ? import <nixpkgs> {} }:
with pkgs;

dockerTools.buildImage {
  name = "heathmont/TODO_DEFINE_APP";
  contents = [ pkg ];

  config = {
    Cmd = [ "${pkg}/bin/TODO_DEFINE_APP-exe" ];
    ExposedPorts = {
      "80/tcp" = {};
    };
  };
}

