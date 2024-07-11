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

    home.packages = with pkgs; [
      feh # terminal image viewer
      polkit
      polkit_gnome
      lxsession # session manager to auto start applications and configure things

      ripdrag # terminal tool to drag and drop files from and to the terminal
      mpv # media player
      zathura # pdf viewer

      lm_sensors # temp and sensor monitor tools
      upower # power management tool

      cm_unicode # unicode support

      # terminal emulators
      kitty
      
      easyeffects # PipeWire audio plugins
      gegl # command line image processing
    ];
  };
}
