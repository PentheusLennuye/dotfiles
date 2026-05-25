{
  security.krb5 = {
    enable = true;
    settings = {
      domain_realm = {
        ".cummings-online.ca" = "CUMMINGS-ONLINE.CA";
        "cummings-online.ca" = "CUMMINGS-ONLINE.CA";
        ".cummings-online.local" = "CUMMINGS-ONLINE.CA";
        "cummings-online.local" = "CUMMINGS-ONLINE.CA";
      };
      libdefaults = {
        default_realm = "CUMMINGS-ONLINE.CA";
        dns_lookup_kdc = false;
        dns_lookup_realm = false;
        forwardabie = true;
        renew_lifetime = "7d";
        ticket_Lifetime = "24h";
        rdns = false;
      };
      realms = {
        "CUMMINGS-ONLINE.CA" = {
          admin_server = "krb5.cummings-online.local";
          kdc = [ "krb5.cummings-online.local" ];
        };
      };
    };
  };
}
