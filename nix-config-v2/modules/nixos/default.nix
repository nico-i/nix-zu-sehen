/* This expression defines the available options in nixosModulesConfig */
{
  config,
  helperLib,
  ...
}: let
  cfg = config.nixosModulesConfig;

  systemModules = (helperLib.modules.injectEnableOptionIntoModules {
    modulesDirPath = ./system;
    customConfig = cfg;
    customConfigName = "nixosModulesConfig";
  });
  
in {
  imports = []
    ++ systemModules;
  
  config = { # Default nixos configurations
    nix.settings.experimental-features = ["nix-command" "flakes"]; # enable flakes and nix-command
    nixpkgs.config.allowUnfree = true; # Allow unfree repos
  };
}