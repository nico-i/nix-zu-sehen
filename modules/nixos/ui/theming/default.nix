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
          monospace = [ "FiraCode" ];
          sansSerif = [ "FiraCode" ];
          serif = [ "FiraCode" ];
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

      fonts = {
        monospace = {
          package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
          name = "JetBrainsMono";
        };

        serif = config.stylix.fonts.monospace;

        sansSerif = {
          package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
          name = "FiraCode";
        };
      };
    };
  };
}
