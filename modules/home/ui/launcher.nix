{ config, ... }:
{
  config.programs.tofi = {
    # window switcher, application launcher and dmenu replacement
    # https://github.com/philj56/tofi
    enable = true;
    # See https://github.com/philj56/tofi/blob/master/doc/config for a full list of options.
    settings = {
      # Set the font used in tofi
      font = "monospace";
      # Set the size of the font
      fontSize = 12;
      # Set the color scheme for tofi
      colorScheme = "default";
      # Set the maximum number of results displayed
      maxResults = 10;
    };
  };
}
