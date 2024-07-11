/* This expression defines the available options in nixosModulesConfig */
{
  config,
  helperLib,
  ...
}: let
  cfg = if builtins.isAttr config.nixosModulesConfig
    then config.nixosModulesConfig
    else throw "nixosModulesConfig is not defined in the configuration";

  systemModules = helperLib.modules.injectEnableOptionIntoModules ({
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