{ config, pkgs, ... }: {
  config = {
    stylix = {
      # Theming framework for NixOS
      # https://github.com/danth/stylix
      enable = true;
      base16Scheme =
        "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      polarity = "dark";
      image = ./wp.png;
    };
  };
}
