{ 
	inputs,
	outputs,
	pkgs,
	lib,
	...
}: { 
	myHomeManager = {
		bundles.general.enable = true;
		bundles.desktop-full.enable = true;
		bundles.gaming.enable = true;

		firefox.enable = true;
		hyprland.enable = true;
		pipewire.enable = true;
		tenacity.enable = true;

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

		startupScript = lib.mkAfter ''
		#  ${pkgs.firefox}/bin/firefox &
		'';
	};

	colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

	wayland.windowManager.hyprland.settings.master.orientation = "center";

	home = {
		username = "nico";
		homeDirectory = lib.mkDefault "/home/nico";
		stateVersion = "23.11";

		packages = with pkgs; [
			obs-studio # broadcast studio
			wf-recorder # screen recorder
			blender # 3D modeling software
		];
	};
}
