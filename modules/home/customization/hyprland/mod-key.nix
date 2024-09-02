{
	lib,
	config,
	pkgs,
	...
}:
let
	inherit (lib) mkOption types;
in
	{
        options.customHomeConfig.customization.hyprland.modKey = mkOption {
            type = types.str;
            default = "Mod4";
            example = "Mod4";
            description = "The modifier key to use for Hyprland keybinds";
        };
    }
