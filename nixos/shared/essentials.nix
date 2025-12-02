{ config, pkgs, ... }:

{
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Not enabled by default, even though some nixos utilities rely on it?
  programs.git.enable = true;

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  environment.systemPackages = with pkgs; [
    fastfetch
    file
    mc
    nixfmt-classic
    usbutils
    wget
  ];
}
