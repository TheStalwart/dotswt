# Portable instance of NixOS
#
# To sync the system to the desired state:
# `sudo nixos-rebuild switch --flake ~/.swt/nixos#portable --impure`

{ nixpkgs, home-manager, ... }:

nixpkgs.lib.nixosSystem {
  modules = [
    /etc/nixos/hardware-configuration.nix
    ../shared/essentials.nix
    ../desktops/hyprland.nix
    ../shared/fonts.nix
    ../shared/gui-apps.nix
    ../shared/i18n.nix
    ../shared/pipewire.nix
    ../shared/networkmanager.nix
    ../shared/users.nix

    home-manager.nixosModules.home-manager
    ../home

    {
      boot.initrd.luks.devices."luks-5c92e6c5-3005-4218-bae7-857d202f322d".device =
        "/dev/disk/by-uuid/5c92e6c5-3005-4218-bae7-857d202f322d";

      # SSD with this instance is being plugged into PCs that usually run Windows
      time.hardwareClockInLocalTime = true;

      # Changing hostname invalidates cookies and auth keys
      networking.hostName = "portable";

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
