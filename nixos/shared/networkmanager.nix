# Enable NetworkManager for GUI setups

# `nmtui` can be used to manage network connections

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{
  networking.networkmanager.enable = true;
}
