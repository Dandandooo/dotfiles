{ config, pkgs, nix-colors, ... }:

{

    programs.neovim.enable = true;

    home.sessionVariables = {
        EDITOR = "nvim";
    };
}
