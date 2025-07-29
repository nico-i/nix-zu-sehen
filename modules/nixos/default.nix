# This expression defines the available options in customNixOSConfig
{
  config,
  helperLib,
  lib,
  outputs,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.customNixOSConfig;

  nixosConfigModules = map (
    dir:
    helperLib.modules.injectEnableOptionIntoModules {
      modulesDirPath = ./${dir};
      customConfig = cfg;
      customConfigName = "customNixOSConfig";
    }
  ) (helperLib.fs.listDirsInDir { dir = ./.; });
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ] ++ lib.lists.flatten nixosConfigModules;

  options.customNixOSConfig.home-users = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        options = {
          homeCfgPath = lib.mkOption {
            description = "Path to the home-manager configuration file";
            type = lib.types.path;
            example = "../users/nico/home.nix";
          };
          extraSettings = lib.mkOption {
            default = { };
            description = "Identical to the options for users.users";
            example = "{}";
          };
        };
      }
    );
    default = { };
  };

  config = {
    # NixOS configuration defaults
    nix.settings.experimental-features = lib.mkDefault [
      "nix-command"
      "flakes"
    ]; # enable flakes and nix-command
    nixpkgs.config.allowUnfree = lib.mkDefault true; # Allow unfree repos

    customNixOSConfig = {
      ui = {
        theming.enable = lib.mkDefault true;
      };
    };

    i18n = {
      defaultLocale = "de_AT.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "de_AT.UTF-8";
        LC_IDENTIFICATION = "de_AT.UTF-8";
        LC_MEASUREMENT = "de_AT.UTF-8";
        LC_MONETARY = "de_AT.UTF-8";
        LC_NAME = "de_AT.UTF-8";
        LC_NUMERIC = "de_AT.UTF-8";
        LC_PAPER = "de_AT.UTF-8";
        LC_TELEPHONE = "de_AT.UTF-8";
        LC_TIME = "de_AT.UTF-8";
      };
    };

    time.timeZone = "Europe/Vienna";

    hardware = {
      enableAllFirmware = true;
    };

    # Enable PolicyKit for managing permissions and authorizations
    security.polkit.enable = true;

    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      nix
      git
      vim
      neofetch
      nh # nix cli helper
    ];

    services = {
      flatpak.enable = true;
      udisks2.enable = true;
    };

    networking = {
      networkmanager.enable = true;
      firewall.enable = false;
    };

    programs.zsh.enable = true;

    # default home-manager configuration
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
        inherit helperLib;
        outputs = inputs.self.outputs;
      };

      users = builtins.mapAttrs (
        name:
        { homeCfgPath, ... }:
        { ... }:
        {
          imports = [
            (import homeCfgPath)
            outputs.homeManagerModules.default
          ];
        }
      ) (config.customNixOSConfig.home-users);
    };

    # NixOS users configuration
    users.users = builtins.mapAttrs (
      name:
      {
        homeCfgPath,
        extraSettings ? { },
      }:
      {
        isNormalUser = true;
        initialPassword = "12345";
        description = "";
        shell = pkgs.zsh;
        extraGroups = [
          "libvirtd"
          "networkmanager"
          "wheel"
        ];
      }
      // extraSettings
    ) (config.customNixOSConfig.home-users);
  };
}
