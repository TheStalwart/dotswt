# Define the GNOME Desktop Environment configuration

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

# GNOME is highly opinionated, dare i say it... xenophobic.
# It only makes sense if you're using mostly GNOME apps 
# and like the iPadOS-like window management.
# GNOME Calendar fails to load with my iCloud account synced,
# and that leaves me with no reasons to stay on GNOME.

{ pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.caffeine
  ];
}
