{ outputs, lib, ... }:
{
  imports = [ outputs.homeManagerModules.default ];

  customHomeConfig = {
    apps = {
      "3d".enable = true;
      music.enable = true;
      gaming.enable = true;
      browser.enable = true;
    };

    cli = {
      terminalEmulator.enable = true;
      tools.enable= true;
      editor.enable = true;
      vcs.enable = true;
    };

    ui = {
      desktop.enable = true;
    };

    monitors = [
      {
        # Gigabyte M27Q
        name = "DP-3";
        width = 2560;
        height = 1440;
        refreshRate = 169.77;
        x = 1920;
        y = 0;
      }
      {
        # Dell left
        name = "DP-1";
        width = 1920;
        height = 1080;
        refreshRate = 59.96;
        x = 0;
        y = 0;
      }
      {
        # Dell right
        name = "DP-2";
        width = 1920;
        height = 1080;
        refreshRate = 59.96;
        x = 4480;
        y = 0;
      }
    ];
  };

  home.stateVersion = "24.05"; # Do not change
}
