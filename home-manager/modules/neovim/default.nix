{ config, pkgs, nix-colors, ... }:

{
    # TODO: use nixvim

    programs.neovim.enable = true;

    # home.file.".config/nvim" = {
        # source = ../../../.config/nvim;
        # target = ".config/nvim";
    # };

    home.sessionVariables = {
        EDITOR = "nvim";
    };
}
