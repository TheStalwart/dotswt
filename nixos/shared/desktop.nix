# Defines desired GUI Desktop Environment configuration

# Requires NixOS 25.11, upgrade from 25.05 with the following commands:
#   nix-channel --add https://channels.nixos.org/nixos-25.11 nixos
#   nixos-rebuild switch --upgrade-all

{ config, pkgs, ... }:

{
  # Enable NetworkManager for GUI setups
  networking.networkmanager.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # KDE Apps
  programs.partition-manager.enable = true;

  programs.firefox.enable = true;

  # https://nixos.wiki/wiki/Visual_Studio_Code
  # https://discourse.nixos.org/t/vscode-extensions-dont-work-anymore-since-25-05/64784/4
  # https://nixos.org/guides/nix-pills/11-garbage-collector.html
  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscode.fhs; # this property doesn't seem to work, so i install FHS version via systemPackages below
  # };
  # Make VSCode use Wayland instead of X11
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.steam.enable = true;

  hardware.intel-gpu-tools.enable = true;

  # https://wiki.nixos.org/wiki/Fonts
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [ corefonts vista-fonts twemoji-color-font ];
    fontconfig = {
      defaultFonts = {
        serif = [ "Liberation Serif" ];
        sansSerif = [ "Liberation Sans" ];
        monospace = [ "Liberation Mono" ];
        emoji = [ "Twemoji" ];
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # or visit https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
    discord
    mesa-demos
    microsoft-edge
    nvtopPackages.intel
    qdirstat
    vscode.fhs
    xlsclients
  ];
}
