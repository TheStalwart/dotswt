# tuigreet
# Like ly, less features, but XDG Session compatible.
#
# Seems to ignore services.displayManager.autoLogin.* Nix Options.
# Also, doesn't correctly report IdleHints to logind,
# so a PC won't suspend unless i log in to desktop.
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
        command = ''
          ${pkgs.tuigreet}/bin/tuigreet \
          --asterisks \
          --remember \
          --remember-user-session \
          --time \
          --sessions ${config.services.displayManager.sessionData.desktops}/share/xsessions:${config.services.displayManager.sessionData.desktops}/share/wayland-sessions
        '';
        user = "greeter";
      };
    };

  };

  # Prevent systemd from killing session on nixos-rebuild
  systemd.services.greetd.restartIfChanged = false;
}
