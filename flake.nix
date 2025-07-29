{
  description =
    "Nico's nix configuration flake defining all dependencies and outputs necessary for a NixOS system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xremap.url = "github:xremap/nix-flake";

    hyprland.url = "github:hyprwm/Hyprland";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { ... }@inputs:
    let helperLib = (import ./lib) { inherit inputs; };
    in with helperLib.build; {
      # === NixOS ===
      # NixOS configurations this flake should build when running `nixos-rebuild switch`
      # see https://nixos.wiki/wiki/Flakes#Output_schema for more information
      nixosConfigurations = {
        # each config can be selected using `#<config-name>`.
        # Example: `nixos-rebuild switch --flake ./flake.nix#mbvm`
        mbvm = mkNixOSSystem { nixosCfgPath = ./hosts/mbvm/configuration.nix; };
      };
      # Entrypoint for NixOS to import modules
      nixosModules.default = ./modules/nixos;

      # === Darwin ===
      # darwin configurations this flake should build when running `darwin-rebuild switch`
      darwinConfigurations = {
        mb = mkDarwinSystem { darwinCfgPath = ./hosts/mb/configuration.nix; };
      };
      # Entrypoint for nix-darwin to import modules
      darwinModules.default = ./modules/darwin;

      # === Home Manager ===
      # home-manager configurations this flake should build when running `home-manager switch`
      homeConfigurations = {
        # each configuration here builds a home configuration based on the given configuration
        "nico@mbvm" = mkHomeConfig {
          system = "armv6l-linux";
          homeCfgPath = ./hosts/mbvm/users/nico/home.nix;
        };

        "nico@mb" = mkHomeConfig {
          system = "aarch64-darwin";
          homeCfgPath = ./hosts/mb/users/nico/home.nix;
        };
        "work@mb" = mkHomeConfig {
          system = "aarch64-darwin";
          homeCfgPath = ./hosts/mb/users/work/home.nix;
        };
      };
      # Entrypoint for Home Manager to import modules
      homeManagerModules.default = ./modules/home;
    };
}
