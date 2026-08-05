{ pkgs, ... }:
{
  home.packages = [ pkgs.tailscale ];

  systemd.user.services.tailscaled-secondary = {
    Unit = {
      Description = "Tailscale Secondary Daemon (Userspace)";
      After = [ "network.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p %h/.config/tailscale-guhan";
      ExecStart = "${pkgs.tailscale}/bin/tailscaled -tun=userspace-networking -socket=%h/.config/tailscale-guhan/tailscaled.sock -statedir=%h/.config/tailscale-guhan -socks5-server=127.0.0.1:1080 -port=41642";
      Restart = "always";
      RestartSec = 5;
    };

    Install.WantedBy = [ "default.target" ];
  };
}
