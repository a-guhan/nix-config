{
  perSystem = { pkgs, ... }: {
    devShells.default = pkgs.mkShell {
      name = "nix-hm-config";
      meta.description = "Shell environment for modifying this Nix configuration";
      packages = with pkgs; [
        just
        nixd
        nixfmt
        stylua
      ];
    };
  };
}
