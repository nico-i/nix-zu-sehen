
/* Create a flake's `darwinConfigurations` attribute entry based on a given nix-darwin `configuration.nix` */
{ inputs }: 
let
  helperLib = (import ../default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
in 
{ darwinConfig }: 
	let	
		# hostname is based on the directory name the configuration is in
		hostName = builtins.baseNameOf (builtins.dirOf darwinConfig.path);
	in
		if !(builtins.isAttrs darwinConfig)
		then
			throw "mkDarwinSystem: `darwinConfig` must be an attrset"
		else
			nix-darwin.lib.darwinSystem {	
				# set the hostname of the system based on the directory name the configuration is in
				darwinConfig.networking.hostName = hostName;

				# used to pass things to the nix-darwin configuration
				specialArgs = {
					inherit inputs outputs helperLib;
				};
				# all modules that are necessary for building the system
				modules = [
					darwinConfig
					outputs.darwinModules.default
				];
			}

