{
  description = "A Nix-flake-based Zig development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in
    {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            zls
            zig_0_14
            valgrind
            gdb
            python3
            glfw
            libGL
            clang-tools
            linuxPackages_latest.perf
            kcov
          ];
        };
      });
    };
}
