{ pkgs, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };
  environment.systemPackages = with pkgs; [
    swtpm # software TPM for virtual guests
    terraform
    vagrant
  ];
}
