{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris # video game compatibility platform
    protonup-ng # enable windows steam games for linux
    gamemode # performance optimizer
    dxvk # enables Direct3D support for wine
    # parsec-bin
    prismlauncher # minecraft launcher

    gamescope # steamOS window manager / composer

    # heroic # native GOG, Epic and Amazon Games Launcher
    mangohud # FPS overlay
  ];

  myHomeManager.impermanence.directories = [
    ".local/share/Steam"
  ];
}
