{ lib }:
    {
        injectEnableOptionIntoModule = (import ./injectEnableOptionIntoModule.nix) { inherit lib; };
        injectEnableOptionIntoModules = (import ./injectEnableOptionIntoModules.nix) { inherit lib; };
    }
