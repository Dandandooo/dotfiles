{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    conda

    # For fixing tModLoader
    dotnet-sdk_8
  ];

}
