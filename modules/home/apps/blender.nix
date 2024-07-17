{ config, ... }: {
    config.home.packages = with pkgs; [
			blender
		];
}