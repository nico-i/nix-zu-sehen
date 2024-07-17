# https://github.com/nix-community/nixvim
{ config, pkgs, ... }: {
	config = {
        programs.nixvim = {
            enable = true;
        };

        home.packages = with pkgs; [
            nil # nix language server
        ];
    };
}
