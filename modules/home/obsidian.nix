{ lib, pkgs, ... }:
{
  xdg.desktopEntries.obsidian = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    name = "Obsidian";
    genericName = "Knowledge Base";
    comment = "Knowledge base";
    exec = "${pkgs.coreutils}/bin/env ELECTRON_DISABLE_SANDBOX=1 ${pkgs.obsidian}/bin/obsidian %u";
    icon = "${pkgs.obsidian}/share/icons/hicolor/512x512/apps/obsidian.png";
    terminal = false;
    categories = [ "Office" ];
    mimeType = [ "x-scheme-handler/obsidian" ];
  };
}
