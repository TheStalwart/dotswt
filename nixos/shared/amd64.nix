# Defines x86_64-specific options
# that don't work for Raspberry Pi

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  programs.steam.enable = true;
  programs.steam.remotePlay.openFirewall = true;
  programs.steam.localNetworkGameTransfers.openFirewall = true;
  programs.steam.gamescopeSession.enable = true;

  hardware.intel-gpu-tools.enable = true;

  # Set default browser to MS Edge
  # https://unix.stackexchange.com/questions/379632/how-to-set-the-default-browser-in-nixos
  # *.desktop files for installed apps are in /run/current-system/sw/share/applications/
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.microsoft-edge}/bin/microsoft-edge";
  xdg.mime.defaultApplications = {
    "text/html" = "microsoft-edge.desktop";
    "x-scheme-handler/http" = "microsoft-edge.desktop";
    "x-scheme-handler/https" = "microsoft-edge.desktop";
    "x-scheme-handler/about" = "microsoft-edge.desktop";
    "x-scheme-handler/unknown" = "microsoft-edge.desktop";
  };

  environment.systemPackages = with pkgs; [
    discord
    spotify
    microsoft-edge
  ];
}
