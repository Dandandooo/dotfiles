{ inputs, config, pkgs, nix-colors, lib, ... }:

{
    # TODO: use nixvim

    imports = [
        inputs.nixvim.homeModules.nixvim
        ./plugins.nix
        ./keymaps.nix
        ./lsp.nix
        ./colorschemes.nix
    ]; # ++ lib.optional (pkgs.system != "x86-64_linux") ./colorshemes.nix;

    # programs.neovim.enable = false;

    # home.file.".config/nvim" = {
        # source = ../../../.config/nvim;
        # target = ".config/nvim";
    # };

    programs.nixvim = {
        enable = true;
        # we follow our own nixpkgs in flake.nix; make that explicit to silence the warning
        nixpkgs.source = inputs.nixpkgs;

        opts = {
            smarttab = true;
            expandtab = true;
            sw = 4;
            sts = 4;

            nu = true;
            so = 4;

            termguicolors = true;
        };
        
    };

    home.sessionVariables = {
        EDITOR = "nvim";
    };
}
