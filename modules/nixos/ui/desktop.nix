{ pkgs, ... }:
{
  option.customHomeConfig.startupScript = lib.mkOption {
    default = "";
    description = ''
      Startup script
    '';
  };

  config = {
    programs.hyprland.enable = true; # Wayland-based compositor https://hypr.land/

    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdg.portal.enable = true;

    environment = {
      systemPackages = with pkgs; [
        libsForQt5.qt5.qtquickcontrols2
        libsForQt5.qt5.qtgraphicaleffects
      ];
      sessionVariables = {
        NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
      };
    };

    services = {
      xserver.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "hyprland";
      };
    };

  };
}
