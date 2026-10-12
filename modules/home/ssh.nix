{ config, lib, pkgs, ... }:
let
  keyDirectory = "${config.home.homeDirectory}/.local/share/home-manager-secrets/ssh";
in
{
  home.file = {
    ".ssh/a.guhan".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/a.guhan";
    ".ssh/a.guhan.pub".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/a.guhan.pub";
    ".ssh/a.guhan_p".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/a.guhan_p";
    ".ssh/a.guhan_p.pub".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/a.guhan_p.pub";
    ".ssh/guhan".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/guhan";
    ".ssh/guhan.pub".source = config.lib.file.mkOutOfStoreSymlink "${keyDirectory}/guhan.pub";
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

      "pc-bangalore" = {
        User = "guhan";
        HostName = "100.71.105.37";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/control-%h-%p-%r";
        ControlPersist = "no";
        ExitOnForwardFailure = false;
        IdentityFile = "~/.ssh/guhan";
        LogLevel = "QUIET";
        ConnectTimeout = 10;
        Compression = true;
        IPQoS = "lowdelay";
        Ciphers = [
          "aes128-ctr"
          "aes192-ctr"
          "aes256-ctr"
        ];
        MACs = [
          "hmac-sha2-512"
          "hmac-sha2-256"
          "hmac-sha1"
        ];
      };
    };
  };

  # nixos-unified preserves replaced files as timestamped backups. These
  # backups are redundant for the SSH config and key links managed above.
  home.activation.cleanupSshBackups = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${pkgs.findutils}/bin/find "$HOME/.ssh" \
      -maxdepth 1 \
      -type f \
      -name '*.nixos-unified.*.bak' \
      -delete
  '';
}
