{ config, pkgs, nix-colors, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dani";
  home.homeDirectory = "/home/dani";

  imports = [
    ./modules
    ./modules/linux
  ];

  home.packages = with pkgs; [
    # For fixing tModLoader
    dotnet-sdk_8
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.home-manager.enable = true;
}
