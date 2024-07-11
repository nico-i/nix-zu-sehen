{
  pkgs,
  system,
  inputs,
  config,
  helperLib,
  ...
}: let
  cfg = config.customNixosConfig;

  systemModules = helperLib.modules.injectEnableOptionIntoModules {
    modulesDirPath = ./system;
    customConfig = cfg;
    customConfigName = "customNixosConfig";
  };
  
in {
  imports = []
    ++ systemModules;
}