{ pkgs, lib, config, ... }: {
  
  options = {
    steam.enable = 
      lib.mkEnableOption "Enables steam terminal ui and steam cmd";
  };

  config = lib.mkIf config.steam.enable {
    home.packages = with pkgs; [ steamcmd ];
  };

}
