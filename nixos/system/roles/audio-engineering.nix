{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    dexed                                  # DX7 VST plugin
    fdk-aac-encoder                        # Convert to AAC
    ffmpeg                                 # Audio conversion
    ladspaPlugins                          # Audio effect plugins
    linuxsampler                           # Sample-based synthesizer VST
    obs-studio                             # Screen recorder
    qsampler                               # GUI for linuxsampler
    qjackctl                               # JACK patch panel for audio work
    qpwgraph                               # Pipewire graph interface
    reaper                                 # DAW
    roomeqwizard                           # Room Acoustics Software
    surge                                  # Additive synthesizer
  ];
}
