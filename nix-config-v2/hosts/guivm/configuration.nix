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

  customNixosConfig {
    systemModules = {
      boot.enable = true;
      fonts.enable = true;
      l10n.enable = true;
      remoteAccess.enable = true;
    }
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  system.stateVersion = "24.05"; # Do not change
}

