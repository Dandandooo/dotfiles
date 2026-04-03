{ config, pkgs, nixpkgs, inputs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dani";

  imports = [
    ./modules/terminal
    ./modules/neovim
    # ./modules/spotify.nix
    inputs.sops-nix.homeManagerModules.sops
  ];

  # The home.packages option allows you to install Nix packages into your environment.
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    ### Devtools
    # rustup # fails to build. fix later
    poetry
    ghc
    zig
    uv

    zulu8
    tailscale
    # zulu17
    dconf

    ### Minecraft
    prismlauncher
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
    scientifica
    (google-fonts.override { fonts = [ 
      "Fira Code"
      "Kablammo"
      "Lexend"
      "Modak"
      "Moiri"
      "Rajdhani"
      "Roboto"
      "Roboto Slab"
      "Rubik"
      "Rubik Puddles"
    ]; })
  ];


  home.file = {
    wallpapers = {
      source = ../raw/.config/wallpapers;
      target = ".config/wallpapers";
    };
    fonts = {
      source = ../raw/.config/fontconfig/fonts.conf;
      target = ".config/fontconfig/fonts.conf";
    };
  };

  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    defaultSopsFile = ./sops.yaml;
    defaultSopsFormat = "yaml";

    # FIXME: doesn't work yet

    # secrets.test = {
    #   path = "%r/test.txt";
    # };
  };

  # systemd.services."

  # Git configuration
  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      settings = {
        user.name = "Dandandooo";
        user.email = "batkodanny@gmail.com";
        credential.helper = "store";
      };
    };
    difftastic = {
      enable = true;
      git.enable = true;
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
        editor = "nvim";
      };
      gitCredentialHelper.enable = true;
    };
    gh-dash = {
      enable = true;
    };
  };

  programs.zed-editor.enable = true;

  home.sessionPath = [
    "/home/dani/.local/share/JetBrains/Toolbox/scripts"
  ];

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

