# nix-templates

A collection of my own tailored Nix Flake templates to quickly bootstrap development environments. This project is inspired by and based on the great work from [the-nix-way/dev-templates](https://github.com/the-nix-way/dev-templates).

## Prerequisites

To use these templates, you need to have [Nix](https://nixos.org/download.html) installed with Flakes enabled.

For the best experience, it is highly recommended to also install [direnv](https://direnv.net/) to automatically load the development environment when you enter the project directory.

## Usage

You can create a new project from a template using the `nix flake init` command. The general format is:

```console
nix flake init --template github:neocrz/nix-templates#<template-name>
```

After initializing the project, if you are using `direnv`, run `direnv allow` to automatically load the Nix shell whenever you `cd` into the directory.

### Available Templates

- [`#empty`](#empty-template-default) (Default)
- `#python`
- `#r`
- `#zig`
- ...and more to come!

---

### Empty Template (Default)

This is a minimal, bare-bones flake for starting a new Nix project from scratch. It provides the essential structure for a `flake.nix` file with a `devShell` but includes no pre-installed packages, making it a clean slate for any kind of project.

**Command:**
```console
# This is the default, so you can omit the template name
nix flake init --template github:neocrz/nix-templates

# Or be explicit
nix flake init --template github:neocrz/nix-templates#empty
```

**Features:**
- A standard, well-structured `flake.nix`.
- An empty `packages` list in `devShells.default` for you to fill in.
- A `.envrc` file pre-configured for `direnv` with `use flake`.

### Language-Specific Templates (python, r, zig, etc.)

In addition to the minimal `empty` template, this repository provides several pre-configured environments for specific languages.

Each template is designed to be a sensible and productive starting point, bundling the language runtime itself along with common development tools such as:

- **Language Servers** (e.g., `zls` for Zig)
- **Package Managers** (e.g., `pip` for Python)
- **Interactive Environments** (e.g., `jupyterlab`, `RStudio`)
- **Debugging and Profiling Tools**

These templates give you a ready-to-use environment out of the box. To see the exact packages included in a specific template, simply inspect its `flake.nix` file after initialization.

**Example Commands:**
```console
nix flake init --template github:neocrz/nix-templates#python
nix flake init --template github:neocrz/nix-templates#r
nix flake init --template github:neocrz/nix-templates#zig
```

---

## Customization

After initializing a project, you can easily customize the environment by editing the `flake.nix` file. Simply add or remove packages from the `packages` (or `nativeBuildInputs`) list to suit your needs.

For example, to add `ripgrep` and `fd` to the `empty` template, you would modify the `packages` list like this:

```nix
# In flake.nix
# ...
        packages = with pkgs; [
          ripgrep
          fd
        ];
# ...
```

After saving the file, `direnv` will automatically prompt you to reload the environment with the new packages.
