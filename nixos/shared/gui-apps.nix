# Defines desired GUI Apps

# Requires NixOS 25.11, upgrade from 25.05 with the following commands:
#   nix-channel --add https://channels.nixos.org/nixos-25.11 nixos
#   nixos-rebuild switch --upgrade-all
# Or go straight to NixOS Unstable:
#   nix-channel --add https://channels.nixos.org/nixos-unstable nixos
#   nixos-rebuild switch --upgrade-all

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

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget
  # or visit https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
    bitwarden-desktop
    mesa-demos # glxgears etc.
    nil # Nix Language server for Zed Editor https://github.com/oxalica/nil
    nixd # Nix Language server for Zed Editor https://github.com/nix-community/nixd
    nvtopPackages.intel
    obsidian
    qdirstat
    vscode.fhs
    xlsclients
    xlsfonts
    zed-editor
  ];
}
