{ inputs, pkgs, ... }:

{

  imports = [
    inputs.ags.homeManagerModules.default
    # ./config
  ];

  # /*
  home.packages = with pkgs; [
    bun
    dart-sass
    fd
    swww
    inputs.matugen.packages.${system}.default
    fd
    brightnessctl
    adwaita-icon-theme
    gtk3
    slurp
    wf-recorder
    wl-clipboard
    wayshot
    swappy
    hyprpicker
    pavucontrol
  ];

  programs.ags = {
    enable = true;
    configDir = ./config;
    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
  # */
}
