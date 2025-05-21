# Aaron's Nix Flake

## Overview

This repository contains personal NixOS and home-manager configurations, managed as a Nix Flake using snowfall-lib. It defines system configurations, home environments, and reusable modules.

## Structure

The repository is organized as follows:

- **`systems/`**: Contains NixOS configurations for different machines.
  - `aarch64-darwin/`: Configurations for Apple Silicon Macs.
  - `x86_64-linux/`: Configurations for x86_64 Linux machines.
- **`homes/`**: Contains home-manager configurations for different users and machines.
  - `aarch64-darwin/`: Home configurations for Apple Silicon Macs.
  - `x86_64-linux/`: Home configurations for x86_64 Linux machines.
- **`modules/`**: Contains reusable NixOS and home-manager modules.
  - `darwin/`: Modules specific to macOS.
  - `nixos/`: Modules specific to NixOS.
  - `home/`: Modules for home-manager.
  - `shared/`: Modules common across different systems/users.
- **`overlays/`**: Contains Nix package overlays.
- **`lib/`**: Contains helper functions and libraries, primarily for snowfall-lib.
- **`flake.nix`**: The main Nix Flake definition.
- **`justfile`**: Contains `just` commands for common tasks (you might need to infer or ask for common tasks if not obvious).
- **`checks/`**: Contains pre-commit checks.
- **`keys/`**: Contains public keys or configurations related to secrets (e.g. sops).
- **`shells/`**: Defines development shells.

## Usage

This section will describe how to use the flake to build system configurations and home-manager profiles.

### Building System Configurations

To build and activate a NixOS system configuration:

For Linux systems:
```bash
just rebuild <hostname>
# or
nixos-rebuild switch --flake .#<hostname>
```

For macOS systems (Darwin):
```bash
just rebuild <hostname>
# or
nix run nix-darwin -- switch --flake .#<hostname>
```
Replace `<hostname>` with the actual hostname defined in the `systems/` directory (e.g., `coruscant`, `endor`).

### Building Home Manager Configurations

To build and activate a home-manager configuration:

```bash
home-manager switch --flake .#<username@hostname>
```
Replace `<username@hostname>` with the actual user and hostname defined in the `homes/` directory (e.g., `aaron@coruscant`).

### Development Shells

This flake defines development shells in `shells/`. You can enter a shell using:
```bash
nix develop .#<shellname>
```
For example, to enter the default shell:
```bash
nix develop .
```

### Managing Secrets

Secrets are managed using `sops-nix` and [Mozilla SOPS](https://github.com/mozilla/sops).
The `justfile` provides helpers:
- `just edit-user-secrets`: Edit home-manager secrets.
- `just edit-system-secrets`: Edit NixOS system-wide secrets.
- `just save-sops-key`: Saves the SOPS AGE key from Pulumi state to `~/.config/sops/age/keys.txt` for decryption.

### Other Useful Commands (from `justfile`)

- `just check`: Run flake checks (uses Docker on macOS).
- `just clean`: Collect garbage and delete old Nix store paths.
- `just ssh <hostname> [args]`: SSH into a managed host (keys managed by Pulumi).
- `just repl`: Start a Nix REPL with the flake's context.
- `just bootstrap-build [mode=remote|local]`: Build the NixOS ISO image.
- `just bootstrap-write <device>`: Write the built ISO to a device.

Refer to the `justfile` for more commands and details.

## Customization

This section will provide guidance on how to customize the configurations for new systems or users.

### Adding a New NixOS System

1.  **Define the system:**
    *   Create a new directory under `systems/<architecture>/<new_hostname>/` (e.g., `systems/x86_64-linux/newmachine/`).
    *   Add a `default.nix` file in this directory. This file should import `snowfall-lib` and define a `nixosSystem` using `lib.mkSystem`.
    *   You'll typically define system-specific hardware configurations, network settings, and import shared modules.
    *   Reference existing system configurations (e.g., `systems/x86_64-linux/coruscant/default.nix`) for an example structure.
2.  **Add system secrets (if any):**
    *   If the system requires specific secrets, configure them in `modules/nixos/secrets.yaml` and ensure SOPS can access the necessary keys.
3.  **Build the configuration:**
    *   Use `just rebuild <new_hostname>` or `nixos-rebuild switch --flake .#<new_hostname>`.

### Adding a New Home Manager Configuration

1.  **Define the home configuration:**
    *   Create a new directory under `homes/<architecture>/<new_username@new_hostname>/` (e.g., `homes/x86_64-linux/newuser@newmachine/`). If it's for an existing system but a new user, use the existing system's hostname.
    *   Add a `default.nix` file. This file should import `snowfall-lib` and define a `homeManagerConfiguration` using `lib.mkHome`.
    *   Import desired home-manager modules (e.g., for specific programs, shell setup, themes).
    *   Reference existing home configurations (e.g., `homes/x86_64-linux/aaron@coruscant/default.nix`) as a template.
2.  **Add user secrets (if any):**
    *   If the user configuration requires specific secrets, configure them in `modules/home/secrets.yaml`.
3.  **Build the configuration:**
    *   Use `home-manager switch --flake .#<new_username@new_hostname>`.

### Adding Modules

-   **NixOS Modules:** Place new NixOS modules under `modules/nixos/`. They can then be imported in system configurations.
-   **Home Manager Modules:** Place new home-manager modules under `modules/home/`. They can be imported in home configurations.
-   **Shared Modules:** For configurations applicable to both NixOS and home-manager, or across different types of systems, place them in `modules/shared/`.

## Key Technologies

- **Nix / NixOS**
- **Nix Flakes**
- **home-manager**
- **snowfall-lib**
- **disko** (for disk partitioning)
- **sops-nix** (for secrets management)
- **Catppuccin** (theme)
- **Hyprland** (window manager, based on inputs)
- **Nixvim** (Neovim configuration)
- **pre-commit hooks** (for code quality)
- **GitHub Actions** (for CI/CD)
