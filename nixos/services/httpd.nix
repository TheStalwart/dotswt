# Apache HTTPd configuration
# for debugging a legacy Wordpress site.

{
  services.httpd = {
    enable = true;
    enablePHP = true;
    user = "stalwart";

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
