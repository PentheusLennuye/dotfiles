{

  description = "NixOS Flakes for Cummings workstations";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    unstable = import nixpkgs-unstable { inherit system; };
    common_modules = [
        ./configuration.nix
        ./roles/common.nix
        ./users.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gmc = import ./users/gmc/home.nix;
          home-manager.extraSpecialArgs = { inherit unstable; };
        }
    ];
  in
  {
    nixosConfigurations = {
      sisyphus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = common_modules ++ [
          ./gpu/nvidia.nix
          ./hosts/sisyphus
          ./roles/container-host.nix
          ./roles/virt-host.nix
          ./roles/workstation.nix
        ];
      };
      glaucus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = common_modules ++ [
          ./gpu/opengl.nix
          ./hosts/glaucus
          ./roles/container-host.nix
          ./roles/laptop.nix
          ./roles/workstation-light.nix
        ];
      };
      goemon = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = common_modules ++ [
          ./gpu/amd.nix
          ./hosts/goemon
          ./roles/container-host.nix
          ./roles/virt-host.nix
          ./roles/workstation.nix
        ];
      };
      jigen = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = common_modules ++ [
          ./roles/k3s-server.nix
          ./roles/container-host.nix
          ./roles/webhost.nix
          ./hosts/jigen
        ];
      };
    };
  };
}
