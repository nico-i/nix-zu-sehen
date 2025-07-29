{ pkgs, ... }:
{
  home.packages = with pkgs; [
    xclip # Clipboard utility for the command line
    sxhkd # Simple X hotkey daemon

    xorg.xev # Display X events, useful for configuring hotkeys
    xorg.xbacklight # Control screen backlight brightness
    xorg.xhost # Manage access to the X server

    maim # Screenshot tool
    xdotool # Simulate keyboard and mouse input, manage windows
    devour # Temporarily hide terminal windows
    ueberzug # Display images in terminals
    pkgs.picom-jonaburg # Enhanced compositor for Xorg with animations
  ];
}
