# Enables essential CLI tools

{ pkgs, ... }:

{
  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.variables = {
    NIXPKGS_ALLOW_UNFREE = "1";
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
  # $ nix search nixpkgs wget
  # or visit https://search.nixos.org/packages
  environment.systemPackages = with pkgs; [
    acpi
    btop
    # cope # unreliable on 25.11, fixed on unstable?
    dig
    fastfetch
    file
    geekbench
    inetutils
    lm_sensors
    mc
    nixfmt # previously used nixfmt-classic, but its output was inconsistent between VSCode and Zed
    nmap
    psmisc
    python311 # my other servers and workstations run 3.11
    tig
    unixtools.net-tools
    usbutils
    wget
  ];
}
