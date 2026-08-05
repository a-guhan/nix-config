{ lib, pkgs, ... }:
{
  home.packages = lib.optionals pkgs.stdenv.hostPlatform.isLinux [ pkgs.ghostty.terminfo ];

  # Exposes host GPU drivers to Nix applications on non-NixOS Linux.
  targets.genericLinux.enable = pkgs.stdenv.hostPlatform.isLinux;
  programs.ghostty.enable = pkgs.stdenv.hostPlatform.isLinux;
}
