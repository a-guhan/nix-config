{
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    let
      homeConfigurationCases = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: configuration: ''
          ${lib.escapeShellArg configuration.config.home.username})
            home_configuration=${lib.escapeShellArg name}
            ;;
        '') self'.legacyPackages.homeConfigurations
      );
    in
    {
      apps.default = {
        inherit (self'.packages.activate) meta;
        program = pkgs.writeShellApplication {
          name = "activate-home";
          text = ''
            if (( $# > 0 )); then
              echo "Usage: nix run" >&2
              exit 2
            fi

            current_user="$(id -un)"
            case "$current_user" in
              ${homeConfigurationCases}
              *)
                echo "No Home Manager configuration found for user: $current_user" >&2
                exit 1
                ;;
            esac

            set -x
            ${lib.getExe self'.packages.activate} "$home_configuration@"
          '';
        };
      };
    };
}
