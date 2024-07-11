{ pkgs, ... }: {
    config = {
        # List packages installed in system profile.
        environment.systemPackages = with pkgs; [
            nix
            git
            neovim
            nh # nix cli helper
        ];
    };
}