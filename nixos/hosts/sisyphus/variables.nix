{ config, ... }:
{
  config.role = {
    k8s = false;
    nvidia = true;
    virtualhost = true;
    workstation = true;
  };
}
