{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
    pkgs.codex
    pkgs.pi-coding-agent
    pkgs.hurl
    pkgs.zoxide
    pkgs.nixfmt
    pkgs.stylua
  ];
}
