{ config, pkgs, ... }:
{
  config = {
    fonts = {
      packages = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "JetBrainsMono"
            # "Iosevka"
            "FiraCode"
          ];
        })
        cm_unicode
        corefonts
      ];

      enableDefaultPackages = true;

      fontconfig = {
        defaultFonts = {
          monospace = [ "JetBrainsMono" ];
          sansSerif = [ "JetBrainsMono" ];
          serif = [ "JetBrainsMono" ];
        };
      };
    };

    stylix = {
      # Theming framework for NixOS
      # https://github.com/danth/stylix
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      polarity = "dark";
      image = ./wp.png;
    };
  };
}
