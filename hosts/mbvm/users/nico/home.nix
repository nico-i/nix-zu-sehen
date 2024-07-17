{
	outputs,
	lib,
	...
}: {
	imports = [
		outputs.homeManagerModules.default
    ];

	customHomeConfig = {
		customization = {
			hyprland.enable = lib.mkDefault true;
		};
	};

    home.stateVersion = "24.05"; # Do not change
}
