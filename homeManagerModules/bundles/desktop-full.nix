{
  pkgs,
  lib,
  ...
}: {
  myHomeManager.bundles.desktop.enable = lib.mkDefault true;

  myHomeManager.ungoogled-chromium.enable = lib.mkDefault true; # chromium with google related things removed
  myHomeManager.gimp.enable = lib.mkDefault true;
  myHomeManager.vesktop.enable = lib.mkDefault true; # discord alternative
  myHomeManager.telegram.enable = lib.mkDefault true;

  home.packages = with pkgs; [
    spotify
  ];
}
