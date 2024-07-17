{ config, ... }:
{
    config = {
        home.packages = with config.pkgs; [
            lutris
        ];

        homeModulesConfig.gaming.steam.enable = true;
    };
}