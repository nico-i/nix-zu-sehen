
/* Create a flake's `darwinConfigurations` attribute entry based on a given nix-darwin `configuration.nix` */
{ inputs }: 
let
  helperLib = (import ../default.nix) {inherit inputs;};
  outputs = inputs.self.outputs;
in 
{ darwinCfgPath }: 
	let	
		cfg = import darwinCfgPath;
		# hostname is based on the directory name the configuration is in
		hostName = if !(builtins.isPath darwinCfgPath)
		then throw "mkDarwinSystem: `darwinCfgPath` must be a path"
		else builtins.baseNameOf (builtins.dirOf darwinCfgPath);
	in
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

