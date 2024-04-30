{
  pkgs,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "Nico Ismaili";
    userEmail = "nico@ismaili.de";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
    };
  };
}