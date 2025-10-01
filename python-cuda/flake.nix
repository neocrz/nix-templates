{
  description = "A Nix-flake-based Python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    forEachSupportedSystem = f:
      nixpkgs.lib.genAttrs supportedSystems (system:
        f {
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnfree = true;
              cudaSupport = true;
            };
          };
        });
  in {
    devShells = forEachSupportedSystem ({pkgs}: {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          (python3.withPackages (ps:
            with ps; [
              numpy
              pandas
              torchWithCuda
            ]))
          cudaPackages.cudatoolkit
        ];

        shellHook = ''
          echo "Python development environment with NumPy, Pandas, and PyTorch (CUDA)"
          export CUDA_PATH=${pkgs.cudaPackages.cudatoolkit}
          export LD_LIBRARY_PATH=${pkgs.cudaPackages.cudatoolkit}/lib64:$LD_LIBRARY_PATH
          echo "Run 'nvidia-offload python' to execute Python with NVIDIA GPU support"
        '';
      };
    });
  };
}
