{ config, pkgs, nix-colors, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dani";
  home.homeDirectory = "/Users/dani";

  imports = [

  ];

  # colorScheme = nix-colors.colorSchemes.gruvbox-light-medium;
  # colorScheme = nix-colors.colorSchemes.gruvbox-light-soft;
  # colorScheme = nix-colors.colorSchemes.oxocarbon-light;

  # colorScheme = nix-colors.colorSchemes.atlas;
  # colorScheme = nix-colors.colorSchemes.bespin;
  # colorScheme = nix-colors.colorSchemes.dracula;
  # colorScheme = nix-colors.colorSchemes.gruvbox-dark-medium;
  # colorScheme = nix-colors.colorSchemes.gruvbox-dark-pale;
  # colorScheme = nix-colors.colorSchemes.gruvbox-dark-soft;
  # colorScheme = nix-colors.colorSchemes.kanagawa;
  # colorScheme = nix-colors.colorSchemes.monokai;
  # colorScheme = nix-colors.colorSchemes.oxocarbon-dark;
  # colorScheme = nix-colors.colorSchemes.papercolor-dark;
  # colorScheme = nix-colors.colorSchemes.rose-pine;
  # colorScheme = nix-colors.colorSchemes.rose-pine-moon;

  # The home.packages option allows you to install Nix packages into your environment.
  home.packages = with pkgs; [
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    ### Shells
    xonsh

    ### System information
    fastfetch
    neofetch
    onefetch
    btop

    ### Version control
    git-lfs
    gh

    ### Productivity
    zellij
    tmux

    ### File Utility
    miller
    dust
    tree
    stow
    cloc
    bat

    ### Fonts
    nerdfonts
    # (nerdfonts.override { fonts = [ "MartianMono" "CascadiaCode" "HeavyData" "Hack" "Agave" ]; })

    ### Misc troll packages
    asciiquarium
    fortune
    nyancat
    cmatrix
    cbonsai
    cowsay
    lolcat
    figlet
    pipes
    sl
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "Dandandooo";
    userEmail = "batkodanny@gmail.com";
  };

  ##############################
  #          Shells            #
  ##############################
  programs.fish = {
    enable = true;
    interactiveShellInit = ''set fish_greeting "⋉( ⊂ ´◕ ᴥ ◕`)"'';
    plugins = [
      { name="done"; src=pkgs.fishPlugins.done.src; }
      { name="sponge"; src=pkgs.fishPlugins.sponge.src; }
      { name="colored-man-pages"; src=pkgs.fishPlugins.colored-man-pages.src; }
    ];
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
    $env.config = {
      show_banner: false,
    }'';
  };

  programs.starship.enable = true;
  programs.zoxide.enable = true;
  programs.thefuck.enable = true;

  ##############################
  #          Editors           #
  ##############################
  programs.neovim = {
    enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".xonshrc".text = "execx($(starship init xonsh))";
  };


  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dani/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };



  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
