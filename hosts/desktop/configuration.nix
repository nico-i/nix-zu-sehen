{ lib, ... }:
{
  imports = [ ./hardware-configuration.nix ];

  customNixOSConfig = {
    system = {
      amdCpu.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      boot.enable = true;
      gaming.enable = true;
      nvidia.enable = true;
      printing.enable = true;
      remoteAccess.enable = true;
      wine.enable = true;
    };
    ui = {
      theming.enable = true;
      desktop.enable = true;
    };

    home-users = {
      nico = {
        homeCfgPath = ./users/nico/home.nix;
      };
    };
  };

  system.stateVersion = "24.05"; # Do not change
}
