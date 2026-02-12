# More features than tuigreet, e.g. a battery indicator,
# but can't launch UWSM Hyprland session correctly.
#
# Also, seems to be broken in nixos-unstable as of February 2026.
{
  services.displayManager.ly = {
    enable = true;

    # https://github.com/fairyglade/ly/blob/master/res/config.ini
    settings = {
      bigclock = "en";
      clear_password = true;

      # ly ignores "services.displayManager.autoLogin" settings
      # unless this parameter is set.
      # I should probably report this to nixpkgs GitHub
      auto_login_service = "ly-autologin";
    };
  };
}
