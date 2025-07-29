{ config, pkgs, ... }: {
  config = {
    home.packages = with pkgs;
      [
        wl-clipboard # clipboard manager with wayland support
      ];
  };
}
