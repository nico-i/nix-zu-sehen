{ 
	inputs 
}: {
	listDirsInDir = import ./listDirsInDir.nix { inherit inputs; };
	listFilesInDir = import ./listFilesInDir.nix;
}
