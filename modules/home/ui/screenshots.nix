{ config, pkgs, ... }: {
  config.home.packages = with pkgs; [
    grim # screenshot tool
    slurp # select area for screenshot (works with grim)
  ];
}
