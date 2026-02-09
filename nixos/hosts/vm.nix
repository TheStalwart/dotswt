# Experimental and throwaway VMs.
#
# Use COSMIC Desktop to be accessible with a mouse
# and avoid keyboard shortcut overlap with host system.
#
# /etc/nixos/configuration.nix
# should be cleaned out of most definitions,
# with only instance-specific options left,
# e.g.:
# - imports = [ ./hardware-configuration.nix ];
# - networking.hostName = "nixos";
# - users.users...
# - system.stateVersion = "25.05";
#
# To sync the system to the desired state:
# `sudo nixos-rebuild switch --flake ~/.swt/nixos#vm --impure`

{ nixpkgs }:

nixpkgs.lib.nixosSystem {
  modules = [
    /etc/nixos/configuration.nix
    ../shared/essentials.nix
    ../desktops/cosmic.nix
    ../shared/fonts.nix
    ../shared/gui-apps.nix
    ../shared/i18n.nix
    ../shared/pipewire.nix
    ../shared/insecure-vm.nix
    ../shared/networkmanager.nix
  ];
}
