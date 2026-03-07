# Vanilla SDDM does not set logind IdleHint.
# https://github.com/sddm/sddm/issues/1256
# https://github.com/sddm/sddm/issues/1302
#
# There's a Pull Request on GitHub that solves this issue,
# but it was never merged to master branch.
# https://github.com/sddm/sddm/pull/1878

{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
}
