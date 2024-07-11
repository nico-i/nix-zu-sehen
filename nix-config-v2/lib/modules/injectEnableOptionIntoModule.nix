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
{ lib, helperLib }:
	{ modulePath, customConfig, customConfigName, moduleCategoryName ? null}:
		{pkgs, ...} @ moduleArgs: 
		let
			moduleName = helperLib.fs.getFileName modulePath;
			evaluatedModule =
				if builtins.isPath modulePath
				then (import modulePath) moduleArgs
				else throw "injectEnableOptionIntoModule: `modulePath` must be a path";
			
			enableOptionValue = lib.mkEnableOption "enable ${moduleName} configuration";
			enableOption = if builtins.isString moduleCategoryName
				then { ${customConfigName}.${moduleCategoryName}.${moduleName}.enable = enableOptionValue;}
				else { ${customConfigName}.${moduleName}.enable = enableOptionValue; };
		in
			{
				imports = evaluatedModule.imports or [];

				options = (evaluatedModule.options or {}) // enableOption;

				config = (lib.mkIf 
					(
						if builtins.isString moduleCategoryName
						then customConfig.${moduleCategoryName}.${moduleName}.enable
						else customConfig.${moduleName}.enable
					)
				 	evaluatedModule.config or {});
			}