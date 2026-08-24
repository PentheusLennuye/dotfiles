{

  description = "NixOS Flakes for Cummings workstations";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  outputs =
    {
      self,
      nixos-hardware,
      nixpkgs,
      ...
    }@inputs:

    let
      system = "x86_64-linux";
      common_modules = [
        ./configuration.nix
        ./roles/common.nix
        ./roles/kubernetes-ctl.nix
        ./users.nix
      ];
    in
    {
      nixosConfigurations = {
        # ┌ Host Definitions ────────────────────────────────────────────────────────────┐
        # │                                                                              │
        # │ Insert your hosts here                                                       │
        # │                                                                              │
        # └──────────────────────────────────────────────────────────────────────────────┘
        jigen = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = common_modules ++ [
            ./hosts/jigen
            ./roles/dbms.nix
            ./roles/container-host.nix
            ./roles/k3s-server.nix
            ./roles/montreal.nix
            ./roles/nfs-server.nix
            ./roles/webhost.nix
          ];
        };
        # ────────────────────────────────────────────────────────────────────────────────
        lupin = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = common_modules ++ [
            ./hosts/lupin
            ./roles/dbms.nix
            ./roles/container-host.nix
            ./roles/k3s-first-server.nix
            ./roles/montreal.nix
            ./roles/nfs-server.nix
            ./roles/time.nix
            ./roles/webhost.nix
          ];
        };
        # ────────────────────────────────────────────────────────────────────────────────
        zenigata = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = common_modules ++ [
            ./hosts/zenigata
            ./roles/container-host.nix
            ./roles/k3s-server.nix
            ./roles/montreal.nix
            ./roles/vpn-mtl-endpoint.nix
            ./roles/webhost.nix
          ];
        };
        # ────────────────────────────────────────────────────────────────────────────────
      };
    };
}
