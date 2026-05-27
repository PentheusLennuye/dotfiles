{ ... }:

{

  networking.firewall.allowedTCPPorts = [
    2049
  ];

  services.nfs = {
    server = {
      enable = true;
      # fsid means "this is the root of the filesystem"
      exports = ''
        /srv/nfs *(rw,sync,fsid=0,crossmnt,no_subtree_check,sec=krb5:sys)
        /srv/nfs/private *(rw,sync,no_subtree_check,sec=krb5)
        /srv/nfs/protected 10.11.0.0/24(rw,sync,no_subtree_check) 172.16.73.0/24(rw,sync,no_subtree_check)
        /srv/nfs/public *(rw,wdelay,no_subtree_check)
      '';
    };
  };
}
