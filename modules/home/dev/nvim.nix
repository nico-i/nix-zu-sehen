# https://github.com/nix-community/nixvim
{ config, ... }: {
	config = {
        programs.nixvim = {
            enable = true;
        };

        home.packages = with pkgs; [
            nil # nix language server
        ];
    };
}
