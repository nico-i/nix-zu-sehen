{pkgs, ...}: {
  home.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
  };

  home.packages = with pkgs; [
    lutris # video game compatibility platform
    steam
    steam-run
    protonup-ng # enable windows steam games for linux
    gamemode # performance optimizer
    dxvk # enables Direct3D support for wine
    # parsec-bin

    gamescope # steamOS window manager / composer

    # heroic # native GOG, Epic and Amazon Games Launcher
    mangohud # FPS overlay

    steamPackages.steam-runtime
  ];

  myHomeManager.impermanence.directories = [
    ".local/share/Steam"
  ];
}
