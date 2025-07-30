{ config, pkgs, ... }:
{
  config = {
    fonts = {
      packages = with pkgs; [
        nerd-fonts.geist-mono
        cm_unicode
        corefonts
      ];

      enableDefaultPackages = true;

      fontconfig = {
        defaultFonts = {
          monospace = [ "GeistMono" ];
          sansSerif = [ "GeistMono" ];
          serif = [ "GeistMono" ];
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
          package = pkgs.nerd-fonts.geist-mono;
          name = "Geist Mono";
        };
        serif = config.stylix.fonts.sansSerif;
        sansSerif = config.stylix.fonts.monospace;
      };
    };
  };
}
