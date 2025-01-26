{ config, pkgs, ... }:

{
  config.services.postgresql = {
    enable = true;
    enableTCPIP = true;
    package = pkgs.postgresql_16;
    authentication  = pkgs.lib.mkOverride 10 ''
      #type database user cid/r              auth
      local all      all                     peer
      host  all      all  192.168.68.0/24    scram-sha-256
      host  all      all  192.168.73.0/24    scram-sha-256
    '';
    identMap = ''
      # mapname       system_user  db_user
        superuser_map root         postgres
        superuser_map postgres     postgres
        superuser_map gmc          postgres
    '';
  };
}
