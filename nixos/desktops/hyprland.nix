# Set preferred desktop environment to Hyprland
#
# Hyprland is useless without hand-crafted dotfiles,
# so this configuration depends on home-manager.
#
# When switching from a different Desktop Environment,
# sometimes migration to dbus-broker is triggered.
# In that case, run `nixos-rebuild boot` and reboot

{ pkgs, ... }:

{
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

  home-manager.users.stalwart =
    { config, ... }:
    {
      xdg.configFile = {
        "hypr/hyprland.conf" = {
          source = config.lib.file.mkOutOfStoreSymlink ../../hypr/hyprland.conf;
        };
        "hypr/hypridle.conf" = {
          source = config.lib.file.mkOutOfStoreSymlink ../../hypr/hypridle.conf;
        };
      };
    };
}
