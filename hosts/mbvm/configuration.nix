{ lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  customNixOSConfig = {
    system = {
      boot.enable = true;
      l10n.enable = true;
      remoteAccess.enable = true;
      defaultPkgs.enable = true;
    };
    ui.stylix.enable = true;

    home-users = { nico = { homeCfgPath = ./users/nico/home.nix; }; };
  };

  system.stateVersion = "24.05"; # Do not change
}

