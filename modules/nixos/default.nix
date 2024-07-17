/* This expression defines the available options in nixosModulesConfig */
{
	config,
	helperLib,
	lib,
	...
}: 
let
	cfg = config.nixosModulesConfig;

	nixosConfigModules = map (dir: helperLib.modules.injectEnableOptionIntoModules {
		modulesDirPath = dir;
		customConfig = cfg;
		customConfigName = "nixosModulesConfig";
	}) helperLib.fs.listDirsInDir { dir = .; };
in 
	{
		imports = []
			++ nixosConfigModules;

		config = { # NixOS configuration defaults
			nix.settings.experimental-features = lib.mkDefault ["nix-command" "flakes"]; # enable flakes and nix-command
			nixpkgs.config.allowUnfree = lib.mkDefault true; # Allow unfree repos

			programs.home-manager.enable = lib.mkDefault true; # enable home-manager

			nixosModulesConfig = {
				stylix.enable = lib.mkDefault true;
			};
		};
	}
