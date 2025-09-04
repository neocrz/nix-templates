{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let 
    overlays = [];
    supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
    forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
      pkgs = import nixpkgs { inherit overlays system; };
    });

  in
  {
    devShells = forEachSupportedSystem ({ pkgs }: {
      default = pkgs.mkShell {
        # The Nix packages provided in the environment
        # Add any you need here
        packages = with pkgs; [ ];

        # Set any environment variables for your dev shell
        env = { };

        # Add any shell logic you want executed any time the environment is activated
        shellHook = ''
        '';
      };
    });
  };
}
