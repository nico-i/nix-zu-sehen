{
	description = "Nico's NixOS config flake";

	inputs = {
		# allows for the most current nix package versions
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		# key remapper
		xremap-flake.url = "github:xremap/nix-flake";

		# home-manager allows configuring user based packages
		# use `man home-configuration.nix` to find out more
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# index db of all nix packages to enable installation suggestions
		nix-index-database = {
			url = "github:Mic92/nix-index-database";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Nix-driven partitioning
		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {...} @ inputs: let
		# lib to reduce boilerplate (credit: @vim-joyer)
		myLib = import ./myLib/default.nix { inherit inputs; };
	in
		with myLib; {

			# expected to exist by Nix OS when building the system configuration
			nixosConfigurations = {
				desktop = mkSystem ./hosts/desktop/configuration.nix;
			};

			# Nix OS modules consumed by this flake
			nixosModules.default = ./nixosModules;

			# expected to exist by home-manager when building a home configuration
			homeConfigurations = {
				"nico@desktop" = mkHome "x86_64-linux" ./hosts/desktop/home.nix;
			};

			# home-manager modules consumed by this flake
			homeManagerModules.default = ./homeManagerModules;
		};
}
