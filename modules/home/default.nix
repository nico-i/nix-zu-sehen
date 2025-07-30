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

  options.customHomeConfig.startupScript = lib.mkOption {
    default = "";
    description = ''
      Startup script
    '';
  };

  config = {
    # home-manager configuration defaults
    programs.home-manager.enable = true;
    programs.zsh.enable = true; # Enable Zsh shell
  };
}
