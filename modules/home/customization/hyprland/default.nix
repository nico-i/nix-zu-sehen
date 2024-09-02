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
				# https://wiki.hyprland.org/Configuring/Binds/ for more
				bind = [
					"MOD, return, exec, kitty"
					"MOD, Q, killactive,"
					"MOD SHIFT, M, exit,"
					"MOD SHIFT, F, togglefloating,"
					"MOD, F, fullscreen,"
					"MOD, G, togglegroup,"
					
					# vim navigation binds
					"MOD, h, movefocus, l"
					"MOD, l, movefocus, r"
					"MOD, k, movefocus, u"
					"MOD, j, movefocus, d"

					"MOD SHIFT, h, movewindow, l"
					"MOD SHIFT, l, movewindow, r"
					"MOD SHIFT, k, movewindow, u"
					"MOD SHIFT, j, movewindow, d"
				]
				++ 	builtins.concatLists (
						map 
							(numberKey: 
								let
									workSpaceIndex = if numberKey == 0 then 10 else numberKey;
								in  
									[
										"MOD, ${toString numberKey}, workspace, ${toString workSpaceIndex}"
										"MOD SHIFT, ${toString numberKey}, movetoworkspace, ${toString workSpaceIndex}"
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
