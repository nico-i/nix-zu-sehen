# {
#   description = "Nico's NixOS config flake";

#   inputs = {
#     # allows for the most current nix package versions
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

#     # key remapper
#     xremap-flake.url = "github:xremap/nix-flake";

#     # home-manager allows configuring user based packages
#     # use `man home-configuration.nix` to find out more
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

#     # index db of all nix packages to enable installation suggestions
#     nix-index-database = {
#       url = "github:Mic92/nix-index-database";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

#     # Nix User Repo based firefox addons
#     firefox-addons = {
#       url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

#     # Nix-driven partitioning
#     disko = {
#       url = "github:nix-community/disko";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };

#     # centralized colors
#     nix-colors.url = "github:misterio77/nix-colors";

#     # Wayland based window manager
#     hyprland.url = "github:hyprwm/Hyprland";

#     # Tool to configure dirs and files to keep on root nuke
#     impermanence.url = "github:nix-community/impermanence";

#     # Restroactively persist dirs configured with impermanence
#     persist-retro.url = "github:Geometer1729/persist-retro";
#   };

#   outputs =
#     { ... }@inputs:
#     let
#       # lib to reduce boilerplate (credit: @vim-joyer)
#       myLib = import ./myLib/default.nix { inherit inputs; };
#     in
#     with myLib;
#     {

#       nixosConfigurations = {
#         # ===================== NixOS Configurations ===================== #        
#         desktop = mkSystem ./hosts/desktop/configuration.nix;
#       };

#       nixosModules.default = ./nixosModules;

#       homeConfigurations = {
#         # ================ home-manager configurations ================ #
#         "nico@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
#       };

#       homeManagerModules.default = ./homeManagerModules;
#     };
# }
