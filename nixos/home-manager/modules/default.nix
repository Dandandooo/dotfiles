{ config, pkgs, nix-colors, ... }:

{


  home.packages = with pkgs; [
    ### Devtools
    rustup
    ghc

    packwiz

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
