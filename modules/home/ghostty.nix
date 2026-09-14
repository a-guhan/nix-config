{
  config,
  lib, pkgs,
  ...
}:
{
  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.ghostty.terminfo ];
  home.sessionVariables.TERMINFO_DIRS = lib.mkIf pkgs.stdenv.hostPlatform.isLinux (
    "${config.home.profileDirectory}/share/terminfo:/etc/terminfo:/lib/terminfo:/usr/share/terminfo"
  );

  # Exposes host GPU drivers to Nix applications on non-NixOS Linux.
  targets.genericLinux.enable = pkgs.stdenv.hostPlatform.isLinux;
  programs.ghostty.enable = pkgs.stdenv.hostPlatform.isLinux;
}
