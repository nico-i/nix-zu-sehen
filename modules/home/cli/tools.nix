{ config, ... }:
{
  config.programs = {
    fzf.enable = true; # Fuzzy Finder https://junegunn.github.io/fzf/
    zoxide = {
      # A smarter cd command https://github.com/ajeetdsouza/zoxide
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    bottom = {
      # Bottom - A terminal-based graphical activity monitor # https://github.com/ClementTsang/bottom
      enable = true;
    };
  };
}
