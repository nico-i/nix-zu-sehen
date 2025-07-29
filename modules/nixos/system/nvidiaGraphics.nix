{
  pkgs,
  config,
  inputs,
  ...
}:
{
  config = {
    hardware = {
      graphics.enable = true;
      nvidia.open = false; # use proprietary NVIDIA drivers
    };

    services.xserver.videoDrivers = [ "nvidia" ];

    environment.systemPackages = with pkgs; [
      pciutils # provides lspci command to list PCI devices https://github.com/pciutils/pciutils
    ];

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
      WLR_NO_HARDWARE_CURSORS = "1"; # fixes invisible cursors on some machines
    };
  };
}
