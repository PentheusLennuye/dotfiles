{
  config,
  lib,
  net,
  pkgs,
  ...
}:

{

  environment.systemPackages = with pkgs; [
    clamav
    libpwquality
    suricata
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
    updater = {
      enable = true;
      interval = "5 8,19 * * *";
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
    enable = false; # On workstations. This thing is a little piggie.
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

  # ┌─────────────────────────┐
  # │ Wazuh                   ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ Wazuh is a file integrity monitoring (FIM) tool, like the old OSSEC-HIDS.                │
  #  │ It is not yet available on NixOS.                                                        │
  #  │                                                                                          │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘

  # services.wazuh-agent = {
  #   enable = true;
  #   configuration = {
  #     syscheck = {
  #       enabled = true;
  #       frequency = 600;
  #       directories = "/etc /bin /sbin /usr/bin /usr/sbin";
  #     };
  #   };
  # };

  # ┌─────────────────────────┐
  # │ Hardening               ├─────────────────────────────────────────────────────────────────┐
  # └┬────────────────────────┘                                                                 │
  #  │ These are the hardening items. Some are obvious, others take CPU and memory.             │
  #  │                                                                                          │
  #  └──────────────────────────────────────────────────────────────────────────────────────────┘

  boot.blacklistedKernelModules = [
    "dccp"
    "sctp"
    "rds"
    "tipc"
  ];

  environment.etc."issue" = {
    text = ''
      UNAUTHORIZED ACCESS IS STRICTLY PROHIBITED.
      All access and activity on this system are monitored and recorded.
      If you are not an authorized user, disconnect immediately.
    '';
    mode = "0644";
  };
  environment.etc."issue.net" = {
    text = ''
      UNAUTHORIZED ACCESS IS STRICTLY PROHIBITED.
      All access and activity on this system are monitored and recorded.
      If you are not an authorized user, disconnect immediately.
    '';
    mode = "0644";
  };

  services.openssh = {
    ports = [ 22 ];
    settings = {
      AllowAgentForwarding = false;
      AllowTCPForwarding = false;
      ClientAliveCountMax = 2;
      LogLevel = "VERBOSE";
      MaxAuthTries = 3;
      MaxSessions = 2;
      PasswordAuthentication = false;
      TCPKeepalive = false;
    };
  };

  security = {
    loginDefs = {
      settings = {
        DEFAULT_HOME = "yes";
        ENCRYPT_METHOD = "YESCRYPT";
        GID_MAX = 29999;
        GID_MIN = 1000;
        PASS_MAX_DAYS = 91;
        PASS_MIN_DAYS = 7;
        SYS_GID_MAX = 999;
        SYS_GID_MIN = 400;
        SYS_UID_MAX = 999;
        SYS_UID_MIN = 400;
        TTYGROUP = "tty";
        TTYPERM = "0620";
        UID_MAX = 29999;
        UID_MIN = 1000;
        UMASK = "077";
        YESCRYPT_COST_FACTOR = 6;
      };
    };
    pam = {
      services = {
        passwd = {
          rules = {
            password = {
              pwquality = {
                control = "required";
                modulePath = "${pkgs.libpwquality.lib}/lib/security/pam_pwquality.so";
                order = config.security.pam.services.passwd.rules.password.unix.order - 10;
                settings = {
                  enforce_for_root = true;
                  minlen = 9;
                  minclass = 4; # Require lowercase, uppercase, digits, and symbols
                  dcredit = 1; # Digits
                  ucredit = 1; # Uppercase
                  lcredit = 1; # Lowercase
                  ocredit = 1; # Symbols
                  retry = 3;
                };
              };
              unix = {
                control = lib.mkForce "required";
                settings = {
                  use_authtok = true;
                };
              };
            };
          };
        };
      };
    };
  };

}
