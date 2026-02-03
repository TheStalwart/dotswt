# Defines configuration for Raspberry Pi 4B

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  imports = [
    ./desktops/awesome.nix
    ./shared/essentials.nix
    ./shared/fonts.nix
    ./shared/gui-apps.nix
    ./shared/i18n.nix
    ./shared/networkmanager.nix
    ./shared/pipewire.nix
  ];

  # Changing hostname invalidates cookies and auth keys
  networking.hostName = "rpi4";
}
