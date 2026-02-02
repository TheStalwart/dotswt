# Disables password prompts
# to streamline UX when used in VM

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ lib, ... }:

{
  security.sudo.wheelNeedsPassword = false;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "stalwart";

  # ly ignores "services.displayManager.autoLogin" settings
  # unless this parameter is set.
  # I should probably report this to nixpkgs GitHub
  services.displayManager.ly.settings = {
    auto_login_service = "ly-autologin";
  };
}
