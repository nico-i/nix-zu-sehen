{ pkgs, ... }: {
    config = {
        # List packages installed in system profile.
        environment.systemPackages = with pkgs; [
            neovim
            nh # nix cli helper
        ];
    };
}