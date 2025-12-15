# Enables essential CLI tools

{ config, pkgs, ... }:

{
  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Not enabled by default, even though some nixos utilities rely on it?
  programs.git.enable = true;

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  programs.screen.enable = true;

  services.tailscale.enable = true;

  programs.command-not-found.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # or visit https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
    acpi
    btop
    # cope # unreliable on 25.11, fixed on unstable?
    fastfetch
    file
    geekbench
    inetutils
    lm_sensors
    mc
    nixfmt-classic
    nmap
    python311 # my other servers and workstations run 3.11
    tig
    usbutils
    wget
  ];
}
