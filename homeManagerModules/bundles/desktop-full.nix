{
  pkgs,
  lib,
  ...
}: {
  myHomeManager.bundles.desktop.enable = lib.mkDefault true;
  myHomeManager.ungoogled-chromium.enable = lib.mkDefault true; # chromium with google related things removed

  home.packages = with pkgs; [
    spotify
  ];
}
