{
  flake,
  pkgs,
  lib,
  ...
}:
let
  initContent = lib.optionalString pkgs.stdenv.isDarwin ''
    ulimit -s 65500
  '';
in
{
  home.packages = [
    flake.inputs.vertex.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs = {
    bash.initExtra = initContent;
    zsh = {
      inherit initContent;
    };

    starship.settings.gcloud.disabled = true;
  };
}
