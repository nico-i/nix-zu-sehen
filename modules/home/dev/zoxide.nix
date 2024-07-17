# https://github.com/ajeetdsouza/zoxide
{ config, ... }: {
  config.programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}