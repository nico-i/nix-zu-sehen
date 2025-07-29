{ config, pkgs, ... }:
{
  config.home.packages = with pkgs; [
    brave
    ungoogled-chromium
  ];
}
