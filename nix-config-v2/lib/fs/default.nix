{ 
	inputs,
	lib
}: {
	listDirsInDir = import ./listDirsInDir.nix { inherit inputs; };
	listFilesInDir = import ./listFilesInDir.nix { inherit lib; };
}
