{

  description = "NixOS Flakes for Cummings workstations";
 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      sisyphus = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./common/oryx.nix
          ./common/system-packages.nix
          ./common/tls.nix
          ./configuration.nix
          ./hosts/sisyphus/bootloaders.nix
          ./hosts/sisyphus/networking.nix
          ./hosts/sisyphus/opengl.nix
          ./hosts/sisyphus/runlevel5.nix
          ./hosts/sisyphus/sound.nix
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
