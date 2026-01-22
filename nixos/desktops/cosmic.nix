# Set preferred desktop environment to COSMIC

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{
  # Enable the COSMIC login manager
  services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  services.desktopManager.cosmic.enable = true;

  # Enable the COSMIC system76-scheduler
  # https://github.com/pop-os/system76-scheduler
  services.system76-scheduler.enable = true;
}
