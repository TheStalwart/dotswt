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

{
  nixpkgs,
  home-manager,
  vscode-server,
  ...
}:

nixpkgs.lib.nixosSystem {
  modules = [
    /etc/nixos/configuration.nix
    ../shared/essentials.nix

    ../displayManagers/cosmic-greeter.nix
    ../desktops/cosmic.nix

    ../shared/fonts.nix
    ../shared/gui-apps.nix
    ../shared/i18n.nix
    ../shared/pipewire.nix
    ../shared/insecure-vm.nix
    ../shared/networkmanager.nix
    ../services/sshd.nix

    home-manager.nixosModules.home-manager
    ../home

    # Workaround for VSCode failing to deploy server binary
    # when connecting to a NixOS instance over SSH
    # https://github.com/nix-community/nixos-vscode-server
    vscode-server.nixosModules.default
    {
      services.vscode-server.enable = true;
      services.vscode-server.enableFHS = true;
    }
  ];
}
