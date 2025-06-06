{ config, pkgs, nixpkgs, stylix, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dani";

  imports = [
    ./modules/terminal
    ./modules/neovim
    ./modules/spotify.nix
  ];

  # colorScheme = nix-colors.colorSchemes.gruvbox-light-medium; colorScheme = nix-colors.colorSchemes.gruvbox-light-soft;
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
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    ### Devtools
    rustup
    poetry
    ghc
    uv

    zulu8
    # zulu17

    ### Minecraft
    packwiz
    mcrcon

    qmk

    ### Fonts
    nerd-fonts.proggy-clean-tt
    nerd-fonts.caskaydia-cove
    nerd-fonts.jetbrains-mono
    nerd-fonts.recursive-mono
    nerd-fonts.martian-mono
    nerd-fonts.ubuntu-mono
    nerd-fonts.heavy-data
    nerd-fonts.space-mono
    nerd-fonts.monaspace
    nerd-fonts.profont
    nerd-fonts.hurmit
    nerd-fonts.agave
  ];

  home.file = {
    ".config/wallpapers" = {
      source = ../raw/.config/wallpapers;
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

