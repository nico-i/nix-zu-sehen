# My NixOS configuration

## How I want to setup my Nix configuration

This configuration is made up of two parts:

1. `/hosts/` - This directory contains the configuration for each of the hosts that I want to setup. Each host has its own configuration file.
2. `/modules/` - This directory contains all configurations I use as nix modules. The idea is to use the modules I need in each host configuration.

## Programs I want to install

I aim to use the minimal amount of programs that I need to get my work done. Here is a list of programs that I want to configure:

### Bootstrapping Programs

- [ ] [`disko`](https://github.com/nix-community/disko) - declarative nix-based **Disk Partitioning** tool
- [ ] [`home-manager`](https://github.com/nix-community/home-manager) - nix-based home folder and **Dotfile Management** tool

### Shell Programs

- [ ] [`zsh`](https://www.zsh.org/) - **interactive Shell**
- [ ] [`bash`](https://www.gnu.org/software/bash/) - **Scripting Shell**
- [ ] [`kitty`](https://sw.kovidgoyal.net/kitty/) - **Terminal Emulator**
- [ ] [`fzf`](https://github.com/junegunn/fzf) - **Fuzzy Finder**
  - A fuzzy finder allows you to search for files and directories without typing the full name
- [ ] [`zoxide`](https://github.com/ajeetdsouza/zoxide) - **Directory Navigation**
  - `cd` command that learns your habits
  - supports `fzf` integration
- [ ] [`mc`](https://midnight-commander.org/) - Midnight Commander **File Manager**
- [ ] [`bottom`](https://github.com/ClementTsang/bottom) - **System Monitor**
- [ ] [`nixvim`](https://github.com/nix-community/nixvim) - **IDE**: NeoVim with Nix modules config support
- [ ] [`git`](https://git-scm.com/) - **Version Control System**
- [ ] [`mpv`](https://mpv.io/) - terminal-based **video Player**
- [ ] [`imv`](https://sr.ht/~exec64/imv/) - terminal-based **image Viewer**
- [ ] [`ripdrag`](https://github.com/nik012003/ripdrag) - drag and drop files to and from the terminal

### Desktop UI

Since I am setting up my own desktop environment, from scratch, I want to use the following programs:

- [ ] [`hyprland`](https://hyprland.org/) - Wayland-based **window manager**
- [ ] [Waybar](https://github.com/Alexays/Waybar) - Customizable Wayland-based **desktop bar**
- [ ] [rofi](https://github.com/davatorium/rofi) - **Application Launcher**

### Audio

- [ ] [`pipewire`](https://nixos.wiki/wiki/PipeWire) - **Audio Server**

### GUI Applications

- [ ] [ungoogled-chromium](https://github.com/ungoogled-software/ungoogled-chromium) - A **Web Browser** that behaves like chrome (web-dev requirement)
- [ ] [zathura](https://github.com/pwmt/zathura) - **PDF Viewer** with vim-like keybindings
- [ ] [`spotify`](https://www.spotify.com/) - **Music Streaming Service**

## Glossary

Important terms to understand linux and NixOS:

- [Wayland](https://wayland.freedesktop.org/) - Successor to the [X Window System](https://en.wikipedia.org/wiki/X_Window_System)
- Dotfile - Configuration files that start with a `.` in the filename, e.g. `.bashrc`, `.vimrc`