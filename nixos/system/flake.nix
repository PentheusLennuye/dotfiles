{

  description = "NixOS Flakes for Cummings workstations";
 
  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
  };

  #outputs = { self, home-manager, nixos-hardware, nixpkgs, nixpkgs-unstable, ... } @inputs:
  outputs = { self, nixos-hardware, nixpkgs, nixpkgs-unstable, ... } @inputs:
              
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
    	inherit system;
    };
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
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
        specialArgs = {inherit inputs unstable;};
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
          ./roles/workstation.nix
        ];
      };
      goemon = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs unstable;};
        modules = common_modules ++ [
          ./gpu/amd.nix
          ./hosts/goemon
          ./roles/audio-engineering.nix
          ./roles/container-host.nix
          ./roles/development.nix
          ./roles/gaming.nix
          ./roles/montreal.nix
          ./roles/publishing.nix
          ./roles/remote-access.nix
          ./roles/virt-host.nix
          ./roles/workstation.nix
        ];
      };
      jigen = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = common_modules ++ [
          ./roles/aaa.nix
          ./roles/dbms.nix
          ./hosts/jigen
          ./roles/container-host.nix
          ./roles/k3s-server.nix
          ./roles/montreal.nix
          ./roles/webhost.nix
        ];
      };
      lupin = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs unstable;};
        modules = common_modules ++ [
          ./roles/aaa.nix
          ./roles/dbms.nix
          ./roles/development.nix
          ./hosts/lupin
          ./roles/container-host.nix
          ./roles/k3s-server.nix
          ./roles/montreal.nix
          ./roles/webhost.nix
         ];
      };
      murasaki = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs unstable;};
        modules = common_modules ++ [
          ./gpu/opengl.nix
          ./hosts/murasaki
          ./roles/audio-engineering.nix
          ./roles/container-host.nix
          ./roles/development.nix
          ./roles/gaming.nix
          ./roles/laptop.nix
          ./roles/publishing.nix
          ./roles/workstation.nix
        ];
      };
      zenigata = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs unstable;};
        modules = common_modules ++ [
          ./hosts/zenigata
          ./roles/container-host.nix
          ./roles/k3s-server.nix
          ./roles/montreal.nix
          ./roles/webhost.nix
         ];
      };
    };
  };
}
