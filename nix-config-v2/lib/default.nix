{
	inputs
} : 
let
	helperLib = (import ./default.nix) { inherit inputs; };
in
	{
		build = (import ./build) { inherit inputs; };
		nixos = (import ./nixos) { inherit inputs; };
		fs = (import ./fs) { inherit inputs; };
		modules = (import ./modules) {  
				inherit helperLib; 
				lib = inputs.nixpkgs.lib;
			};
	}
