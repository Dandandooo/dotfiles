{ config, pkgs, nix-colors, ... }:

{

  imports = [
    ./terminal
    ./neovim
    ./spotify.nix
  ];

  home.packages = with pkgs; [
    ### Devtools
    rustup
    ghc

    ### Minecraft utilities
    packwiz
    mcrcon

    ### Fonts
    (nerdfonts.override { fonts = [ "MartianMono" "CascadiaCode" "HeavyData" "Hack" "Agave" "JetBrainsMono" ]; })
  ];

  # Git configuration
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Dandandooo";
    userEmail = "batkodanny@gmail.com";
  };
  programs.gh.enable = true;

}
