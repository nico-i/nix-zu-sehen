# https://github.com/nix-community/nixvim
{ config, ... }: {
	config = {
        programs.nixvim = {
            enable = true;
        };
    }
}
