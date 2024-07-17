/* This expression defines the available options in customHomeConfig */
{
	config,
	helperLib,
	lib,
	...
}:
let
	cfg = config.customHomeConfig;

	homeConfigModules = map (dir: helperLib.modules.injectEnableOptionIntoModules {
		modulesDirPath = dir;
		customConfig = cfg;
		customConfigName = "customHomeConfig";
	}) helperLib.fs.listDirsInDir { dir = ./.; };
in 
	{
		imports = [] ++ homeConfigModules;
		config = { # home-manager configuration defaults
		};
	}
