{ pkgs, lib, ... }: {

  imports = [
    ./cliPrograms/git.nix

    ./guiPrograms/steam.nix
  ];

}
