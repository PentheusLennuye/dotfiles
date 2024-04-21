{ pkgs, ... }:
{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;             # Intercept ALSA clients
    alsa.support32Bit = true;
    jack.enable = true;             # Intercept JACK clients
    pulse.enable = true;            # Intercept PulseAudio clients

    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.allowed-rates = [ 44100 48000 ];
        default.clock.rate = 48000;
        default.clock.quantum = 128;     # 3ms max for voice. Can go lower
        default.clock.min-quantum = 32;  # 0.667ms ultimate
        default.clock.max-quantum = 512;  # ~12ms for distant guitar max
      };
    };
  };
}
