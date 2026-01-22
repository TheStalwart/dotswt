# Set preferred desktop environment to Awesome

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  # Enable the X11 windowing system.
  # Raspberry Pi 4B struggles to run Wayland at acceptable framerate
  services.xserver.enable = true;

  # Lightweight CLI display manager
  services.displayManager.ly.enable = true;

  # Enable Awesome X11 session
  services.xserver.windowManager.awesome.enable = true;

  # This option visibly increases xterm resizing framerate
  # on Raspberry Pi 4B
  services.xserver.windowManager.awesome.noArgb = true;

  environment.systemPackages = with pkgs; [
    arandr
  ];
}
