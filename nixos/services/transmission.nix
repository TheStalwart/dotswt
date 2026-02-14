{
  services.transmission.enable = true;
  services.transmission.openRPCPort = true;
  services.transmission.openFirewall = true;
  services.transmission.settings = {
    # https://github.com/transmission/transmission/blob/main/docs/Editing-Configuration-Files.md
    rpc-bind-address = "0.0.0.0";
    rpc-whitelist = "127.0.0.1,100.65.82.111"; # Whitelist Blackout over Tailscale
  };
}
