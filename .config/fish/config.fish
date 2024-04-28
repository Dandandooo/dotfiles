# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/mambaforge/base/bin/conda
    eval /opt/homebrew/Caskroom/mambaforge/base/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

set fish_greeting "⋉( ⊂ ´◕ ᴥ ◕`)"

starship init fish | source

#set -x DRIVEFS "$HOME/Library/CloudStorage/GoogleDrive-1522451@fcpsschools.net"
#set -x ML_PATH "$DRIVEFS/My Drive/High School/12th Grade/2 - ML"
set -x OneDrive "$HOME/OneDrive - University of Illinois - Urbana"
set -x OLD_DRIVE "$HOME/OneDrive - University of Illinois - Urbana/Old Drive/"

set -x APCS "$OLD_DRIVE/High School/10th Grade/Pd.1 CS"
set -x ML "$OLD_DRIVE/High School/12th Grade/2 - ML"
set -x AI "$OLD_DRIVE/High School/11th Grade/AI"
#set -x EXO_GEN "$DRIVEFS/My Drive/High School/12th Grade/1 - Astro/Exoplanet Generator"
set -x BOX "$HOME/Library/CloudStorage/Box-Box"

# NVIM Alias
alias vim $(which nvim) 
set -x NEOVIM "$HOME/.config/nvim"
alias nvim-config "nvim $NEOVIM"

alias fish-config "nvim ~/.config/fish/config.fish"

# ZOXIDE Config
zoxide init fish | source

# COLORS
alias ls "ls --color=auto"
alias tree "tree -C"

# Setting PATH for Python 3.10
# The original version is saved in /Users/dani/.config/fish/config.fish.pysave
set -x PATH "/Library/Frameworks/Python.framework/Versions/3.10/bin" "$PATH"
#fish_add_path /usr/local/opt/tcl-tk/bin

# Set Up Mojo Lang
set -x MODULAR_HOME "/Users/dani/.modular"
set -x PATH "/Users/dani/.modular/pkg/packages.modular.com_mojo/bin" "$PATH"

# Set Up XAuth
set -x XAUTHORITY "$HOME/.Xauthority"

#### THEME SETTINGS ####
set -g theme_red    fd6883 #fd6883 #ff6f8a
set -g theme_orange f38d70 #f38d70 #ff9070
set -g theme_yellow f9cc6c #f9cc6c #f9cc9c
set -g theme_green  adda78 #adda78 #adda90
set -g theme_blue   6ab0f3 #6ab0f3 #7aa2f3
set -g theme_purple c397d8 #c397d8 #b397d8

set -g theme_pink   d997c8 #d99cc8
set -g theme_cyan   85dacc #85dacc
set -g theme_mint   79dcaa #79dcaa
set -g theme_gray   262626 #262626
set -g theme_lgray  c7c7ca #c7c7ca

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/dani/.ghcup/bin # ghcup-env

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

