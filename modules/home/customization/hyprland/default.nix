# https://github.com/hyprwm/Hyprland
{
	pkgs,
	config,
	lib,
	inputs,
	osConfig,
	...
}: 
{
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

		customHomeConfig = {
			customization = {
				tofi.enable = true;
				waybar.enable = true;
				xremap.enable = true;
			};
			dev.kitty.enable = true;
		};

		wayland.windowManager.hyprland = {
			enable = true;
			settings = {
				"$mod" = "Mod4";

				# https://wiki.hyprland.org/Configuring/Binds/ for more
				bindm = [
					"$mod, return, exec, kitty"
					"$mod, Q, killactive,"
					"$mod SHIFT, M, exit,"
					"$mod SHIFT, F, togglefloating,"
					"$mod, F, fullscreen,"
					"$mod, G, togglegroup,"

					# vim navigation binds
					"$mod, h, movefocus, l"
					"$mod, l, movefocus, r"
					"$mod, k, movefocus, u"
					"$mod, j, movefocus, d"

					"$mod SHIFT, h, movewindow, l"
					"$mod SHIFT, l, movewindow, r"
					"$mod SHIFT, k, movewindow, u"
					"$mod SHIFT, j, movewindow, d"
				]
				++ builtins.concatLists (
					map 
						(numberKey: 
							let
								workSpaceIndex = if numberKey == 0 then 10 else numberKey;
							in 
								[
									"$mod, ${toString numberKey}, workspace, ${toString workSpaceIndex}"
									"$mod SHIFT, ${toString numberKey}, movetoworkspace, ${toString workSpaceIndex}"
								]
						)
						[1 2 3 4 5 6 7 8 9 0]
					);

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
