# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config,
  pkgs,
  lib,
  inputs,
  outputs,
  system,
  myLib,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ (myLib.filesIn ./included);
  
  boot = {
    loader = {
      grub = {
        enable = true; # enable grub boot loader
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
    };
    
    # Register drives with LUKS encryption
    initrd.luks.devices."luks-708cbd28-b60a-4bd1-8255-e33f3c487234".device = "/dev/disk/by-uuid/708cbd28-b60a-4bd1-8255-e33f3c487234";

    supportedFilesystems = ["ntfs"];
    
    # Parameters passed to the Linux kernel at boot time
    kernelParams = [
      "quiet"                    # Minimize log messages during boot
      "udev.log_level=3"         # Set udev log level to 3 for verbose logging
      "nvidia_drm.fbdev=1"       # Enable framebuffer device support for Nvidia DRM
      "nvidia_drm.modeset=1"     # Enable kernel mode setting for Nvidia DRM
    ];

     # Additional kernel modules to include in the NixOS kernel
     kernelModules = [
       "coretemp"                 # Support for monitoring CPU core temperatures
       "cpuid"                    # Allow access to CPU identification and features
       "v4l2loopback"             # Create virtual video loopback devices
     ];
  };

  myNixOS = {
    bundles.general-desktop.enable = true;
    bundles.users.enable = true;

    sharedSettings.hyprland.enable = true;

    home-users = {
      "nico" = {
        userConfig = ./home.nix;
        userSettings = {
          extraGroups = [
            "networkmanager"  # Allows the user to manage network settings
            "wheel"           # Allows the user to execute commands as root using sudo
            "libvirtd"        # Allows the user to manage virtual machines
            "docker"          # Allows the user to run Docker containers
            "adbusers"        # Allows the user to access Android Debug Bridge
            "openrazer"       # Allows the user to manage Razer devices on Linux
          ];
        };
      };
    };  
  };

  # Enable PolicyKit for managing permissions and authorizations
  security.polkit.enable = true;

  # Configure systemd-boot loader
  # Limit the number of boot entries displayed at startup to 5
  boot.loader.systemd-boot.configurationLimit = 5;

  networking = {
    hostName = "nixos-nico";
    networkmanager.enable = true;
    firewall.enable = false;
    # wireless.enable = true # enables WLAN
  };

  hardware = {
    enableAllFirmware = true;
    cpu.amd.updateMicrocode = true; #needs unfree
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
      driSupport = true;
    };
  };

  services = {
    flatpak.enable = true;
    udisks2.enable = true;
    printing.enable = true;
  };

  programs.zsh.enable = true;
  programs.hyprland.enable = true;
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    wineWowPackages.stable
    wineWowPackages.waylandFull
    winetricks
  ];

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
  xdg.portal.enable = true;

  system.stateVersion = "23.11";
}
