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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    btop
    fastfetch
    file
    geekbench
    mc
    nixfmt-classic
    usbutils
    wget
  ];
}
