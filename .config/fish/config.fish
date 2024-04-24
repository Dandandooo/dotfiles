# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/homebrew/Caskroom/mambaforge/base/bin/conda
    eval /opt/homebrew/Caskroom/mambaforge/base/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

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
set -g theme_display_user yes
set -g theme_hide_hostname yes

set -g theme_red    fd6883 #fd6883
set -g theme_orange f38d70 #f38d70
set -g theme_yellow f9cc6c #f9cc9c
set -g theme_green  adda78 #adda78
set -g theme_blue   6ab0f3 #6ab0f3
set -g theme_purple c397d8 #c397d8

set -g theme_pink   d997c8 #d99cc8
set -g theme_cyan   85dacc #85dacc
set -g theme_mint   79dcaa #79dcaa
set -g theme_gray   262626 #262626
set -g theme_lgray  c7c7ca #c7c7ca


# Prompt Colors

set -g color_dir_bg ffaf5f
set -g color_dir_str 585858
set -g color_user_bg 5f0000
set -g color_user_str ffffaf

set -g color_os_bg 262626
set -g color_os_str eeeeee

set -g color_virtual_env_bg 0087ff
set -g color_virtual_env_str ffd700

# Vim mode colors
set -g color_vi_mode_normal adda78
set -g color_vi_mode_insert 6ab0f3
set -g color_vi_mode_visual f9cc6c

# Status backgrounds
set -g color_status_private_bg $theme_gray
set -g color_status_nonzero_bg $theme_gray
set -g color_status_superuser_bg $theme_gray
set -g color_status_jobs_bg $theme_gray

# Git
set -g branch_symbol "🕊️"

# Conda Prompt
set color_conda_bg 262626
set color_conda_str 87d700
set symbol_conda "🐍"

function get_conda_colors
  set -q color_conda_bg
  set -q color_conda_str
  set -q symbol_conda
  switch $CONDA_DEFAULT_ENV
    case default
      set color_conda_str 87d700
      set symbol_conda "🐍"
    case base
      set color_conda_str 87d700
      set symbol_conda "🐍"
    case Quantum
      set color_conda_str 875fff
      set symbol_conda "💫"
    case AI
      set color_conda_str 00afff
      set symbol_conda "🧠"
    case Euler
      set color_conda_str ffff87
      set symbol_conda "🧮"
    case Tur
      set color_conda_str ff0066
      set symbol_conda "🗣️"
    case cs361
      set color_conda_str 800000
      set symbol_conda "📈"
  end
end

function prompt_virtual_env -d "Display Python or Nix virtual environment"
  set envs

#  if test "$CONDA_DEFAULT_ENV"
#    set envs $envs "conda[$CONDA_DEFAULT_ENV]"
#  end

  if test "$VIRTUAL_ENV"
    set py_env (basename $VIRTUAL_ENV)
    set envs $envs "py[$py_env]"
  end

  if test "$IN_NIX_SHELL"
    set envs $envs "nix[$IN_NIX_SHELL]"
  end

  if test "$envs"
    prompt_segment $color_virtual_env_bg $color_virtual_env_str (string join " " $envs)
  end
end

function __conda_add_prompt
  get_conda_colors
	if [ "$right_segment_separator" = "" ]
		set_color $color_conda_bg
		echo -n ""
		set_color $color_conda_str
		set_color -b $color_conda_bg
	else
		set_color -o $color_conda_default
	end
	echo -n " $symbol_conda $CONDA_DEFAULT_ENV "
	set_color normal
end

# Vi Mode Prompt - Corrected for conda
set -g color_vi_mode_indicator 262626

function prompt_vi_mode -d 'vi mode status indicator'
  set -l right_segment_separator \uE0B2
  if set -q $CONDA_SHLVL
    set_color -b $color_conda_bg
  end
  switch $fish_bind_mode
    case default
    set -l mode (fish_cursor_name_to_code $cursor_vi_mode_normal)
    echo -e "\e[\x3$mode q"
    set_color $color_vi_mode_normal
    echo -e "$right_segment_separator"
    set_color -b $color_vi_mode_normal $color_vi_mode_indicator
    echo " N "
    case insert
    set -l mode (fish_cursor_name_to_code $cursor_vi_mode_insert)
    echo -e "\e[\x3$mode q"
    set_color $color_vi_mode_insert
    echo "$right_segment_separator"
    set_color -b $color_vi_mode_insert $color_vi_mode_indicator
    echo " I "
    case visual
    set -l mode (fish_cursor_name_to_code $cursor_vi_mode_visual)
    echo -e "\e[\x3$mode q"
    set_color $color_vi_mode_visual
    echo "$right_segment_separator"
    set_color -b $color_vi_mode_visual $color_vi_mode_indicator
    echo " V "
  end
end

# Add OS to agnoster prompt
function prompt_os
  switch (uname)
    case Darwin
      set os_icon ""
    case Linux
      set os_icon "🐧"
  end
  if set -q os_icon
    prompt_segment $color_os_bg $color_os_str $os_icon
  end
end

if set -q right_segment_separator
  function fish_prompt
    set -g RETVAL $status
    prompt_status
    prompt_os
    # prompt_virtual_env
    prompt_user
    prompt_dir
    if [ (cwd_in_scm_blacklist | wc -c) -eq 0 ]
      type -q hg;  and prompt_hg
      type -q git; and prompt_git
      if [ "$theme_svn_prompt_enabled" = "yes" ]
          type -q svn; and prompt_svn
      end
    end
    prompt_finish
  end
end

# Budspencer

if test (uname -s) = "Darwin"
  set -gx PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  set -gx PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH
end

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/dani/.ghcup/bin # ghcup-env

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

