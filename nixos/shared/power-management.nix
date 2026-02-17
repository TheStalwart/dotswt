{
  # Suspend if no activity on login screen.
  # After login, apps like hypridle will override these settings.
  #
  # A notable exception is COSMIC,
  # which doesn't seem to inhibit logind defaults,
  # so it will suspend after 3 minutes even if user is logged in and active.
  #
  # NB: Suspended Proxmox VMs fail to wake up.
  #
  # See also: man logind.conf
  services.logind.settings.Login = {
    # let logind choose the most appropriate way to suspend/hibernate,
    # depending on hardware capabilities
    IdleAction = "sleep";
    IdleActionSec = "3min";
  };
}
