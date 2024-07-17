{ ... }: {
	config = {
		# Use the systemd-boot EFI boot loader.
        boot = {
            loader = {
                systemd-boot= {
                    enable = true;
                    # limit the number of displayed boot entries
                    configurationLimit = 5;
                };
                efi.canTouchEfiVariables = true;
            };

            # Parameters passed to the Linux kernel at boot time
            kernelParams = [
            # Minimize log messages during boot
            "quiet"
            # log info level messages from udev
            "udev.log_level=info"
            ];
        };
	};
}
