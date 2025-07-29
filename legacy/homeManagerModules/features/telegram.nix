{
  pkgs,
  inputs,
  config,
  ...
}: {
  myHomeManager.impermanence.directories = [
    ".local/share/TelegramDesktop"
  ];
}
