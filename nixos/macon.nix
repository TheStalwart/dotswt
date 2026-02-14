# NixOS Incus image is broken on TrueNAS out of box.
# `nix-channel --update` will fail with the error:
# "this system does not support the kernel namespaces that are required for sandboxing;"
#
# To fix it:
# - Stop the container
# - Open System -> Shell in TrueNAS Web Interface
#   - `sudo -i`
#   - `incus config set CONTAINERNAME security.nesting=true`
# - Start the container
# - Edit /etc/nixos/configuration.nix, set `nix.settings.sandbox = false;`
# - `nix-channel --update`
# - `nixos-rebuild switch --upgrade-all`
# - Stop the container
# - Open System -> Shell
#   - `sudo -i`
#   - `incus config unset CONTAINERNAME security.nesting`
# - Start the container
#
# TrueNAS Incus dashboard opens "Container Shell" in a broken state.
# Execute `su -` to evaluate all configuration files properly.

{ config, pkgs, ... }:

{
  services.httpd.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
  };
}
