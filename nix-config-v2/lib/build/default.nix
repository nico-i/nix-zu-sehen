{
    inputs
}:
{
    mkNixOSSystem = import ./mkNixOSSystem.nix { inherit inputs; };
    mkHomeConfig = import ./mkHomeConfig.nix { inherit inputs; };
}