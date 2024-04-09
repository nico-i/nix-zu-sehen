{ pkgs, lib, ... }: {

  imports = [
    ./guiPrograms/steam.nix
  ];
  
  steam.enable = lib.mkDefault true;
}
