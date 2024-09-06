{config, pkgs, inputs, ...}:

{

  imports = [
    ./ags
  ];


  home.packages = with pkgs; [
    conda
    clang

  ];

  home.sessionVariables = {
  };

}
