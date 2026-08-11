{
  pkgs,
  lib,
  config,
  capabilities,
  gitName,
  gitEmail,
  gitSigningKey,
  shellAliases ? { },
  managedDevice,
  ...
}:

let
  capabilitiesModule = import ./capabilities.nix { inherit pkgs lib managedDevice; };
  selectedPackages = capabilitiesModule.collectPackages capabilities;
  aiconfigDirectory = "${config.home.homeDirectory}/.local/share/aiconfig";
  codexSkillsDirectory = "${config.home.homeDirectory}/.codex/skills";
  hasAiCapability = lib.any (capability: lib.elem capability capabilities) [
    "cloud-ai"
    "local-ai"
  ];
in
{
  home = {
    packages = selectedPackages;

    file.".hushlogin".text = "";

    # Ghostty configuration
    file.".config/ghostty/config".text = ''
      # Ghostty configuration
      # See https://ghostty.org/docs/config for all options

      # Theme configuration
      # On macOS: automatically switches between light/dark themes based on system appearance
      # On Linux: defaults to dark theme
      theme = light:GitHub Light High Contrast,dark:GitHub Dark High Contrast

      # Font configuration
      font-family = DejaVu Sans Mono
      font-size = 14

      # Window padding
      window-padding-x = 10
      window-padding-y = 10

      # Un-comment to disable middle-mouse paste once Ghostty releases middle-click-action; it is currently only on tip:
      # https://github.com/ghostty-org/ghostty/pull/12478
      # middle-click-action = ignore

      # Keybindings
      keybind = global:cmd+slash=toggle_quick_terminal
    '';

    # https://nix-community.github.io/home-manager/options.xhtml#opt-home.shell.enableZshIntegration
    shell.enableZshIntegration = true;

    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/go/bin"
      "${config.home.homeDirectory}/dotfiles/scripts"
    ]
    ++ lib.optionals pkgs.stdenv.isDarwin [
      "/opt/homebrew/bin"
      "/opt/homebrew/sbin"
    ];

    sessionVariables = lib.mkIf (lib.elem "terraform" capabilities) {
      TF_PLUGIN_CACHE_DIR = "${config.home.homeDirectory}/.terraform.d/plugin-cache";
    };

    activation.installAiconfigSkills = lib.mkIf hasAiCapability (
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        set -euo pipefail

        git="${pkgs.git}/bin/git"
        aiconfig_dir="${aiconfigDirectory}"
        skills_dir="$aiconfig_dir/skills"
        codex_skills_dir="${codexSkillsDirectory}"

        if [ -d "$aiconfig_dir/.git" ]; then
          run "$git" -C "$aiconfig_dir" pull --ff-only
        elif [ -e "$aiconfig_dir" ]; then
          echo "Skipping aiconfig clone: $aiconfig_dir exists but is not a git repository" >&2
        else
          run "$git" clone https://github.com/gmarmstrong/aiconfig.git "$aiconfig_dir"
        fi

        if [ -d "$skills_dir" ]; then
          run mkdir -p "$codex_skills_dir"

          for skill_dir in "$skills_dir"/*; do
            [ -d "$skill_dir" ] || continue

            skill_name="$(basename "$skill_dir")"
            case "$skill_name" in
              _*) continue ;;
            esac

            target="$codex_skills_dir/$skill_name"
            if [ -L "$target" ]; then
              current_target="$(readlink "$target")"
              if [ "$current_target" != "$skill_dir" ]; then
                run ln -sfn "$skill_dir" "$target"
              fi
            elif [ -e "$target" ]; then
              echo "Skipping aiconfig skill '$skill_name': $target already exists and is not a symlink" >&2
            else
              run ln -s "$skill_dir" "$target"
            fi
          done
        fi
      ''
    );
  };

  programs = {
    git = {
      enable = true;
      userName = gitName;
      userEmail = gitEmail;
      signing = {
        format = "ssh";
        key = gitSigningKey;
        signByDefault = true;
      }
      // lib.optionalAttrs pkgs.stdenv.isDarwin {
        signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      };
      extraConfig = {
        pull.rebase = true;
      };
    };

    ssh = {
      enable = true;
      extraConfig = ''
        ${lib.optionalString managedDevice "Include ${config.home.homeDirectory}/.sdm/ssh_config"}
      '';
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
      matchBlocks."*" = {
        identityAgent = ''"${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'';
      };
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        vim-characterize
        vim-surround
        vim-repeat
      ];
      extraConfig = ''
        colorscheme vim
        set expandtab
        set tabstop=4
        set shiftwidth=4
        set softtabstop=4
        inoremap jk <Esc>
      '';
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };

    zsh = {
      enable = true;
      inherit shellAliases;
      defaultKeymap = "viins";
      historySubstringSearch = {
        enable = true;
      };
      localVariables = {
        HISTORY_SUBSTRING_SEARCH_PREFIXED = true;
      };
      # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.zsh.initContent
      initContent = ''
        bindkey jk vi-cmd-mode
        bindkey -M viins '^?' backward-delete-char
        bindkey -M vicmd 'k' history-substring-search-up
        bindkey -M vicmd 'j' history-substring-search-down
        zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

        # Git prompt with dirty indicator
        autoload -Uz vcs_info
        precmd_vcs_info() { vcs_info }
        precmd_functions+=( precmd_vcs_info )
        setopt prompt_subst
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' unstagedstr '*'
        zstyle ':vcs_info:*' stagedstr '*'
        zstyle ':vcs_info:git:*' formats ' (%b%u%c)'
        zstyle ':vcs_info:git:*' actionformats ' (%b%u%c %a)'
        PROMPT='%~''${vcs_info_msg_0_} %# '
      '';
    };
  };

  targets.darwin.defaults = lib.mkIf pkgs.stdenv.isDarwin {
    "com.apple.controlcenter" = {
      BatteryShowPercentage = true;
      Sound = true;
    };
    "com.apple.menuextra.clock" = {
      ShowAMPM = true;
      ShowDate = 1;
      ShowDayOfWeek = true;
      ShowSeconds = true;
    };
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      "com.apple.mouse.tapBehavior" = 1;
    };
    "com.apple.finder" = {
      NewWindowTarget = "Home";
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
      _FXSortFoldersFirst = true;
    };
    "com.apple.AppleMultitouchTrackpad" = {
      ActuationStrength = 0;
      Clicking = true;
    };
  };

  services.ollama.enable = pkgs.stdenv.isDarwin && lib.elem "local-ai" capabilities;
}
