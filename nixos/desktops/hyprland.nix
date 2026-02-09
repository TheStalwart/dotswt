# Set preferred desktop environment to Hyprland

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

# When switching from a different Desktop Environment,
# sometimes migration to dbus-broker is triggered.
# In that case,
# run `nixos-rebuild boot --upgrade-all` and reboot

{ pkgs, ... }:

{
  # SDDM correctly launches UWSM Hyprland session
  # but i don't like its performance and look.
  services.displayManager.sddm.enable = false;
  services.displayManager.sddm.wayland.enable = true;

  # ly fails to load UWSM Hyprland session,
  # but i don't see any issues with the regular Hyprland session so far
  services.displayManager.ly.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # required for Steam
  };

  # Hyprland itself does not implement
  # any ways to lock/sleep on user idleness
  services.hypridle.enable = true;

  # For Noctalia to detect laptop battery
  services.upower.enable = true;

  # I don't need scaling,
  # so don't bother with hyprcursor or SVG cursor themes for now.
  # nordzy-cursor-theme nixpkg comes with hyprcursor version
  # https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/
  environment.sessionVariables.XCURSOR_THEME = "Quintom_Snow";
  environment.sessionVariables.XCURSOR_SIZE = 24;

  environment.systemPackages = with pkgs; [
    hyprls # LSP server for Hyprland configuration files
    hyprmon # TUI multi-monitor layout editor
    hyprprop
    libnotify # notify-send
    noctalia-shell # https://docs.noctalia.dev/getting-started/nixos/
    nwg-displays # GUI multi-monitor layout editor
    quintom-cursor-theme
    wlrctl # Wayland CLI
  ];
}
