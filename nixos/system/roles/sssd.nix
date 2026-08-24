{ pkgs, ... }:
{
  environment.systemPackages = [ pkgs.sssd ];
  services.sssd = {
    enable = true;
    settings = {
      sssd = {
        services = "nss, pam";
        domains = "local,cummings-online.local";
      };
      nss = { };
      pam = { };
      "domain/local" = {
        auth_provider = "none";
        id_provider = "proxy";
        proxy_lib_name = "files";
        access_provider = "permit";
        enumerate = true;
      };
      "domain/cummings-online.local" = {
        auth_provider = "krb5";
        cache_credentials = true;
        fallback_homedir = "/home/%u";
        id_provider = "proxy";
        use_fully_qualified_names = false;

        krb5_store_password_if_offline = true;
        krb5_auth_timeout = "15";
        krb5_kpasswd = "krb5.cummings-online.local";
        krb5_realm = "CUMMINGS-ONLINE.LOCAL";
        krb5_server = "krb5.cummings-online.local";

        proxy_fast_alias = true;
        proxy_lib_name = "files";
        enumerate = true;
      };
    };
  };
}
