{ pkgs, ... }: let
    size = "32";
in {
    stylix.cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
    };
    
    # change hyprland settings if necessary
};
