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
    templateNames = [ 
        "empty" 
        "python"
        "r"
        "zig"
    ];
    templates = nixpkgs.lib.listToAttrs (map (name: {
      inherit name;
      value = {
        path = ./${name};
        description = "${name} Project";
      };
      }) templateNames) // { default = templates.empty; };
  in
  {
    inherit templates;
  };
}
