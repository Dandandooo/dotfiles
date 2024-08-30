{ config, pkgs, nix-colors, ... }:

{
  home.username = "dani";
  home.homeDirectory = "/Users/dani";

  imports = [
    ./modules
  ];

  home.packages = with pkgs; [
  ];

  # home.file = ...
  home.sessionVariables.PATH = "$PATH:/opt/homebrew/bin";


  home.stateVersion = "23.11";
  programs.home-manager.enable = true;
}
