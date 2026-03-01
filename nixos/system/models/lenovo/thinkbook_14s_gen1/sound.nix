{ ... }:
{
  services.pipewire = {
    extraConfig.pipewire."51-device-rename" = {
      monitor.alsa.rules = {
        matches = [
          {
            node.name = "alsa_card.pci-0000_00_1f.3-platform-skl_hda_dsp_generic";
          }
        ];
        actions = {
          update-props = {
            node.description = "SSTAC";
          };
        };
      };
    };
  };
}
