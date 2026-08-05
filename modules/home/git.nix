{ config, ... }:
{
  home.shellAliases.g = "git";

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
    ];
  };
}
