{ pkgs, net, ... }:

{

  environment.systemPackages = with pkgs; [
    clamav
    suricata
    (python312.withPackages (ps: [ ps.pyyaml ]))
  ];

  # ┌─────────────────────────┐
  # │ ClamAV                  ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ An Open Source anti-virus wih subscription option.                                       │
  #  │                                                                                          │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘

  services.clamav = {
    daemon = {
      enable = true;
      settings = {
        OnAccessPrevention = true;
        OnAccessIncludePath = "/home";
      };
    };
    clamonacc = {
      enable = true;
    };
  };

  # ┌─────────────────────────┐
  # │ Suricata                ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ Suricata is an IDS and IPS, i.e. an intrusion detection system and intrusion prevention  │
  #  │ system. This sort of thing really shouldn't be on a public GitHub but at this point I do │
  #  │ not care.                                                                                │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘

  services.suricata = {
    disabledRules = [
      # mDNS is permitted at home
      "3300149"
      "3300150"
      "3300153"
      "3300154"
      # stream excessive retransmissions is usually a false positive
      "2210054"
    ];
    enable = true;
    settings = {
      af-packet = [
        {
          interface = net.if0;
          cluster-id = "99";
          cluster-type = "cluster_flow";
          defrag = true;
          tpacket-v3 = true;
        }
      ];
      app-layer = {
        protocols = {
          modbus = {
            enabled = "yes";
          };
        };
      };
      outputs = [
        {
          fast = {
            enabled = true;
            filename = "fast.log";
            append = false;
          };
        }
      ];
      stream = {
        reassembly = {
          depth = 0;
        };
      };
    };
  };
}
