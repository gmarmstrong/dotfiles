{
  network.description = "Web server";

  webserver =
    { config, pkgs, ... }:
    {
      services.httpd.enable = true;
      services.httpd.adminAddr = "alice@example.org";
      services.httpd.documentRoot = "${pkgs.valgrind.doc}/share/doc/valgrind/html";
      networking.firewall.allowedTCPPorts = [ 80 ];
      system.stateVersion = "18.03";
    };
}
