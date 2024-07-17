# https://github.com/xremap/xremap
{ config, inputs, ... }: {
	imports = [
        inputs.xremap-flake.homeManagerModules.default
    ];

    config.services.xremap = {
        enable = false;
        withHypr = true;
    };
}

