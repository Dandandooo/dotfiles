{config, pkgs, inputs, ...}:

{

  imports = [
    ./ags
    ./hyprland
  ];


  home.packages = with pkgs; [
    conda
    clang

  ];

  home.sessionVariables = {
  };

  home.file = {
    # ".config/hypr" = {
      # source = ../../../.config/hypr;
      # target = ".config/hypr";
    # };
  };

}
