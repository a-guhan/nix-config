{
  flake,
  pkgs,
  ...
}:
{
  home.packages = [
    flake.inputs.vertex.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  programs.starship.settings.gcloud.disabled = true;
}
