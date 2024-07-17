/** Retrieve all system-specific packages for a given system. */
{ inputs }: { system }:
    if !(builtins.isString system)
    then throw "getSysPkgs: `system` must be a string"
    else inputs.nixpkgs.legacyPackages.${system}