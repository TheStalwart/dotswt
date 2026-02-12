# tuigreet
# Like ly, less features, but XDG Session compatible.
#
# Seems to ignore services.displayManager.autoLogin.* Nix Options.
#
# https://github.com/apognu/tuigreet
# https://ryjelsum.me/homelab/greetd-session-choose/

{ config, pkgs, ... }:

{
  services.greetd = {
    enable = true;

    # This option supposedly prevents systemd from printing over tuigreet,
    # but i still get random prints from time to time.
    useTextGreeter = true;

    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --sessions ${config.services.xserver.displayManager.sessionData.desktops}/share/xsessions:${config.services.xserver.displayManager.sessionData.desktops}/share/wayland-sessions --remember --remember-user-session --time";
        user = "greeter";
      };
    };

  };

  # Prevent systemd from killing session on nixos-rebuild
  systemd.services.greetd.restartIfChanged = false;
}
