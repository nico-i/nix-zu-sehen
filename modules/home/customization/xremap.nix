# https://github.com/xremap/xremap
{ config, inputs, ... }: {
	imports = [
        inputs.xremap.homeManagerModules.default
    ];

    config.services.xremap = {
        enable = false;
        withHypr = true;
    };
}

