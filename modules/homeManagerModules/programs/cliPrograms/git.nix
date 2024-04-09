let
  userData = import ../../../lib/user-data.nix;
in

{
  programs.git = {
    enable = true;
    userName = "${userData.firstName} ${userData.lastName}";
    userEmail = userData.email;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };
  };
}
