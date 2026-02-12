# Disables password prompts
# to streamline UX when used in VM

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ lib, ... }:

{
  security.sudo.wheelNeedsPassword = false;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "stalwart";
}
