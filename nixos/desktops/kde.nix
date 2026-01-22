# Defines desired GUI Desktop Environment configuration

# Requires NixOS 25.11, upgrade from 25.05 with the following commands:
#   nix-channel --add https://channels.nixos.org/nixos-25.11 nixos
#   nixos-rebuild switch --upgrade-all
# Or go straight to NixOS Unstable:
#   nix-channel --add https://channels.nixos.org/nixos-unstable nixos
#   nixos-rebuild switch --upgrade-all

{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # https://wiki.nixos.org/wiki/Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [ corefonts vista-fonts twemoji-color-font ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" ];
        sansSerif = [ "Liberation Sans" ];
        monospace = [ "Liberation Mono" ];
        emoji = [ "Twemoji" ];
      };
    };
  };
}
