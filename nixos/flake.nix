{
  description = "Stalwart's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      nixosConfigurations = {
        vm = import ./hosts/vm.nix { inherit nixpkgs; };
        gpd = import ./hosts/gpd.nix { inherit nixpkgs; };
      };
    };
}
