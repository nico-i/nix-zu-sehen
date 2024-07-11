{
  config,
  lib,
  pkgs, 
  ...
}: {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nixosModulesConfig = {
    systemModules = {
      boot.enable = true;
      l10n.enable = true;
      remoteAccess.enable = true;
      defaultPkgs.enable = true;
    }
  };

  system.stateVersion = "24.05"; # Do not change
}

