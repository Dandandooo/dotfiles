{ config, pkgs, nix-colors, ... }:

{
    imports = [
        ./shells.nix
        ./troll.nix
        ./starship.nix
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
        # ".config/kitty" = {
            # source = ./kitty;
            # target = ".config/kitty";
        # };
    };

    
    # This actually tanked my PC once
    # home.sessionVariables.Path = if builtins.currentSystem == "aarch64-darwin"
                                    # then "/opt/homebrew/bin:$PATH"
                                    # else "$PATH";

    home.sessionVariables = {

    };
}
