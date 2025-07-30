{ config, ... }:
{
  config.programs.alacritty = {
    # Alacritty - Terminal Emulator
    # https://github.com/alacritty/alacritty
    enable = true;
    settings = {
      # See `man 5 alacritty` for more information
      window = {
        opacity = 0.9;
        dynamic_padding = true;
        blur = true;
      };
    };
  };
}
