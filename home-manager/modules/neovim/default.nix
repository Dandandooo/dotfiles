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
        # reuse home-manager's pkgs (same nixpkgs via follows, and inherits allowUnfree)
        nixpkgs.useGlobalPackages = true;

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
