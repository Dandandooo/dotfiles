{config, pkgs, inputs, ...}:

{

  home.homeDirectory = "/home/dani";

  imports = [
    ./ags
    # ./hyprland.nix
    ./stylix.nix
    ./waybar.nix
  ];


  home.packages = with pkgs; [
    conda
    clang

    dotnet-sdk_8
    amdgpu_top
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
    hyprland-config = {
      source = ../../../raw/.config/hypr/hyprland.conf;
      target = ".config/hypr/hyprland.conf";
    };
    hyprland-keybinds = {
      source = ../../../raw/.config/hypr/keybinds.conf;
      target = ".config/hypr/keybinds.conf";
    };
    prism-catppuccin = {
      source = pkgs.fetchzip {
        url = "https://github.com/PrismLauncher/Themes/releases/download/2025-06-06_1749223820/Catppuccin-Mocha-theme.zip";
        sha256 = "wJCz8NVfxwPpUM+DqeCBrych0DB/9GgDR3psBAE+/pc=";
      } + "/Catppuccin-Mocha";
      target = ".local/share/PrismLauncher/themes/Catppuccin-Mocha";
    };
    prism-kanagawa = {
      source = pkgs.fetchzip {
        url = "https://github.com/PrismLauncher/Themes/releases/download/2025-06-06_1749223820/Kanagawa-theme.zip";
        sha256 = "MV05AlnEh0tfSlZvoOgohH85djX+rkY/uTB4BtCaCEI=";
      } + "/Kanagawa";
      target = ".local/share/PrismLauncher/themes/Kanagawa";
    };
  };

}
