# Defines configuration of Portable instance of NixOS

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  imports = [
    ./desktops/hyprland.nix
    ./shared/essentials.nix
    ./shared/fonts.nix
    ./shared/gui-apps.nix
    ./shared/i18n.nix
    ./shared/networkmanager.nix
    ./shared/pipewire.nix
  ];

  # SSD with this instance is being plugged into PCs that usually run Windows
  time.hardwareClockInLocalTime = true;

  # Changing hostname invalidates cookies and auth keys
  networking.hostName = "portable";
}
