# Disables password prompts
# to streamline UX when used in VM

{
  security.sudo.wheelNeedsPassword = false;

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "stalwart";
}
