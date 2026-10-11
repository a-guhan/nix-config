{ pkgs, ... }:
{
  home.packages = [
    pkgs.opencode
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
    # Dadbod shells out to psql/mysql; these packages do not enable or run
    # database servers. Nixpkgs currently does not split PostgreSQL's psql
    # client into a separate package, while MySQL's client is provided by
    # MariaDB's compatible client package.
    pkgs.postgresql
    pkgs.mariadb.client
  ];
}
