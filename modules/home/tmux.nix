{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    plugins = [ pkgs.tmuxPlugins.resurrect ];
    mouse = true;
    historyLimit = 100000;
    extraConfig = ''
      set -s set-clipboard on
      setw -g mode-keys vi
      bind-key p display-popup #{pane_current_path} -w 50% -h 50% -E
      bind-key C command-prompt -p "Session name:" "new-session -A -s '%%'"
      bind-key s choose-tree -Zs
      bind-key R command-prompt -I "#S" "rename-session '%%'"
    '';
  };
}
