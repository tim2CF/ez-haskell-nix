let overlays = [(import ./overlay.nix)];
in
  { pkgs ? import <nixpkgs-unstable> {inherit overlays;} }:
    with pkgs;
      /*  */
      /* TODO : minimize docker image size */
      /*  */
      let callPackage = lib.callPackageWith haskellPackages;
          pkg = callPackage ./pkg.nix {inherit stdenv;};
          cacert = pkgs.cacert;
          systemDeps = [ protobuf makeWrapper cacert ];
          testDeps = [ postgresql ];
      in
        haskell.lib.overrideCabal pkg (drv: {
          setupHaskellDepends = if drv ? "setupHaskellDepends" then drv.setupHaskellDepends ++ systemDeps else systemDeps;
          testSystemDepends = if drv ? "testSystemDepends" then drv.testSystemDepends ++ testDeps else testDeps;
          isExecutable = true;
          enableSharedExecutables = false;
          enableLibraryProfiling = false;
          isLibrary = false;
          preCheck  = ''
            source ./export-dev-envs.sh;
            sh ./reset-dev-data.sh;
            sh ./spawn-dev-deps.sh;
          '';
          /* doCheck = false; */
          doHaddock = false;
          postFixup = "rm -rf $out/lib $out/nix-support $out/share/doc";
          postInstall = ''
            wrapProgram "$out/bin/TODO_DEFINE_APP-exe" \
              --set SYSTEM_CERTIFICATE_PATH "${cacert}/etc/ssl/certs"
          '';
        })
