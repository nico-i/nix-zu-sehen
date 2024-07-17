# https://github.com/nix-community/nixvim
{ inputs, config, pkgs, ... }: {
    imports = [
        inputs.nixvim.homeManagerModules.default
    ];

	config = {
        programs.nixvim = {
            enable = true;
        };

        home.packages = with pkgs; [
            nil # nix language server
        ];
    };
}
