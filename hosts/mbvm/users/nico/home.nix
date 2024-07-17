{
  outputs,
  lib,
  ...
}: {
  imports = [
    outputs.homeManagerModules.default
    ];

  customHomeConfig = {
    customization = {
      hyprland.enable = lib.mkDefault true;
    };
  };
}