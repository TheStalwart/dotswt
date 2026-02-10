# Home Manager entry point
#
# https://home-manager-options.extranix.com/

{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  home-manager.users.stalwart = {
    home = {
      username = "stalwart";
      homeDirectory = "/home/stalwart";
      stateVersion = "26.05";
    };

    imports = [
      ./shell.nix
    ];
  };
}
