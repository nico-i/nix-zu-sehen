
/* Create a flake's `nixosConfiguration` attribute entry based on a given NixOS `configuration.nix` */
{ inputs }: 
let
  helperLib = (import ../default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in 
{ nixosCfgPath }:
let
	hostName = 
		if !(builtins.isPath nixosCfgPath)
		then throw "mkNixOSSystem: `nixosCfgPath` must be a path"
		else builtins.baseNameOf (builtins.dirOf nixosCfgPath);
in
	inputs.nixpkgs.lib.nixosSystem {
		# used to pass things to the NixOS configuration
		specialArgs = {
			inherit inputs outputs helperLib;
		};
		# all modules that are necessary for building the system
		modules = [
			nixosCfgPath
			outputs.nixosModules.default
			{
				# set the hostname to the name of the dir containing the configuration
				networking.hostName = hostName;
			}
		];
	}

