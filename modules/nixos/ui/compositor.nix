{ ... }: {
  config = {
    programs = {
      hyprland.enable = true; # Wayland-based compositor https://hypr.land/
    };
    # hint Electron apps to use Wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
