{ config, pkgs, ... }: { config.home.packages = with pkgs; [ spotify ]; }
