
/* Create a flake's `nixosConfiguration` attribute entry based on a given NixOS `configuration.nix` */
{ inputs }: 
let
  helperLib = (import ../default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in 
{ nixosCfgPath }:
	inputs.nixpkgs.lib.nixosSystem {
		# used to pass things to the NixOS configuration
		specialArgs = {
			inherit inputs outputs helperLib;
		};
		# all modules that are necessary for building the system
		modules = [
			nixosCfgPath
			outputs.nixosModules.default
			helperLib.nixos.injectConfigDirNameAsHostName { cfgPath = nixosCfgPath; }
		];
	}

