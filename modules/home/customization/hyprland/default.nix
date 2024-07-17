# https://github.com/hyprwm/Hyprland
{
	pkgs,
	config,
	lib,
	inputs,
	osConfig,
	...
}: {
    imports = [
        ./monitors.nix
    ];

	config = {
        home.packages = with pkgs; [
            # screenshot tools
            grim
            slurp
            # clipboard manager with wayland support
            wl-clipboard
            # network manager tray icon
            networkmanagerapplet
        ];

        customHomeConfig.customization = {
            tofi.enable = true;
            waybar.enable = true;
            xremap.enable = true;
        };

        wayland.windowManager.hyprland = {
            enable = true;
            settings = {
                monitor =
                    map
                    (
                        m: let
                        resolution = "${toString m.width}x${toString m.height}@${toString m.refreshRate}";
                        position = "${toString m.x}x${toString m.y}";
                        in "${m.name},${
                        if m.enabled
                        then "${resolution},${position},1"
                        else "disable"
                        }"
                    )
                    (config.customHomeConfig.monitors);

                    workspace = map (m: "${m.name},${m.workspace}")
                        (lib.filter (m: m.enabled && m.workspace != null) config.customHomeConfig.monitors);
                    
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
