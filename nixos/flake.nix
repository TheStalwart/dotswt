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

    # https://github.com/nix-community/nixos-vscode-server
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      vscode-server,
      ...
    }:
    {
      nixosConfigurations = {
        vm = import ./hosts/vm.nix { inherit nixpkgs home-manager vscode-server; };
        gpd = import ./hosts/gpd.nix { inherit nixpkgs home-manager; };
        portable = import ./hosts/portable.nix { inherit nixpkgs home-manager; };
        rpi4 = import ./hosts/rpi4.nix { inherit nixpkgs home-manager nixos-hardware; };
      };
    };
}
