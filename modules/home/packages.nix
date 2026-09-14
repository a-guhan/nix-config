{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
    pkgs.codex
    pkgs.pi-coding-agent
    pkgs.hurl
    pkgs.zoxide
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.nixfmt
    pkgs.stylua
    pkgs.herdr
    pkgs.podman
    pkgs.podman-compose
  ];
}
