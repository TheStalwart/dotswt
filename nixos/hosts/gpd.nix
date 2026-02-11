# GPD Pocket Touch
# https://www.gpd.hk/gpdpocket
#
# I tested both X11 and Wayland,
# and lightweight Wayland setup feels more responsive.
#
# Make sure to have at least 2GB of Swap
# when building this flake.
# Verify with: `swapon --show`
#
# To sync the system to the desired state:
# `sudo nixos-rebuild switch --flake ~/.swt/nixos#gpd --impure`

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
      boot.kernelParams = [
        "gpd-pocket-fan.speed_on_ac=0" # override BIOS attempts to run fan at full speed while charging
      ];

      networking.hostName = "gpd";

      hardware.bluetooth.enable = true;

      services.openssh = {
        enable = true;
        settings = {
          PasswordAuthentication = false;
          PermitRootLogin = "no";
        };
      };

      services.displayManager.ly.settings = {
        battery_id = "max170xx_battery";
      };

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.05"; # Did you read the comment?
    }
  ];
}
