{ config, ... }:
{
  config = {
    home.packages = with config.pkgs; [
      lutris
      steam
    ];
  };
}
