{ config, pkgs, nix-colors, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # set fish_greeting "⋉( ⊂ ´◕ ᴥ ◕`)"
      # set fish_greeting "
      #      ________ .-./`)    .-''''-. .---.  .---.  
      #     |        |\ .-.')  / _     \|   |  |_ _|  
      #     |   .----'/ `-' \ (`' )/`--'|   |  ( ' )  
      #     |  _|____  `-'`\"`(_ o _).   |   '-(_{;}_) 
      #     |_( )_   | .---.  (_,_). '. |      (_,_)  
      #     (_ o._)__| |   | .---.  \  :| _ _--.   | 
      #     |(_,_)     |   | \    `-'  ||( ' ) |   |  
      #     |   |      |   |  \       / (_{;}_)|   |  
      #     '---'      '---'   `-...-'  '(_,_) '---'  
      #     "
      function fish_greeting
        echo (set_color green)
        echo -s " ________ " (set_color red) ".-./`)" (set_color green) "    .-''''-. .---.  .---."
        echo -s "|        |" (set_color red) "\ " (set_color yellow) ".-." (set_color red) "')" (set_color green) "  / " (set_color red) "_" (set_color green) "     \|   |  |" (set_color red) "_ _" (set_color green) "|"
        echo -s "|   .----'" (set_color red) "/ " (set_color yellow) "`-'" (set_color red) " \ (`' )" (set_color green) "/`--'|   |  " (set_color red) "( ' )" (set_color green)
        echo -s "|  " (set_color red;) _ (set_color green) "|____  " (set_color red) "`-'`\"`(_ " (set_color yellow) o (set_color red) " _)" (set_color green) ".   |   '-" (set_color red) "(_" (set_color yellow) "{;}" (set_color red) "_)" (set_color green)
        echo -s "|" (set_color red;) "_( )_" (set_color green) "   | .---.  " (set_color red) "(_,_)" (set_color green) ". '. |      " (set_color red) "(_,_)"
        echo -s "(_ " (set_color yellow) "o" (set_color red) "._)" (set_color green;) "__| |   | .---.  \  :| " (set_color red) "_ _" (set_color green) "--.   |"
        echo -s "|" (set_color red) "(_,_)" (set_color green) "     |   | \    `-'  ||" (set_color red) "( ' )" (set_color green) " |   |"
        echo -s "|   |      |   |  \       / " (set_color red) "(_" (set_color yellow) "{;}" (set_color red) "_)" (set_color green) "|   |"
        echo -s "'---'      '---'   `-...-'  '" (set_color red) "(_,_)" (set_color green) " '---'"
        echo (set_color normal)
      end 
    '';
    plugins = [
      # { name="done"; src=pkgs.fishPlugins.done.src; }
    ];
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    autosuggestion.enable = true;
    # autosuggestion.hightlight = "...";
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
    echo "\x1b[31m\n" \
         "  (\`-')   (\`-').-> (\`-').->\n" \
         "  ( OO).->( OO)_   (OO )__\n" \
         "\x1b[33m,\x1b[31m(_/\x1b[33m----.\x1b[31m(_)\x1b[33m--\x1b[31m\_) \x1b[33m,--. ,\x1b[31m'-'\n" \
         "\x1b[33m|__,    |/    _ / |  | |  |\n" \
         "\x1b[31m (_\x1b[33m/   / \_..\`--. |  \`-'  |\n" \
         " .'  .'_ .-._)   \\|  .-.  |\n" \
         "|       |\       /|  | |  |\n" \
         "\`-------' \`-----' \`--' \`--'\n" \
         "\x1b[0m"
    '';
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''

      # echo ".-. .-')     ('-.      .-')    ('-. .-."
      # echo "\  ( OO )   ( OO ).-. ( OO ). ( OO )  /"
      # echo ";-----.\   / . --. /(_)---\_),--. ,--."
      # echo "| .-.  |   | \-.  \ /    _ | |  | |  |"
      # echo "| '-' /_).-'-'  |  |\  :` `. |   .|  |"
      # echo "| .-. `.  \| |_.'  | '..`'''.)|       |"
      # echo "| |  \  |  |  .-.  |.-._)   \|  .-.  |"
      # echo "| '--'  /  |  | |  |\       /|  | |  |"
      # echo "`------'   `--' `--' `-----' `--' `--'"
      # echo "\x1b[0m"

    '';
  };

  programs.nushell = {
    enable = true;
    extraConfig = ''
    $env.config = {
      show_banner: false,
    }
    '';
  };

  # programs.fastfetch.enable = true;

  ##### PROMPT
  programs.starship.enable = true;
  # home.file.starship.source = ".config/starship.toml";



  ##### SHELL
  programs.thefuck.enable = true;

  ##### FILES
  programs.zoxide.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;

  ##### SYSTEM MONITORS
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "monokai";
      theme_background = false;
    };
  };

  ##### MULTIPLEXING
  programs.zellij.enable = true;
  programs.tmux = {
    enable = true;
    mouse = true;
    terminal = "screen-256color";
    keyMode = "vi";
  };

  ##### Plain VIM
  programs.vim = {
    enable = true;
    settings = {
      number = true;
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
    };
    extraConfig = ''
      set ai
      syntax on
    '';
  };

}
