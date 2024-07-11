{
    inputs
}:
let
    mkNixOSSystem = import ./mkNixOSSystem.nix { inherit inputs; };
    mkHomeConfig = import ./mkHomeConfig.nix { inherit inputs; };
    mkDarwinSystem = import ./mkDarwinSystem.nix { inherit inputs; };
in
    {
        inherit mkNixOSSystem mkHomeConfig mkDarwinSystem;
    }