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
            command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --cmd Hyprland";
            user = "greeter";
          };
      };
    };

    # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
    systemd.services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal"; # Without this errors will spam on screen
      # Without these bootlogs will spam on screen
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;


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
        defaultSession = "hyprland-uwsm";
      };
    };

  };
}
