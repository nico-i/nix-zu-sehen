{pkgs, ...}: {
  hardware.uinput.enable = true;
  users.groups.uinput.members = ["nico"];
  users.groups.input.members = ["nico"];
}
