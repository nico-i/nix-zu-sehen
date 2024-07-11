/* Create a flake's `homeManagerConfiguration` attribute entry based on a given Home Manager `home.nix` file */
{
	inputs
}:
let
	outputs = inputs.self.outputs;
    helperLib = (import ../default.nix) {inherit inputs;};
in 
	{ system, homeConfig }: 
		let
			# username is based on the directory name the configuration is in
			username = builtins.baseNameOf (builtins.dirOf homeConfig.path);
		in
			if !(builtins.isAttrs homeConfig)
			then
				throw "mkHomeConfig: `homeConfig` must be an attrset"
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
						homeConfig
						outputs.homeManagerModules.default
					];
				}
