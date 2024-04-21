{ pkgs, ... }:

{
  home.packages = with pkgs; [
    dexed                                  # DX7 VST plugin
    ladspaPlugins                          # Audio effect plugins
    linuxsampler                           # Sample-based synthesizer VST
    qsampler                               # GUI for linuxsampler
    qjackctl                               # JACK patch panel for audio work
    qpwgraph                               # Pipewire graph interface
    reaper                                 # DAW
    surge                                  # Additive synthesizer
  ];
}
