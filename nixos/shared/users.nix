# Define the standard set of users.

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{
  users.users.stalwart = {
    isNormalUser = true;
    description = "Stalwart";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
