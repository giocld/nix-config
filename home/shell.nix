{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tilt

    lazygit
    lazydocker
    fastfetch
    btop

    ffmpeg
    p7zip
    unzip
    gnumake
    fluidsynth
    bun

    fish
    eza
    starship
    fluidsynth
    soundfont-fluid
    wlr-randr
    fuzzel
  ];

  programs = {
    tmux = {
      enable = true;
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        resurrect
        continuum
        yank
        vim-tmux-navigator
      ];
      # The module-generated config (plugin run-shell lines, etc.) comes first;
      # the existing tmux.conf follows and overrides its defaults as needed.
      extraConfig = ''
        ${builtins.readFile ./files/.config/tmux/tmux.conf}
        # tmux-continuum: auto-save every 10 min, restore last session on server start
        set -g @continuum-save-interval '10'
        set -g @continuum-restore 'on'

        # tmux-resurrect: persist nvim sessions and background programs
        set -g @resurrect-strategy-nvim 'session'
        set -g @resurrect-processes '~~ btop fish'

        # tmux-yank: vi-style yank into system clipboard (wl-copy is auto-detected)
        set -g @shell_mode 'vi'

        # fzf session picker
        bind S display-popup -E -w 50% -h 60% "~/.local/bin/tmux-session-picker"
      '';
    };

    bat.enable = true;

    carapace = {
      enable = true;
      enableFishIntegration = true;
    };

    direnv = {
      enable = true;
      enableFishIntegration = true;
    };

    fzf.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
  };

  home.file = {
    ".config/fish/config.fish".source = ./files/.config/fish/config.fish;
    ".config/fish/conf.d/vague_theme.fish".source = ./files/.config/fish/conf.d/vague_theme.fish;
    ".config/starship/starship.toml".source = ./files/.config/starship/starship.toml;
    ".config/fastfetch/config.jsonc".source = ./files/.config/fastfetch/config.jsonc;
    ".config/fastfetch/logo.txt".source = ./files/.config/fastfetch/logo.txt;
    ".config/fuzzel/fuzzel.ini".source = ./files/.config/fuzzel/fuzzel.ini;
    ".local/bin/audio-menu" = {
      source = ./files/.local/bin/audio-menu;
      executable = true;
    };
    ".local/bin/tmux-session-picker" = {
      source = ./files/.local/bin/tmux-session-picker;
      executable = true;
    };
    ".local/bin/tmux-dev" = {
      source = ./files/.local/bin/tmux-dev;
      executable = true;
    };
  };
}
