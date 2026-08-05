{
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    {
      apps.default = {
        inherit (self'.packages.activate) meta;
        program = pkgs.writeShellApplication {
          name = "activate-home";
          text = ''
            start_kolu=false

            while (( $# > 0 )); do
              case "$1" in
                --kolu)
                  start_kolu=true
                  ;;
                *)
                  echo "Unknown argument: $1" >&2
                  echo "Usage: nix run -- [--kolu]" >&2
                  exit 2
                  ;;
              esac
              shift
            done

            if ! $start_kolu; then
              ${lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
                ${pkgs.systemd}/bin/systemctl --user stop kolu.service 2>/dev/null || true
              ''}
            fi

            set -x
            ${lib.getExe self'.packages.activate} "$(id -un)"@

            if $start_kolu; then
              ${lib.optionalString pkgs.stdenv.hostPlatform.isLinux ''
                ${pkgs.systemd}/bin/systemctl --user start kolu.service
              ''}
            fi
          '';
        };
      };
    };
}
