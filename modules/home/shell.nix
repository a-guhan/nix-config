{
  config,
  lib,
  pkgs,
  ...
}:
let
  secretsFile = "${config.home.homeDirectory}/.local/share/home-manager-secrets/shell/opencode.env";
  loadSecrets = ''
    if [[ -r ${secretsFile} ]]; then
      source ${secretsFile}
    fi
  '';
  stackLimit = lib.optionalString pkgs.stdenv.isDarwin ''
    ulimit -s 65500
  '';
in
{
  home.shellAliases.tailscale2 = ''tailscale --socket="$HOME/.config/tailscale-guhan/tailscaled.sock"'';

  programs = {
    bash = {
      enable = true;
      initExtra = loadSecrets + stackLimit;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      enableCompletion = true;
      # Add ~/.local/bin to PATH so your ad-hoc scripts (like terminal-browser)
      # are available. envExtra runs early in .zshenv (right after HM session vars).
      envExtra = loadSecrets + ''
        export PATH="$HOME/.local/bin:$PATH"
      '';
      initContent = stackLimit;
    };

    zoxide.enable = true;

    fzf = {
      enable = true;
      colors = {
        fg = "-1";
        bg = "-1";
        hl = "230";
        "fg+" = "3";
        "bg+" = "233";
        "hl+" = "229";
      };
    };

    starship = {
      enable = true;
      settings = {
        username = {
          style_user = "blue bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          ssh_symbol = "🌐 ";
          format = "on [$hostname](bold red) ";
          trim_at = ".local";
          disabled = false;
        };
      };
    };
  };
}
