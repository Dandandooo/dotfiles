{ config, pkgs, nix-colors, ... }:

{
    # TODO: use nixvim

    programs.neovim.enable = true;

    home.sessionVariables = {
        EDITOR = "nvim";
    };
}
