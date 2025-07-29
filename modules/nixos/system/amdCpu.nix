{ config, ... }: {
  config.hardware.cpu.amd.updateMicrocode = true; # needs unfree
}
