{ config, ... }: {
  config = {
    # Use the systemd-boot EFI boot loader.
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          # limit the number of displayed boot entries
          configurationLimit = 5;
        };
        efi.canTouchEfiVariables = true;
      };

      # Additional kernel modules to include in the NixOS kernel
      kernelModules = [
        "coretemp" # Support for monitoring CPU core temperatures
        "cpuid" # Allow access to CPU identification and features
        "v4l2loopback" # Create virtual video loopback devices
      ];

      # Parameters passed to the Linux kernel at boot time
      kernelParams = [
        # Minimize log messages during boot
        "quiet"
        # log info level messages from udev
        "udev.log_level=info"
      ] ++ (if config.customNixOSConfig.nvidia.enable then [
        "nvidia_drm.fbdev=1" # Enable framebuffer device support for Nvidia DRM
        "nvidia_drm.modeset=1" # Enable kernel mode setting for Nvidia DRM
      ] else
        [ ]);
    };
  };
}
