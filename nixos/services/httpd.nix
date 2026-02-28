# Apache HTTPd configuration
# for debugging a legacy Wordpress site.

{ pkgs, ... }:

{
  services.httpd = {
    enable = true;
    user = "stalwart";

    enablePHP = true;
    phpPackage = pkgs.php.buildEnv {
      extraConfig = ''
        log_errors=1
        memory_limit=512M
      '';
    };

    virtualHosts = {
      localhost = {
        documentRoot = "/home/stalwart/htdocs";
        locations = {
          "/" = {
            extraConfig = ''
              Require all granted
              DirectoryIndex index.php index.html
              Options Indexes FollowSymLinks
              AllowOverride All
            '';
          };
        };
      };
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80
      443
    ];
  };
}
