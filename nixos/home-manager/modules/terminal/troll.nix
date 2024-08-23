{ config, pkgs, nix-colors, ... }: 

{

    home.packages = with pkgs; [
        asciiquarium
        fortune
        nyancat
        cmatrix
        cbonsai
        cowsay
        figlet
        pipes
        sl
    ];

}
