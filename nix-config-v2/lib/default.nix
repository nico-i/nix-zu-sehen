{
	inputs
} : {
	build = (import ./build) { inherit inputs; };
	nixos = (import ./nixos) { inherit inputs; };
	fs = (import ./fs) { inherit inputs; };
	modules = (import ./modules) {  lib = inputs.nixpkgs.lib; };
}
