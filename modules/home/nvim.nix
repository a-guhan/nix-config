{ ... }:
let
  configRoot = ../../nvimConfig;
in
{
  xdg.configFile."nvim/lua".source = configRoot + "/lua";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    initLua = builtins.readFile (configRoot + "/init.lua");
    withRuby = false;
    withPython3 = false;
  };
}
