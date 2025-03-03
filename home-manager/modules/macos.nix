{ lib, config, ... }:

{
    home = {
        homeDirectory = "/Users/dani";
        sessionVariables.PATH = "$PATH:/opt/homebrew/bin";
    };

    programs.fish.interactiveShellInit = ''
        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        if test -f /opt/homebrew/Caskroom/mambaforge/base/bin/conda
            eval /opt/homebrew/Caskroom/mambaforge/base/bin/conda "shell.fish" "hook" $argv | source
        end
        # <<< conda initialize <<<
    '';

    programs.zsh.initExtra = ''
        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/opt/homebrew/Caskroom/mambaforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh" ]; then
                . "/opt/homebrew/Caskroom/mambaforge/base/etc/profile.d/conda.sh"
            else
                export PATH="/opt/homebrew/Caskroom/mambaforge/base/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda initialize <<<
    '';
}
