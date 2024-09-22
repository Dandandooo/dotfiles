{ config, pkgs, inputs, ... }: let

  hyprPackages = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  pkgsUnstable = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};

in {
  imports = [
    ./workspaces.nix
    ./hyprpaper.nix
  ];

  nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };

  programs.hyprland = {
    enable = true;
    # Set package to the flake input
    package = hyprPackages.hyprland;
    portalPackages = hyprPackages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  hardware.opengl = {
    package = pkgsUnstable.mesa.drivers;

    # 32-bit support (e.g. for Steam)
    driSupport32Bit = true;
    package32Bit = pkgsUnstable.pkgsi686Linux.mesa.drivers;
  };


};
