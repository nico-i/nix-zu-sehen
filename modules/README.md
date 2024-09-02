# `/modules/` directory

This directory contains all custom modules and configurations grouped by their corresponding consumer i. e. `nixos`, `home-manager`, etc.

Each directory contains a `default.nix` injects the contained custom modules (with `enable` options) into a custom configuration, allowing them to be toggled at the highest configuration-level, and defines defaults for each said injected modules.

*Example: The `nixos` directory contains all custom modules and configurations relating NixOS. They can be toggled by configuring `customNixOSConfig` in your `configuration.nix` file.*

## Architecture

```plaintext
.
└── modules/
    ├── nixos/ # Consumer directory
    │   ├── customization/ # Domain directory
    │   │   ├── hyprland # Custom module
    │   │   └── [...]
    │   └── [...]
    └── [...]
```

- all domains which custom modules have been setup for are located in the root of each consumer directory
  - *Example: all custom modules relating to customizing the entire NixOS system are located in `./nixos/customization`*
- the domain directory e. g. `customization` contains all custom modules and configurations for that domain
  - *Example: the custom Hyprland configuration is located in `./nixos/customization/hyprland`*
- Custom modules can be toggled by configuring the `customNiXOSConfig` attribute in your `configuration.nix` file
  - *Example: The Hyprland configuration can be toggled by configuring `customNixOSConfig.customization.hyprland.enable`*

## Usage Example

Add a `customNixOSConfig` attribute to your `configuration.nix` file:

```nix
{
  lib,
  ...
}: {
  imports =
    [
      ./hardware-configuration.nix
    ];

  customNixOSConfig = {
    customization = {
      # Enable `hyprland` configuration + the pkg itself
        hyprland.enable = true;
    };
  };
}
```

## Creating / Editing Custom Modules

Making new custom modules available in a custom config such as e. g. the `customNixOSConfig` is an automatic process. This is done by using the [injectEnableOptionIntoModules](../lib/modules/injectEnableOptionIntoModules.nix) helper function. It adds the `enable` option to all nix modules present in the passed list of directories and then adds them to the specified custom configuration.

Therefore, all you need to do to edit or create a custom configuration is to create a nix module in the desired domain directory (or create a new domain directory if necessary) whilst following the standard [NixOS module](https://nixos.wiki/wiki/NixOS_modules) syntax. The `enable` option will be automatically added to your module and you can then toggle it in your custom configuration.

If you would like to pass some default values to your custom module, you can do so by adding them to the `default.nix` file in the consumer directory.
