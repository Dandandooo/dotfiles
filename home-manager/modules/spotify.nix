{ config, fetchgit, pkgs, ... }:

{

    home.packages = with pkgs; [
        spotify
        spicetify-cli
    ];

    home.file.".config/spicetify/Themes" = {
        source = fetchgit {
            url = "https://github.com/spicetify/spicetify-themes.git";
            # hash = 
        };
        target = "${config.home.homeDirectory}/.config/spicetify/Themes";
    };

}
