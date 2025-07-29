# Create a flake's `darwinConfigurations` attribute entry based on a given nix-darwin `configuration.nix`
{ inputs }:
let
  helperLib = (import ../default.nix) { inherit inputs; };
  outputs = inputs.self.outputs;
in
{ darwinCfgPath }:
inputs.nix-darwin.lib.darwinSystem {
  # used to pass things to the nix-darwin configuration
  specialArgs = {
    inherit inputs outputs helperLib;
  };
  # all modules that are necessary for building the system
  modules = [
    darwinCfgPath
    outputs.darwinModules.default
    (helperLib.nixos.injectConfigDirNameAsHostName { cfgPath = darwinCfgPath; })
  ];
}
