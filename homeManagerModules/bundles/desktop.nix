{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {

  options = {
    myHomeManager.startupScript = lib.mkOption {
      default = "";
      description = ''
        Startup script
      '';
    };
  };

  config = {
    myHomeManager.zathura.enable = lib.mkDefault true; # pdf viewer
    myHomeManager.rofi.enable = lib.mkDefault true; # Window switcher, run dialog and dmenu replacement
    myHomeManager.alacritty.enable = lib.mkDefault true; # lightweight terminal emulator
    myHomeManager.kitty.enable = lib.mkDefault true; # terminal emulator with dev sugar
    myHomeManager.xremap.enable = lib.mkDefault true; # keymapper

    myHomeManager.gtk.enable = lib.mkDefault true; # graphical tool kit (necessary for theming)

    home.file = {
      ".local/share/rofi/rofi-bluetooth".source = "${pkgs.rofi-bluetooth}";
    };

    qt.enable = true;
    qt.platformTheme = "gtk";
    qt.style.name = "adwaita-dark";

    home.sessionVariables = {
      QT_STYLE_OVERRIDE = "adwaita-dark";
    };

    services.udiskie.enable = true; # front-end that allows to manage removable media such as CDs or flash drives from userspace

    xdg.mimeApps.defaultApplications = {
      "text/plain" = ["neovide.desktop"];
      "application/pdf" = ["zathura.desktop"];
      "image/*" = ["imv.desktop"];
      "video/png" = ["mpv.desktop"];
      "video/jpg" = ["mpv.desktop"];
      "video/*" = ["mpv.desktop"];
    };

    programs.imv = {
      enable = true;
      settings = {
        options.background = "${config.colorScheme.palette.base00}";
      };
    };
    
    # audio noise cancellation tool
    programs.noisetorch.enable = true;
   
    services.mako = { # lightweight notification daemon for Wayland
      enable = true;
      backgroundColor = "#${config.colorScheme.palette.base01}";
      borderColor = "#${config.colorScheme.palette.base0E}";
      borderRadius = 5;
      borderSize = 2;
      textColor = "#${config.colorScheme.palette.base04}";
      defaultTimeout = 10000;
      layer = "overlay";
    };

    home.packages = with pkgs; [
      feh # terminal image viewer
      polkit
      polkit_gnome
      lxsession # session manager to auto start applications and configure things
      pulsemixer # volume mixer for PulseAudio
      pavucontrol # volume control
      adwaita-qt # native style to bend Qt5/Qt6 applications to look like they belong into GNOME Shell
      pcmanfm # file manager
      libnotify # mako dep

      pywal # generates color palettes based on an image
      neovide # neovim gui
      ripdrag # terminal tool to drag and drop files from and to the terminal
      mpv # media player
      sxiv # image viewer
      zathura # pdf viewer

      lm_sensors # temp and sensor monitor tools
      upower # power management tool

      cm_unicode # unicode support

      # terminal emulators
      wezterm
      kitty
      
      # onlyoffice-bin # leading ms-office alternative
      easyeffects # PipeWire audio plugins
      gegl # command line image processing
    ];
  };
}
