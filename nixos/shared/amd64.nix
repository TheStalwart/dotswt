# Defines x86_64-specific options
# that don't work for Raspberry Pi

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  programs.steam.enable = true;
  hardware.intel-gpu-tools.enable = true;

  environment.systemPackages = with pkgs; [
    discord
    spotify
    microsoft-edge
  ];
}
