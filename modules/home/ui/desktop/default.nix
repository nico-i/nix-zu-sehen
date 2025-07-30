{
  pkgs,
  config,
  lib,
  inputs,
  osConfig,
  ...
}:
let
  startScript = pkgs.writeShellScriptBin "start" ''
     ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator &

     hyprctl setcursor Bibata-Modern-Ice 16 &

     systemctl --user import-environment PATH &
     systemctl --user restart xdg-desktop-portal.service &

    ${config.customHomeConfig.startupScript}
  '';
in
{
  imports = [
    ./_monitors.nix # necessary to import here in order to add monitors Option to customHomeConfig
  ];

  config = {
    home.packages = with pkgs; [
      # network manager tray icon
      networkmanagerapplet
    ];

    qt.enable = true;
    gtk.enable = true;

    customHomeConfig = {
      ui = {
        launcher.enable = true;
        homeBar.enable = true;
        screenshots.enable = true;
        clipboard.enable = true;
      };
      cli = {
        terminalEmulator.enable = true;
      };
    };

    services.mako = {
      # lightweight notification daemon for Wayland
      enable = true;
      settings = {
        "default-timeout" = 10000; # default timeout for notifications
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false; # See "https://wiki.hypr.land/Useful-Utilities/Systemd-start/" # uwsm

      settings = {
        env = [
          "HYPRCURSOR_THEME,rose-pine-hyprcursor"
          "HYPRCURSOR_SIZE,24"
        ];

        exec-once = [
          "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "${pkgs.bash}/bin/bash ${startScript}/bin/start"
          "waybar"
        ];

        "$mainMod" = if (osConfig.altIsSuper or false) then "ALT" else "SUPER";

        dwindle = {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = true; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true; # you probably want this
        };

        master = {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          orientation = "center"; # center master window
        };

        gestures = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = false;
        };

        decoration = {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          rounding = 5;
        };

        animations = {
          enabled = true;

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = "myBezier, 0.25, 0.9, 0.1, 1.02";

          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            # "workspaces, 1, 3, default, slidevert"
            # "workspaces, 1, 3, myBezier, slidefadevert"
            "workspaces, 1, 3, myBezier, fade"
          ];
        };

        # https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = [
          "$mainMod, return, exec, alacritty"

          # Launches Tofi in drun mode, which displays desktop applications from .desktop files
          # Passes the output to hyprctl to run the selected application
          "$mainMod, space, exec, tofi-drun | xargs hyprctl dispatch exec --"

          "$mainMod, Q, killactive,"
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

        binde = [
          "$mainMod SHIFT, h, moveactive, -20 0"
          "$mainMod SHIFT, l, moveactive, 20 0"
          "$mainMod SHIFT, k, moveactive, 0 -20"
          "$mainMod SHIFT, j, moveactive, 0 20"

          "$mainMod CTRL, l, resizeactive, 30 0"
          "$mainMod CTRL, h, resizeactive, -30 0"
          "$mainMod CTRL, k, resizeactive, 0 -10"
          "$mainMod CTRL, j, resizeactive, 0 10"
        ];

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        monitor = map (
          m:
          let
            resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
            position = "${toString m.x}x${toString m.y}";
          in
          "${m.name},${if m.enabled then "${resolution},${position},1" else "disable"}"
        ) (config.customHomeConfig.monitors);

        workspace = map (m: "${m.name},${m.workspace}") (
          lib.filter (m: m.enabled && m.workspace != null) config.customHomeConfig.monitors
        );

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
