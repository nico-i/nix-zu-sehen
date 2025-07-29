{ lib, helperLib }: {
  injectEnableOptionIntoModule =
    (import ./injectEnableOptionIntoModule.nix) { inherit lib helperLib; };
  injectEnableOptionIntoModules =
    (import ./injectEnableOptionIntoModules.nix) { inherit lib helperLib; };
}
