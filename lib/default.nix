{ inputs }:
let
  helperLib = (import ./default.nix) { inherit inputs; };
  lib = inputs.nixpkgs.lib;
in {
  build = (import ./build) { inherit inputs; };
  nixos = (import ./nixos) { inherit inputs; };
  fs = (import ./fs) { inherit inputs lib; };
  modules = (import ./modules) { inherit helperLib lib; };
}
