{
  pkgs,
  config,
  inputs,
  ...
}: {
  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = false; # disabled open-source NVIDIA drivers
    };
  };
  
  environment.systemPackages = with pkgs; [
    pciutils
  ];
  
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.xserver = {
    enable = true;
    videoDrivers = ["modesetting" "nvidia"];

    windowManager.awesome = {
      enable = true;
      luaModules = with pkgs.luaPackages; [
        luarocks # is the package manager for Lua modules
        luadbi-mysql # Database abstraction layer
      ];
    };
  };

}
