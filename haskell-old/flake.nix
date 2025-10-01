{
  description = "A Nix-flake-based Zig development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-old.url = "github:nixos/nixpkgs/aca0bbe791c220f8360bd0dd8e9dce161253b341"; # ghc 8.8.3
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-old,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {inherit system;};
          oldPkgs = import nixpkgs-old {inherit system;};
        });
  in {
    devShells = forEachSupportedSystem ({
      pkgs,
      oldPkgs,
    }: {
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs;
          [
            clang-tools
            cabal-install
            # ghc
            haskell-language-server
          ]
          ++ (with oldPkgs; [ghc]);
      };
    });
  };
}
