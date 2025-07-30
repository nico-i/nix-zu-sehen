{
  inputs,
  config,
  pkgs,
  ...
}:
{
  config = {
    fonts = {
      packages =
        with pkgs;
        [
          nerd-fonts.geist-mono # Geist Mono font
          nwg-look # Theme manager for Wayland
          cm_unicode # Unicode support
          corefonts # Microsoft core fonts
        ]
        ++ inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default # Rose Pine Hyprland cursor theme "https://github.com/ndom91/rose-pine-hyprcursor"
      ;

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
          name = "GeistMono";
        };
        serif = config.stylix.fonts.sansSerif;
        sansSerif = config.stylix.fonts.monospace;
      };
    };
  };
}
