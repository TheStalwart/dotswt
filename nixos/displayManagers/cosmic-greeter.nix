# cosmic-greeter
# XDG Session compatible, good looking, not the fastest.
#
# Unlike tuigreet, supports services.displayManager.autoLogin.* Nix Options.

{
  services.greetd.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Prevent systemd from killing session on nixos-rebuild
  systemd.services.greetd.restartIfChanged = false;
}
