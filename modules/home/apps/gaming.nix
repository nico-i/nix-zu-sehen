{ config, ... }: {
  config = {
    home.packages = with config.pkgs; [ lutris steam ];
    customHomeConfig.gaming.steam.enable = true;
  };
}
