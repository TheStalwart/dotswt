# Defines font configuration to be used in GUI
# https://wiki.nixos.org/wiki/Fonts

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Microsoft Fonts
      # https://www.reddit.com/r/NixOS/comments/15wvv2y/microsoft_fonts/
      corefonts # Andalé Mono, Arial, Arial Black, Comic Sans MS, Courier New, Georgia, Impact, Times New Roman, Trebuchet MS,Verdana, Webdings
      vista-fonts # Calibri, Cambria, Candara, Consolas, Constantia, Corbel
    ];
  };
}
