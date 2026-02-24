# MySQLd service configuration for NixOS.
#
# User configuration is stateful,
# by default, unix root has full access without a password
# via UNIX socket.
#
# To create additional users, using `mycli` client:
# `CREATE USER 'username'@'%' IDENTIFIED BY 'password';`
# `GRANT ALL PRIVILEGES ON *.* TO 'username'@'%' WITH GRANT OPTION;`
# `FLUSH PRIVILEGES;`

{ pkgs, ... }:

{
  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      3306
    ];
  };

  environment.systemPackages = [ pkgs.mycli ];
}
