{ config, ... }:
{
    config = {
        home.packages = with config.pkgs; [
            lutris
        ];

        customHomeConfig.gaming.steam.enable = true;
    };
}