{ inputs, config, pkgs, lib, ...}:

{
  imports = [
    inputs.stylix.homeModules.stylix
    ./spicetify.nix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/hopscotch.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/caroline.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/terracotta-dark.yaml";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    # base16Scheme = {
    #
    # };
    polarity = "dark";
    # image = ../../../raw/.config/wallpapers/rose_pine_contourline.png;
    # image = ../../../raw/.config/wallpapers/astronaut.jpg;
    image = ../../../raw/.config/wallpapers/Cloudsnight.jpg;

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

      starship.enable = true;
      spicetify.enable = true;
      kitty.variant256Colors = true;
      waybar.addCss = false;
      firefox.profileNames = [ "default" ];
      firefox.colorTheme.enable = true;
    };
  };

  programs = {
    firefox = {
      enable = true;
      profiles.default.extensions.force = true;
    };
    vesktop.enable = true;
  };
  services.hyprpaper.enable = true;
  services.dunst = {
    enable = true;
    settings = {
      global = {
        "corner_radius" = 20;
      };
    };
  };
}
