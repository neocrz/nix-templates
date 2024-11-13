{
  description = "My templates based on the-nix-way/dev-templates";
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
    templates = rec {
      default = empty;
      empty = {
        path = ./empty;
        description = "Empty dev template that you can customize at will";
      };
      python = {
        path = ./python;
        description = "Python Project";
      };
      r = {
        path = ./r;
        description = "R Project";
      };
    };
  };
}
