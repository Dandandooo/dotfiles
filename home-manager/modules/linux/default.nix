{config, pkgs, inputs, ...}:

{

  home.homeDirectory = "/home/dani";

  imports = [
    ./ags
    # ./hyprland.nix
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
    ".config/hypr" = {
      source = ../../../raw/.config/hypr;
      target = ".config/hypr";
    };
  };

}
