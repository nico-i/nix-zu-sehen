{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  nixpkgs = {
    config = {
      # allowUnfree = true;
      experimental-features = "nix-command flakes";
    };
  };

  myHomeManager.zsh.enable = lib.mkDefault true;
  myHomeManager.lf.enable = lib.mkDefault true; # terminal file manager
  myHomeManager.yazi.enable = lib.mkDefault true; # terminal file manager
  myHomeManager.nix-extra.enable = lib.mkDefault true;
  myHomeManager.bottom.enable = lib.mkDefault true; # sys monitor
  myHomeManager.nix-direnv.enable = lib.mkDefault true; # faster nix commands
  myHomeManager.zoxide.enable = lib.mkDefault true; # smarter cd 
  myHomeManager.git.enable = lib.mkDefault true;
 
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    nil # nix language server
    nixd # nix language server
    pistol # file previewer
    file # show file types
    p7zip # 7zip
    unzip # extraction utility for .zip
    zip # .zip compressor
    stow # symlink manager
    libqalculate # calculator lib
    imagemagick # image editor
    killall # kill processes by name
    neovim

    fzf # cli fuzzy finder
    htop # cli sys monitor
    lf # cli file manager
    eza # ls replacement
    fd # find alternative
    bat # cat alternative
    du-dust # du (disk usage)  alternative
    ripgrep # grep alternative
    neofetch # cli sys info tool
    lazygit # git tui

    ffmpeg
    wget

    yt-dlp # cli audio video downloader
    tree-sitter # parsing system for programming tools

    nh # nix cli helper
  ];

  home.sessionVariables = {
    FLAKE = "${config.home.homeDirectory}/nix-config";
  };

}
