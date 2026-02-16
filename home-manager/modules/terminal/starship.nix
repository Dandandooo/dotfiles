{ lib, ... }:

{

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    
    settings = { 

      format = ''
        $os[](fg:#363636 bg:red)$username[](fg:red bg:orange)$directory[](fg:orange bg:yellow)$git_branch$git_status[](fg:yellow bg:green)$conda[](fg:green bg:blue)$nix_shell[](fg:blue bg:purple)$shell[](fg:purple)
        $character
      '';

      character = {
        disabled = false;
        success_symbol = "[❯](bold blue)";
      };

      palette = lib.mkDefault "pale";

      palettes = {
        monokai = {
          black = "#363636";
          bright-red = "#660000";
          red = "#fd6883";
          orange = "#f38d70";
          yellow = "#f9cc6c";
          green = "#adda78";
          blue = "#6ab0f3";
          purple = "#c397d8";
        };

        pale = {
          black = "#363636";
          bright-red = "#660000";
          red = "#ff6f8a";
          orange = "#ff9070";
          yellow = "#f9cc9c";
          green = "#adda90";
          blue = "#7aa2f3";
          purple = "#c397d8";
        };
      };

      os = {
        disabled = false;
        format = "[ $symbol ]($style)";
        style = "bg:#363636 fg:blue";
      };

      os.symbols = {
        Arch = "";
        CentOS = "";
        Linux = "";
        Macos = "";
        NixOS = "";
        Debian = "";
        Ubuntu = "";
        Windows = "";
      };

      shell = {
        disabled = false;
        format = "[ $indicator ]($style)";
        style = "fg:black bg:purple";
        fish_indicator = "󰈺";
        zsh_indicator = "󰰶";
        bash_indicator = "";
        xonsh_indicator = "";
        nu_indicator = "";
        unknown_indicator = "";
      };

      username = {
        disabled = false;
        show_always = true;
        style_user = "bg:red fg:black";
        style_root = "bg:red fg:yellow";
        format = "[ $user ]($style)";
      };

      directory = {
        format = "[ $path ]($style)";
        style = "bg:orange fg:black";
        fish_style_pwd_dir_length = 1;
        truncate_to_repo = true;
        truncation_symbol = "…/";
      };

      git_branch = {
        format = "[ $symbol $branch ]($style)";
        symbol = "";
        style = "bg:yellow fg:black";
      };

      git_status = {
        format = "[\\[$all_status$ahead_behind\\] ]($style)";
        style = "bg:yellow fg:black";
        ignore_submodules = true;
      };

      nix_shell = {
        disabled = false;
        format = "$state";
        pure_msg = "[ 󱄅 ](bg:blue fg:green)";
        impure_msg = "[ 󱄅 ](bg:blue fg:red)";
        unknown_msg = "[ 󱄅 ](bg:blue fg:yellow)";
      };

      conda = {
        disabled = false;
        format = "[ $environment ]($style)";
        style = "bg:green fg:black";
      };

      status = {
        disabled = false;
      };

    };
  };

}
