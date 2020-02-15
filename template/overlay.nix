self: super:
  let
    unstable = import <nixpkgs-unstable> {};
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
          hspec-wai = unstable.haskellPackages.hspec-wai_0_10_1;
          hspec-wai-json = unstable.haskellPackages.hspec-wai-json_0_10_1;
          scotty = unstable.haskellPackages.scotty;
          ormolu = unstable.haskellPackages.ormolu;
          persistent-migration = dontCheck persistent-migration;
        }
      );
    }
