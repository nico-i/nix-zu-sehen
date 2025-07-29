{ config, useUserPackages, ... }:
{
  config = {
    home.packages = with pkgs; [
      lutris
      steam
    ];
  };
}
