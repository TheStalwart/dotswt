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

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  # or visit https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    ghostty
    gitkraken
    mangohud
    mesa-demos # glxgears etc.
    nil # Nix Language server for Zed Editor https://github.com/oxalica/nil
    nixd # Nix Language server for Zed Editor https://github.com/nix-community/nixd
    nvtopPackages.intel
    obsidian
    qdirstat
    tigervnc # x0vncserver, w0vncserver
    vscode.fhs
    xlsclients
    xlsfonts
    zed-editor
  ];
}
