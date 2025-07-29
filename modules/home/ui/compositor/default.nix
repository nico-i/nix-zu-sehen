{ pkgs, config, lib, inputs, osConfig, ... }: {
  imports = [
    ./_monitors.nix # necessary to import here in order to add monitors Option to customHomeConfig
  ];

  config = {
    home.packages = with pkgs;
      [
        # network manager tray icon
        networkmanagerapplet
      ];

    customHomeConfig = {
      ui = {
        launcher.enable = true;
        homeBard.enable = true;
        keyboardRemaps.enable = true;
        screenshots.enable = true;
        clipboard.enable = true;
      };
      dev.alacritty.enable = true;
    };

    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mainMod" = if (osConfig.altIsSuper or false) then "ALT" else "SUPER";

        # https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = [
          "$mainMod, return, exec, alacritty"
          "$mainMod, \\, exec, alacritty"

          "$mainMod, Q, killactive,"
          "$mainMod, W, closeactive,"
          "$mainMod, R, reload,"
          "$mainMod, F, fullscreen,"

          # vim navigation binds
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          "$mainMod SHIFT, h, movewindow, l"
          "$mainMod SHIFT, l, movewindow, r"
          "$mainMod SHIFT, k, movewindow, u"
          "$mainMod SHIFT, j, movewindow, d"
        ];

        monitor = map (m:
          let
            resolution = "${toString m.width}x${toString m.height}@${
                toString m.refreshRate
              }";
            position = "${toString m.x}x${toString m.y}";
          in "${m.name},${
            if m.enabled then "${resolution},${position},1" else "disable"
          }") (config.customHomeConfig.monitors);

        workspace = map (m: "${m.name},${m.workspace}")
          (lib.filter (m: m.enabled && m.workspace != null)
            config.customHomeConfig.monitors);

        input = {
          kb_layout = "us";
          kb_variant = "";
          kb_model = "";
          kb_options = "";

          kb_rules = "";

          follow_mouse = 1;

          repeat_rate = 40;
          repeat_delay = 250;
          force_no_accel = true;

          sensitivity = 0.0; # -1.0 - 1.0, 0 means no modification.
        };

        misc = {
          enable_swallow = true;
          force_default_wallpaper = 0;
        };
      };
    };
  };
}
