{ config, ... }:
{
  config = {
    home.packages = with config.programs; [
      lutris
      steam
    ];
  };
}
