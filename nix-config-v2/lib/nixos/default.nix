{ 
	inputs 
}: {
	getSysPkgs = (import ./getSysPkgs.nix) { inherit inputs; }
};
