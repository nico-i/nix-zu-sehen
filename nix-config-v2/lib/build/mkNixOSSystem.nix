
/* Create a flake's `nixosConfiguration` attribute entry based on a given NixOS `configuration.nix` */
{ inputs }: 
let
  helperLib = (import ../default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
in 
{ nixosCfgPath }:
	let	
		cfg = import nixosCfgPath;
		# hostname is based on the directory name the configuration is in
		hostName = if !(builtins.isPath nixosCfgPath)
		then throw "mkNixOSSystem: `nixosCfgPath` must be a path"
		else builtins.baseNameOf (builtins.dirOf nixosCfgPath);
	in
			inputs.nixpkgs.lib.nixosSystem {
				cfg.networking.hostName = hostName;

				# used to pass things to the NixOS configuration
				specialArgs = {
					inherit inputs outputs helperLib;
				};
				# all modules that are necessary for building the system
				modules = [
					nixosCfgPath
					outputs.nixosModules.default
				];
			}

