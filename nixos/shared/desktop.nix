# This file requires NixOS 25.11
# Upgrade from 25.05 with the following commands:
#   nix-channel --add https://channels.nixos.org/nixos-25.11 nixos
#   nixos-rebuild switch --upgrade

{ config, pkgs, ... }:

{
  # Enable NetworkManager for GUI setups
  networking.networkmanager.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  programs.firefox.enable = true;

  programs.vscode.enable = true;
  # Make VSCode use Wayland instead of X11
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ discord mesa-demos microsoft-edge ];
}
