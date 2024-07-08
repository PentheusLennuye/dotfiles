{ config, ... }:

{
  config.role = {
    k8s = true;
    nvidia = false;
    virtualhost = true;
    workstation = true;
  };
}
