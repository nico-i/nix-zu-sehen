# https://github.com/xremap/xremap
{ config, ... }: {
	imports = [
        inputs.xremap-flake.homeManagerModules.default
    ];

    config.services.xremap = {
        enable = false;
        withHypr = true;
    }
}

