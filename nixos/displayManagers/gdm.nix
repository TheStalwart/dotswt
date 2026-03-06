# GNOME Display Manager
#
# Allegedly implements logind IdleHint,
# but also has its own power management settings
# that are configured via dconf and override logind.

{
  services.displayManager.gdm.enable = true;
}
