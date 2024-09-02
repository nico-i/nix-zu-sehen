# https://github.com/hyprwm/Hyprland
{
	pkgs,
	config,
	lib,
	inputs,
	osConfig,
	...
}: 
let 
	cfg = config.customHomeConfig;
in
{
	imports = [
		./monitors.nix
	];

	options = {
		customHomeConfig.customization.hyprland.modKey = lib.mkOption {
			type = lib.types.str;
			default = "SUPER";
			example = "SUPER";
			description = "The modifier key to use for Hyprland keybinds";
		};
	};

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
			
			 "$mainMod" = cfg.hyprland.modKey;

			settings = {
				# https://wiki.hyprland.org/Configuring/Binds/ for more
				bind = [
					"$mainMod, return, exec, kitty"
					"$mainMod, Q, killactive,"
					"$mainMod SHIFT, M, exit,"
					"$mainMod SHIFT, F, togglefloating,"
					"$mainMod, F, fullscreen,"
					"$mainMod, G, togglegroup,"
					
					# vim navigation binds
					"$mainMod, h, movefocus, l"
					"$mainMod, l, movefocus, r"
					"$mainMod, k, movefocus, u"
					"$mainMod, j, movefocus, d"

					"$mainMod SHIFT, h, movewindow, l"
					"$mainMod SHIFT, l, movewindow, r"
					"$mainMod SHIFT, k, movewindow, u"
					"$mainMod SHIFT, j, movewindow, d"
				]
				++ 	builtins.concatLists (
						map 
							(numberKey: 
								let
									workSpaceIndex = if numberKey == 0 then 10 else numberKey;
								in  
									[
										"$mainMod, ${toString numberKey}, workspace, ${toString workSpaceIndex}"
										"$mainMod SHIFT, ${toString numberKey}, movetoworkspace, ${toString workSpaceIndex}"
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
