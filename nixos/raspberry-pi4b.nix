# Defines configuration for Raspberry Pi 4B

# Include this file in /etc/nixos/configuration.nix imports section
# and run:
# `nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware`
# `nixos-rebuild switch --upgrade-all` to sync system state

# Updating firmware:
# `mount /dev/disk/by-label/FIRMWARE /mnt`
# `BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable rpi-eeprom-update -d -a`

# More info:
# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_4
# https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
# https://github.com/NixOS/nixpkgs/issues/123725
# https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi

{ pkgs, ... }:

{
  imports = [
    "${fetchTarball "https://github.com/NixOS/nixos-hardware/tarball/master"}/raspberry-pi/4"

    ./desktops/awesome.nix
    ./shared/essentials.nix
    ./shared/fonts.nix
    ./shared/gui-apps.nix
    ./shared/i18n.nix
    ./shared/networkmanager.nix
    ./shared/pipewire.nix
    ./services/sshd.nix
  ];

  # Fix Razer Abyssus 2014 mouse
  boot.kernelParams = [ "usbhid.mousepoll=0" ];

  environment.systemPackages = with pkgs; [
    libraspberrypi
    raspberrypi-eeprom
    alacritty # Ghostty doesn't work on Raspberry Pi 4B GPU
  ];

  # Changing hostname invalidates cookies and auth keys
  networking.hostName = "rpi4";

  # Prevent host becoming unreachable on WiFi after some time.
  networking.networkmanager.wifi.powersave = false;
}
