{ pkgs, ... }: {
  config = {
    # List packages installed in system profile.
    environment.systemPackages = with pkgs; [
      nix
      git
      vim
      neofetch
      nh # nix cli helper
    ];

    programs.zsh.enable = true;
  };
}
