{ config, lib, ... }:
{
  options.me = {
    username = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Local account name";
    };
    fullname = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Git author name";
    };
    email = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Default Git email";
    };
    juspayEmail = lib.mkOption {
      type = lib.types.nonEmptyStr;
      description = "Git email for repositories under ~/juspay";
    };
  };

  config = {
    me = {
      username = "guhan";
      fullname = "A Guhan";
      email = "a.guhan@proton.me";
      juspayEmail = "a.guhan@juspay.in";
    };
    home.username = config.me.username;
  };
}
