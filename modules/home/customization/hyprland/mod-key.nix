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
        options.customHomeConfig.modKey = mkOption {
            type = types.str;
            default = "Mod4";
            example = "Mod4";
            description = "The modifier key to use for keybinds";
        };
    }
