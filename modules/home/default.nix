/* This expression defines the available options in homeModulesConfig */
{
	config,
	helperLib,
    lib,
	...
}:
let
	cfg = config.homeModulesConfig;

	homeConfigModules = map (dir: helperLib.modules.injectEnableOptionIntoModules {
		modulesDirPath = dir;
		customConfig = cfg;
		customConfigName = "homeModulesConfig";
	}) helperLib.fs.listDirsInDir { dir = .; };
in 
	{
	imports = [] ++ homeConfigModules;
	config = { # home-manager configuration defaults
	};
	}
