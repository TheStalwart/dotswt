{
  # https://search.nixos.org/options?query=i18n
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "lv_LV.UTF-8/UTF-8" ];
  i18n.extraLocaleSettings = {
    LC_TIME = "lv_LV.UTF-8"; # use 24-hour clock format
  };

  # https://search.nixos.org/options?query=timezone
  time.timeZone = "Europe/Riga";
}
