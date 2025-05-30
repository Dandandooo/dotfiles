{config, pkgs, inputs, ...}:

{

  home.homeDirectory = "/home/dani";

  imports = [
    ./ags
    # ./hyprland.nix
    ./stylix.nix
  ];


  home.packages = with pkgs; [
    conda
    clang

    dotnet-sdk_8
  ];

  home.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
  };

  home.file = {
    # ".config/hypr" = {
    #   source = ../../../raw/.config/hypr;
    #   target = ".config/hypr";
    # };
    # Hyprpaper managed separately
    "hyprland-config" = {
      source = ../../../raw/.config/hypr/hyprland.conf;
      target = ".config/hypr/hyprland.conf";
    };
    "hyprland-keybinds" = {
      source = ../../../raw/.config/hypr/keybinds.conf;
      target = ".config/hypr/keybinds.conf";
    };
  };

}
