{ config, ... }:
let
  keyDirectory = "${config.home.homeDirectory}/.local/share/home-manager-secrets/ssh";
in
{
  home.file = {
    ".ssh/a.guhan".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/id_ed25519_juspay";
    ".ssh/a.guhan.pub".source =
      config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/id_ed25519_juspay.pub";
    ".ssh/a.guhan_p".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/id_ed25519_github";
    ".ssh/a.guhan_p.pub".source =
      config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/id_ed25519_github.pub";
  };

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ServerAliveInterval = 60;
        ServerAliveCountMax = 3;
      };

      "ssh.bitbucket.juspay.net" = {
        HostName = "ssh.bitbucket.juspay.net";
        User = "git";
        IdentityFile = "~/.ssh/a.guhan";
        IdentitiesOnly = true;
      };

      "github.com" = {
        HostName = "github.com";
        User = "git";
        IdentityFile = "~/.ssh/a.guhan_p";
        IdentitiesOnly = true;
      };
    };
  };
}
