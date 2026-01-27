# Disables password prompts
# to streamline UX when used in VM

{ lib, ... }:

{
  security.sudo.wheelNeedsPassword = false;

  # ly doesn't support auto login, use COSMIC Greeter instead
  services.displayManager.ly.enable = lib.mkForce false;
  services.displayManager.cosmic-greeter.enable = lib.mkForce true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "stalwart";
}
