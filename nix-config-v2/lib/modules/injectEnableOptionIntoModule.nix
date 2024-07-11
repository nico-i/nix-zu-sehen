/* Injects an enable option into a module's configuration.
 * 
 * Arguments:
 * - lib: The Nixpkgs lib object.
 * - modulePath: The path to the module to inject the enable option into.
 * - customConfig: The custom configuration the module will exist in.
 * - customConfigName: The name of the custom configuration to inject the enable option into.
 * - moduleCategoryName?: The name of the category of the module to inject the enable option into.
 * 
 * Returns: A NixOS module object.
 */
{ lib }:
	{ modulePath, customConfig, customConfigName, moduleCategoryName ? null}:
		{pkgs, ...} @ moduleArgs: 
		let
			getFileName = import ../fs/getFileName.nix;
			moduleName = getFileName modulePath;
			evaluatedModule =
				if (builtins.isString modulePath) || (builtins.isPath modulePath)
				then import modulePath moduleArgs
				else modulePath moduleArgs;
			
			enableOptionValue = lib.mkEnableOption "enable my ${moduleName} configuration";
			enableOption = if builtins.isString moduleCategoryName
				then { ${customConfigName}.${moduleCategoryName}.${moduleName}.enable = enableOptionValue;}
				else { ${customConfigName}.${moduleName}.enable = enableOptionValue; };
		in
			{
				imports = evaluatedModule.imports or [];

				options = (evaluatedModule.options or {}) // enableOption;

				config = (lib.mkIf customConfig.${
					if builtins.isString moduleCategoryName
					then "${moduleCategoryName}.${moduleName}.enable"
					else "${moduleName}.enable"
				} evaluatedModule.config);
			}