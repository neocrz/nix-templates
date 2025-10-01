{
  description = "Dev shell using my-nvf via a direct nixpkgs import with an overlay";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-neocrz = {
      url = "github:neocrz/my-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-neocrz,
    ...
  } @ inputs: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];

    forEachSystem = nixpkgs.lib.genAttrs supportedSystems;
  in {
    devShells = forEachSystem (
      system: let
        myPkgs = final: prev: {
          neocrz = nixpkgs-neocrz.overlays.default final prev;
        };
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            myPkgs
          ];
        };
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [
            neocrz.nvf

            pkgs.git
            pkgs.nixpkgs-fmt
          ];

          shellHook = ''
            echo "Welcome to the dev shell!"
          '';
        };
      }
    );
  };
}
