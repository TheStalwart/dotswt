# Set preferred desktop environment to Hyprland

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # required for Steam
  };

  # I don't need scaling,
  # so don't bother with hyprcursor or SVG cursor themes for now.
  # nordzy-cursor-theme nixpkg comes with hyprcursor version
  # https://wiki.hypr.land/Hypr-Ecosystem/hyprcursor/
  environment.sessionVariables.XCURSOR_THEME = "Quintom_Snow";
  environment.sessionVariables.XCURSOR_SIZE = 24;

  environment.systemPackages = with pkgs; [
    noctalia-shell # https://docs.noctalia.dev/getting-started/nixos/
    nwg-displays # GUI multi-monitor layout editor
    quintom-cursor-theme
  ];
}
