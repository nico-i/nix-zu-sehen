{ config, ... }:
{
  config.programs.tofi = {
    # window switcher, application launcher and dmenu replacement
    # https://github.com/philj56/tofi
    enable = true;
    # See https://github.com/philj56/tofi/blob/master/doc/config for a full list of options.
    font = "monospace";
  };
}
