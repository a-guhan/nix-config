{ pkgs, ... }:
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
    # nvim-treesitter (main branch) shells out to the `tree-sitter` CLI
    # (`tree-sitter build`) and a C compiler to build parsers. Put them on
    # Neovim's PATH so parser installs don't fail with ENOENT.
    extraWrapperArgs = [
      "--prefix"
      "PATH"
      ":"
      (pkgs.lib.makeBinPath [
        pkgs.tree-sitter
        pkgs.clang
      ])
    ];
  };
}
