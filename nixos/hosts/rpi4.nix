# Defines configuration for Raspberry Pi 4B
#
# Updating firmware:
# `mount /dev/disk/by-label/FIRMWARE /mnt`
# `BOOTFS=/mnt FIRMWARE_RELEASE_STATUS=stable rpi-eeprom-update -d -a`
#
# More info:
# https://nixos.wiki/wiki/NixOS_on_ARM/Raspberry_Pi_4
# https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_4
# https://github.com/NixOS/nixpkgs/issues/123725
# https://nix.dev/tutorials/nixos/installing-nixos-on-a-raspberry-pi
#
# To sync the system to the desired state:
# `sudo nixos-rebuild switch --flake ~/.swt/nixos#rpi4`

{
  nixpkgs,
  home-manager,
  nixos-hardware,
  ...
}:

nixpkgs.lib.nixosSystem {
  modules = [
    nixos-hardware.nixosModules.raspberry-pi-4

    ../shared/essentials.nix
    ../desktops/awesome.nix
    ../shared/fonts.nix
    ../shared/gui-apps.nix
    ../shared/i18n.nix
    ../shared/pipewire.nix
    ../shared/networkmanager.nix
    ../shared/users.nix
    ../services/sshd.nix

    home-manager.nixosModules.home-manager
    ../home

    {
      nixpkgs.hostPlatform = "aarch64-linux";

      # Use the extlinux boot loader.
      # (NixOS wants to enable GRUB by default)
      boot.loader.grub.enable = false;
      # Enables the generation of /boot/extlinux/extlinux.conf
      boot.loader.generic-extlinux-compatible.enable = true;

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "usbhid"
      ];

      # Fix Razer Abyssus 2014 mouse
      boot.kernelParams = [ "usbhid.mousepoll=0" ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
        fsType = "ext4";
      };

      environment.systemPackages = [
        nixpkgs.legacyPackages.aarch64-linux.libraspberrypi
        nixpkgs.legacyPackages.aarch64-linux.raspberrypi-eeprom

        # Ghostty doesn't work on Raspberry Pi 4B GPU
        nixpkgs.legacyPackages.aarch64-linux.alacritty
      ];

      # Changing hostname invalidates cookies and auth keys
      networking.hostName = "rpi4";

      # Prevent host becoming unreachable on WiFi after some time.
      networking.networkmanager.wifi.powersave = false;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "26.05"; # Did you read the comment?
    }

  ];
}
