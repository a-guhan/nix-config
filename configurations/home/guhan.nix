{
  flake,
  lib,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
    inputs.kolu.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;

  services.kolu = {
    enable = true;
    package = inputs.kolu.packages.${pkgs.stdenv.hostPlatform.system}.default;
    allowedOrigins = [
      "https://arun-kumar-2n082lqb76tt.tail4a5cd7.ts.net"
      "https://arun-kumar-2n082lqb76tt.tail09dcc0.ts.net"
    ];
  };

  systemd.user.services.kolu.Install.WantedBy = lib.mkForce [ ];

  home.stateVersion = "24.11";
}
