# Set preferred desktop environment to COSMIC

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  # Disable the COSMIC login manager.
  # Startup is much longer than ly,
  # with no perceivable benefit
  services.displayManager.cosmic-greeter.enable = false;

  # Lightweight CLI display manager
  services.displayManager.ly.enable = true;

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
