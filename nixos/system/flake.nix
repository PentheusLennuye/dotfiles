{

  description = "NixOS Flakes for Cummings workstations";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
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
      pkgs = import nixpkgs {
        inherit system;
      };
      common_modules = [
        ./configuration.nix
        ./roles/common.nix
        ./roles/kubernetes-ctl.nix
        ./users.nix
      ];
    in
    {
      nixosConfigurations = {
        glaucus = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = common_modules ++ [
            nixos-hardware.nixosModules.lenovo-thinkpad-x250
            ./gpu/opengl.nix
            ./hosts/glaucus
            ./roles/audio-engineering.nix
            ./roles/container-host.nix
            ./roles/dbms.nix
            ./roles/development.nix
            ./roles/gaming.nix
            ./roles/laptop.nix
            ./roles/publishing.nix
          ];
        };
        goemon = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = common_modules ++ [
            ./gpu/amd.nix
            ./hosts/goemon
            ./roles/alarm.nix
            ./roles/audio-engineering.nix
            ./roles/binarycache.nix
            ./roles/container-host.nix
            ./roles/desktop.nix
            ./roles/development.nix
            ./roles/engineering.nix
            ./roles/gaming.nix
            # ./roles/knowlton.nix
            ./roles/media.nix
            ./roles/montreal.nix
            ./roles/netadmin.nix
            ./roles/publishing.nix
            ./roles/remote-access.nix
            ./roles/virt-host.nix
          ];
        };
        jigen = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = common_modules ++ [
            ./roles/dbms.nix
            ./hosts/jigen
            ./roles/container-host.nix
            ./roles/k3s-server.nix
            ./roles/montreal.nix
            ./roles/nfs-server.nix
            ./roles/webhost.nix
          ];
        };
        lupin = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = common_modules ++ [
            ./roles/dbms.nix
            ./roles/development.nix
            ./hosts/lupin
            ./roles/container-host.nix
            ./roles/k3s-first-server.nix
            ./roles/montreal.nix
            ./roles/nfs-server.nix
            ./roles/time.nix
            ./roles/webhost.nix
          ];
        };
        murasaki = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = common_modules ++ [
            ./gpu/opengl.nix
            ./hosts/murasaki
            ./roles/alarm.nix
            ./roles/audio-engineering.nix
            ./roles/container-host.nix
            ./roles/development.nix
            ./roles/engineering.nix
            ./roles/gaming.nix
            ./roles/media.nix
            ./roles/netadmin.nix
            ./roles/publishing.nix
            ./roles/thinkbook.nix
            ./roles/virt-host.nix
          ];
        };
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
      };
    };
}
