{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.nixvim.homeManagerModules.default ];

  config = {
    programs.nixvim = {
      # https://github.com/nix-community/nixvim
      enable = true;
    };

    home.packages = with pkgs; [
      nil # nix language server
    ];
  };
}
