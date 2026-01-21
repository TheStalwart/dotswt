# Define the GNOME Desktop Environment configuration

# Copy or symlink this file to /etc/nixos/configuration.nix
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{
  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
}
