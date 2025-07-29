{ pkgs, config, ... }:
{
  config = {
    environment.systemPackages = with pkgs; [
      wineWowPackages.stable
      wineWowPackages.waylandFull
      winetricks
    ];
  };
}
