# https://github.com/danth/stylix
{ config, pkgs, ... }: {
    config = {
        stylix = {
            enable = true;
            base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
            polarity = "dark";
            image = ./wp.png;
        };
    };
}