{ inputs, config, pkgs, lib, ...}:

{
  imports = [
    inputs.stylix.homeModules.stylix
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/oceanicnext.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine-moon.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    polarity = "dark";
    # image = "${config.home.homeDirectory}/.config/wallpapers/forest.jpg";
    image = ../../../raw/.config/wallpapers/rose_pine_contourline.png;

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

    targets = {
      hyprland.enable = false;
      hyprland.hyprpaper.enable = true;
      hyprpaper.enable = true;
      starship.enable = false;
    };
  };

  programs = {
    spicetify = {
      enable = true;
      # theme.name = "bloom";
      # theme.name = "text";

    };
  };

  services.hyprpaper.enable = true;
}
