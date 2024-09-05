{config, pkgs, inputs, ...}:

{

  imports = [
    # ./ags
  ];


  home.packages = with pkgs; [
    conda
    clang

    # For fixing tModLoader
    # dotnet-sdk_8
  ];

  home.sessionVariables = {
    # DOTNET_ROOT = "${pkgs.dotnet-sdk_8}";
  };

}
