self: super:
  let
    callPackage = self.lib.callPackageWith self.haskellPackages;
    dontCheck = self.haskell.lib.dontCheck;
    doJailbreak = self.haskell.lib.doJailbreak;
    persistent-migration = callPackage ./persistent-migration.nix {
      stdenv = self.stdenv;
      fetchgit = self.fetchgit;
    };
  in
    {
      haskellPackages = super.haskell.packages.ghc865.extend(
        self': super': {
          proto3-suite = dontCheck (doJailbreak super'.proto3-suite);
          hspec-wai = self'.callHackage "hspec-wai" "0.10.1" {};
          hspec-wai-json = self'.callHackage "hspec-wai-json" "0.10.1" {};
          persistent-migration = dontCheck persistent-migration;
        }
      );
    }
