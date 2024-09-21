{ config, fetchgit, pkgs, lib, ... }:

{

    home.packages = with pkgs; [
        spotify
        spicetify-cli
    ];

    home.file.".config/spicetify/Themes" = {
        source = builtins.fetchGit {
            url = "https://github.com/spicetify/spicetify-themes.git";
            rev = "bf2263b71b9ed4f4cff4125df45ef157f5b2b01e"; 
        };
        target = "${config.home.homeDirectory}/.config/spicetify/Themes";
    };

    home.activation.spotifyPathScript = ''
        run sed -i -e 's|spotify_path           = |spotify_path           = "${pkgs.spotify}/bin/spotify"|g' ${config.home.homeDirectory}/.config/spicetify/config-xpui.ini
    '';


}
