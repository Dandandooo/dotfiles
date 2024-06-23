{ config, pkgs, nix-colors, ... }:

{
    imports = [
        ./shells.nix
        ./troll.nix
    ];

    home.packages = with pkgs; [
        ### Shells
        xonsh

        ### System information
        neofetch
        onefetch

        ### File Utility
        miller
        dust
        tree
        stow
        cloc
    ];
    
    home.file = {
        ".xonshrc".text = "execx($(starship init xonsh))";
    };

    home.sessionVariables = {
        PATH = ''
            /opt/homebrew/bin:$PATH
        '';
    };
}
