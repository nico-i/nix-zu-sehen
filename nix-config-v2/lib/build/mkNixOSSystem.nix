
/* Create a flake's `nixosConfiguration` attribute entry based on a given NixOS `configuration.nix` */
{ inputs }: 
let
  helperLib = (import ../default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
in 
{ config }:
	let	
		# hostname is based on the directory name the configuration is in
		hostName = builtins.baseNameOf (builtins.dirOf config.path);
	in
		if !(builtins.isAttrs config)
		then
			throw "mkNixOSSystem: `config` must be an attrset"
		else
			inputs.nixpkgs.lib.nixosSystem {
				config.networking.hostName = hostName

				# used to pass things to the NixOS configuration
				specialArgs = {
					inherit inputs outputs helperLib;
				};
				# all modules that are necessary for building the system
				modules = [
					config
					outputs.nixosModules.default
				];
			}

