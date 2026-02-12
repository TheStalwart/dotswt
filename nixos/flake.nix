{
  description = "Stalwart's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      # home-manager master == nixpkgs unstable
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      ...
    }:
    {
      nixosConfigurations = {
        vm = import ./hosts/vm.nix { inherit nixpkgs home-manager; };
        gpd = import ./hosts/gpd.nix { inherit nixpkgs home-manager; };
        portable = import ./hosts/portable.nix { inherit nixpkgs home-manager; };
      };
    };
}
