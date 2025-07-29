{
  pkgs,
  config,
  inputs,
  ...
}:
{
  hardware = {
    opengl.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false; # disabled open-source NVIDIA drivers
    };
  };

  environment.systemPackages = with pkgs; [ pciutils ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # hints electron apps to use wayland
    WLR_NO_HARDWARE_CURSORS = "1"; # fixes invisible cursors on some machines
  };

  services.xserver = {
    enable = true;
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

}
