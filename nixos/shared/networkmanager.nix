# Enable NetworkManager for GUI setups

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{
  networking.networkmanager.enable = true;
}
