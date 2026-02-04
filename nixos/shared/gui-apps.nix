# Defines desired GUI Apps

# Requires NixOS 25.11, upgrade from 25.05 with the following commands:
#   nix-channel --add https://channels.nixos.org/nixos-25.11 nixos
#   nixos-rebuild switch --upgrade-all
# Or go straight to NixOS Unstable:
#   nix-channel --add https://channels.nixos.org/nixos-unstable nixos
#   nixos-rebuild switch --upgrade-all

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  # KDE Apps
  programs.partition-manager.enable = true;

  programs.firefox.enable = true;
  programs.thunderbird.enable = true;

  # https://nixos.wiki/wiki/Visual_Studio_Code
  # https://discourse.nixos.org/t/vscode-extensions-dont-work-anymore-since-25-05/64784/4
  # https://nixos.org/guides/nix-pills/11-garbage-collector.html
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscode.fhs; # this property doesn't seem to work, so i install FHS version via systemPackages below
  # };
  # Make VSCode use Wayland instead of X11
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Set default terminal emulator to Ghostty
  # *.desktop files for installed apps are in /run/current-system/sw/share/applications/
  # COSMIC resolves default terminal via xdg-mime
  # https://github.com/pop-os/cosmic-settings/blob/master/cosmic-settings/src/pages/applications/default_apps.rs
  # However, there seems to be a bug,
  # as cosmic-settings recognizes Ghostty as "Terminal Emulator" but
  # super+t shortcut still launches cosmic-term, unless i reselect Ghostty
  # in Settings > Default Applications > Terminal
  xdg.mime.defaultApplications = {
    "x-scheme-handler/terminal" = "com.mitchellh.ghostty.desktop";
    "application/x-terminal-emulator" = "com.mitchellh.ghostty.desktop";
  };

  # Set default browser to Ablaze Floorp
  # MS Edge is x86_64 only and has too many UI bugs on Linux
  # https://unix.stackexchange.com/questions/379632/how-to-set-the-default-browser-in-nixos
  # *.desktop files for installed apps are in /run/current-system/sw/share/applications/
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.floorp-bin}/bin/floorp";
  xdg.mime.defaultApplications = {
    "text/html" = "floorp.desktop";
    "x-scheme-handler/http" = "floorp.desktop";
    "x-scheme-handler/https" = "floorp.desktop";
    "x-scheme-handler/about" = "floorp.desktop";
    "x-scheme-handler/unknown" = "floorp.desktop";
  };

  # Steam is x86_64 only
  # (hopefully we get native arm64 support after Steam Frame is released in 2026)
  programs.steam.enable = pkgs.stdenv.hostPlatform.isx86_64;
  programs.steam.remotePlay.openFirewall = pkgs.stdenv.hostPlatform.isx86_64;
  programs.steam.localNetworkGameTransfers.openFirewall = pkgs.stdenv.hostPlatform.isx86_64;
  programs.steam.gamescopeSession.enable = pkgs.stdenv.hostPlatform.isx86_64;

  hardware.intel-gpu-tools.enable = pkgs.stdenv.hostPlatform.isx86;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget # requires >8GB RAM
  # or visit https://search.nixos.org/packages
  environment.systemPackages =
    with pkgs;
    [
      bitwarden-desktop
      floorp-bin
      ghostty
      mangohud
      mesa-demos # glxgears etc.
      nil # Nix Language server for Zed Editor https://github.com/oxalica/nil
      nixd # Nix Language server for Zed Editor https://github.com/nix-community/nixd
      nvtopPackages.intel
      obsidian
      qdirstat
      tigervnc # x0vncserver, w0vncserver
      vivaldi
      vivaldi-ffmpeg-codecs
      vscode.fhs
      xlsclients
      xlsfonts
      zed-editor
    ]
    ++ lib.optionals pkgs.stdenv.hostPlatform.isx86_64 [
      # Isn't it funny how this list is exclusively apps written in "portable" CEF/Electron?
      discord
      gitkraken
      microsoft-edge
      spotify
    ];
}
