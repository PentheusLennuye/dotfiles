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
    pkgs = import nixpkgs {inherit system;};
    unstable = import nixpkgs-unstable {inherit system;};
  in
  {
    nixosConfigurations = {
      sisyphus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/sisyphus
          ./users.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gmc = import ./users/gmc/home.nix;
            home-maanger.extraSpecialArgs = { inherit unstable; };
          }
        ];
      };
      glaucus = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/glaucus
          ./users.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gmc = import ./users/gmc/home.nix;
            home-manager.extraSpecialArgs = { inherit unstable; };
          }
        ];
      };
      goemon = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit unstable;};
        modules = [
          ./configuration.nix
          ./hosts/goemon
          ./users.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gmc = import ./users/gmc/home.nix;
            home-manager.extraSpecialArgs = { inherit unstable; };
          }
        ];
      };
      jigen = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          ./hosts/jigen
          ./users.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.gmc = import ./users/gmc/home.nix;
          }
        ];
      };
    };
  };
}
