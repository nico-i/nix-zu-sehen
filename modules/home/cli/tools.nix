{ config, ... }: {
  config.programs = {
    zoxide = {
      # A smarter cd command https://github.com/ajeetdsouza/zoxide
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
    bottom = {
      enable =
        true; # Bottom - A terminal-based graphical activity monitor # https://github.com/ClementTsang/bottom
    };
  };
}
