# This expression defines the available options in customHomeConfig
{
  config,
  helperLib,
  lib,
  ...
}:
let
  cfg = config.customHomeConfig;

  homeConfigModules = map (
    dir:
    helperLib.modules.injectEnableOptionIntoModules {
      modulesDirPath = ./${dir};
      customConfig = cfg;
      customConfigName = "customHomeConfig";
    }
  ) (helperLib.fs.listDirsInDir { dir = ./.; });
in
{
  imports = [ ] ++ lib.lists.flatten homeConfigModules;
  config = {
    # home-manager configuration defaults
    programs.home-manager.enable = true;
    programs.zsh.enable = true; # Enable Zsh shell
  };
}
