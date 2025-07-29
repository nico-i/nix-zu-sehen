{ ... }:
{
  config = {
    programs = {
      hyprland.enable = true; # Wayland-based compositor https://hypr.land/
    };
    services.xserver.enable = true;

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      defaultSession = "hyprland";
    };

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
      WLR_NO_HARDWARE_CURSORS = "1"; # disable hardware cursors to fix invisible cursors on some machines:
    };
  };
}
