{ config, lib, pkgs, inputs,... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  programs.spicetify = {
    enable = true;
    theme = lib.mkDefault spicePkgs.themes.text;
    wayland = true;
    colorScheme = lib.mkDefault "CatppuccinMocha";
  };
}

