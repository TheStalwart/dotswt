# Enables essential CLI tools

# Include this file in /etc/nixos/configuration.nix imports section
# and run `nixos-rebuild switch --upgrade-all` to sync system state

{ pkgs, ... }:

{
  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # I use latest kernel on all machines,
  # including Raspberry Pi 4B.
  # Other kernel branches are documented
  # in the following files:
  # - https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/linux-kernels.nix
  # - https://github.com/NixOS/nixpkgs/blob/master/pkgs/top-level/aliases.nix
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Bootloader.
  boot.loader.systemd-boot.enable = pkgs.stdenv.hostPlatform.isx86_64;
  boot.loader.efi.canTouchEfiVariables = pkgs.stdenv.hostPlatform.isx86_64;
  # Cap old NixOS generations
  # https://hugosum.com/blog/how-to-avoid-too-many-old-nixos-generations
  boot.loader.systemd-boot.configurationLimit = 10; # only 10 generations are kept
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # Not enabled by default, even though some nixos utilities rely on it?
  programs.git = {
    enable = true;
    config.user = {
      name = "Pavel Shevchuk";
      email = "stlwrt@gmail.com";
    };
  };

  programs.lazygit.enable = true;

  programs.vim.enable = true;
  programs.vim.defaultEditor = true;

  programs.screen.enable = true;

  services.tailscale.enable = true;
  # Tailscale MagicDNS breaks on NixOS system after resume
  # https://github.com/tailscale/tailscale/issues/4254
  services.resolved.enable = true;

  programs.command-not-found.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search nixpkgs wget # requires >8GB RAM
  # or visit https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
    acpi
    btop
    # cope # unreliable on 25.11, fixed on unstable?
    dig
    fastfetch
    file
    geekbench
    htop
    inetutils
    lm_sensors
    mc
    nixfmt # previously used nixfmt-classic, but its output was inconsistent between VSCode and Zed
    nmap
    psmisc
    python311 # my other servers and workstations run 3.11
    ripgrep
    speedtest-cli
    sysstat # iostat
    tig
    tree
    unixtools.net-tools
    usbutils
    wget
  ];
}
