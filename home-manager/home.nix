{ config, pkgs, nix-colors, nixpkgs,... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dani";

  imports = [
    ./modules/terminal
    ./modules/neovim
    ./modules/spotify.nix
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

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    polarity = "dark";
    image = "~/.config/wallpapers/astronaut.jpg";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.caskaydia-cove;
        name = "CaskaydiaCove Nerd Font";
      };
      sansSerif = {
        package = pkgs.ubuntu-sans;
        name = "Ubuntu";
      };
      serif = {
        package = pkgs.roboto-serif;
        name = "Roboto Serif";
      };
    };
  };


  # The home.packages option allows you to install Nix packages into your environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    ### Devtools
    rustup
    poetry
    ghc

    zulu8
    # zulu17

    packwiz
    mcrcon

    qmk

    ### Fonts
    nerd-fonts.caskaydia-cove
    nerd-fonts.martian-mono
    nerd-fonts.heavy-data
    nerd-fonts.agave
    nerd-fonts.jetbrains-mono
  ];

  home.file = {
    ".config/wallpapers" = {
      source = ./wallpapers;
      target = ".config/wallpapers";
    };
  };

  # Git configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Dandandooo";
    userEmail = "batkodanny@gmail.com";
  };
  programs.gh.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.

  # home.file = ...
  # home.sessionVariables = ...

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
