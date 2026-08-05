{
  flake,
  ...
}:
let
  inherit (flake.inputs) self;
in
{
  imports = [ self.homeModules.default ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11";
}
