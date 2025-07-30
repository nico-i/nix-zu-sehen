{ pkgs, ... }:
{
  config = {
    programs.hyprland = {
      enable = true; # Wayland-based compositor https://hypr.land/
      withUWSM = true; # Enable UWSM (Unified Wayland Session Manager) for Hyprland
    };

    services.greetd = {
      # Greetd is a lightweight display manager
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.wlgreet}/bin/wlgreet --command Hyprland";
          user = "greeter";
        };
      };
    };

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
