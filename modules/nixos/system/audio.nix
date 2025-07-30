{ ... }:
{
  config = {
    security.rtkit.enable = true;
    # avahi required for AirPlay discovery
    services.avahi.enable = true;

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true; # necessary for MIDI and audio interfaces
      raopOpenFirewall = true; # opens UDP ports 6001-6002 for AirPlay

      extraConfig = {
        "10-airplay" = {
          "context.modules" = [
            {
              name = "libpipewire-module-raop-discover";

              # increase the buffer size if you get dropouts/glitches
              # args = {
              #   "raop.latency.ms" = 500;
              # };
            }
          ];
        };
        # setup ultra low latency audio
        pipewire = {
          "92-low-latency" = {
            context.properties = {
              default.clock.rate = 48000;
              default.clock.quantum = 32;
              default.clock.min-quantum = 32;
              default.clock.max-quantum = 32;
            };
          };
        };
        # setup ultra low latency audio for any pulseaudio clients
        pipewire-pulse."92-low-latency" = {
          context.modules = [
            {
              name = "libpipewire-module-protocol-pulse";
              args = {
                pulse.min.req = "32/48000";
                pulse.default.req = "32/48000";
                pulse.max.req = "32/48000";
                pulse.min.quantum = "32/48000";
                pulse.max.quantum = "32/48000";
              };
            }
          ];
          stream.properties = {
            node.latency = "32/48000";
            resample.quality = 1;
          };
        };
      };
    };
    # audio noise cancellation tool
    programs.noisetorch.enable = true;
  };
}
