{ config, ... }:
{
  home.shellAliases.g = "git";

  # Keep Git's legacy config path as a direct mirror of the Home Manager-managed
  # XDG config so no unmanaged ~/.gitconfig can override these settings.
  home.file.".gitconfig" = {
    force = true;
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/config";
  };

  programs.git = {
    enable = true;
    ignores = [
      "*~"
      "*.swp"
    ];
    settings = {
      user = {
        name = config.me.fullname;
        email = config.me.email;
      };
      alias.ci = "commit";
    };
    includes = [
      {
        condition = "gitdir:~/juspay/";
        contents.user = {
          name = config.me.fullname;
          email = config.me.juspayEmail;
        };
      }
      {
        condition = "gitdir:**/works/**";
        contents.user = {
          name = "Guhan";
          email = "a.guhan@proton.me";
        };
      }
    ];
  };
}
