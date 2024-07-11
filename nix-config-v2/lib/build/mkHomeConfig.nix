/* Create a flake's `homeManagerConfiguration` attribute entry based on a given Home Manager `home.nix` file */
{
	inputs
}:
let
	outputs = inputs.self.outputs;
    helperLib = (import ../default.nix) {inherit inputs;};
in 
	{ system, homeCfgPath }: 
		if !(builtins.isPath homeCfgPath)
		then
			throw "mkHomeConfig: `homeCfgPath` must be a path"
		else
			inputs.home-manager.lib.homeManagerConfiguration {
				home = {
					username = username;
					homeDirectory = "/home/${username}";
				};
				pkgs = helperLib.nixos.getSysPkgs system;
				# used to pass things to the home configuration
				extraSpecialArgs = {
					inherit inputs helperLib outputs;
				};
				# all modules that are necessary for building the home folder configuration
				modules = [
					homeCfgPath
					outputs.homeManagerModules.default
				];
			}
