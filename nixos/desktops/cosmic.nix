# Set preferred desktop environment to COSMIC
#
# COSMIC often crashes on nixos-rebuild,
# so make sure to update the system in screen or tty.
#
# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  # Enable the COSMIC system76-scheduler
  # https://github.com/pop-os/system76-scheduler
  services.system76-scheduler.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-ext-applet-caffeine
    cosmic-ext-applet-minimon
  ];
}
