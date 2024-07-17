{ config, pkgs, ... }: {
  config.home.packages = with pkgs; [
    ungoogled-chromium
  ];
}
