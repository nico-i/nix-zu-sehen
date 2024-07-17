# https://github.com/kovidgoyal/kitty
{
  config,
  ...
}: {
  config.programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
  };
}