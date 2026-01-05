#!/usr/bin/env zsh

function _load_functions() {
    # Load all custom function files // Directories are ignored
    for file in "${ZDOTDIR:-$HOME/.config/zsh}/functions/"*.zsh; do
        [ -r "$file" ] && source "$file"
    done
}

function _load_completions() {
    if command -v fzf &>/dev/null; then
        eval "$(fzf --zsh)"
    fi
}

function do_render {
    # Check if the terminal supports images
    local type="${1:-image}"
    # TODO: update this list if needed
    TERMINAL_IMAGE_SUPPORT=(kitty konsole ghostty WezTerm)
    local terminal_no_art=(vscode code codium)
    TERMINAL_NO_ART="${TERMINAL_NO_ART:-${terminal_no_art[@]}}"
    CURRENT_TERMINAL="${TERM_PROGRAM:-$(ps -o comm= -p $(ps -o ppid= -p $$))}"

    case "${type}" in
    image)
        if [[ " ${TERMINAL_IMAGE_SUPPORT[@]} " =~ " ${CURRENT_TERMINAL} " ]]; then
            return 0
        else
            return 1
        fi
        ;;
    art)
        if [[ " ${TERMINAL_NO_ART[@]} " =~ " ${CURRENT_TERMINAL} " ]]; then
            return 1
        else
            return 0
        fi
        ;;
    *)
        return 1
        ;;
    esac
}

function _load_compinit() {
    # Initialize completions with optimized performance
    autoload -Uz compinit

    # Enable extended glob for the qualifier to work
    setopt EXTENDED_GLOB

    # Fastest - use glob qualifiers on directory pattern
    if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+${HYDE_ZSH_COMPINIT_CHECK:-1}) ]]; then
        compinit
    else
        compinit -C
    fi

    _comp_options+=(globdots) # tab complete hidden files
}

function _load_prompt() {
    # Try to load prompts immediately
    if ! source ${ZDOTDIR}/prompt.zsh >/dev/null 2>&1; then
        [[ -f $ZDOTDIR/conf.d/hyde/prompt.zsh ]] && source $ZDOTDIR/conf.d/hyde/prompt.zsh
    fi
}

# Override this environment variable in ~/.zshrc
# cleaning up home folder
# ZSH Plugin Configuration

HYDE_ZSH_DEFER="1"      #Unset this variable in $ZDOTDIR/user.zsh to disable HyDE's deferred Zsh loading.
HYDE_ZSH_PROMPT="1"     #Unset this variable in $ZDOTDIR/user.zsh to disable HyDE's prompt customization.
HYDE_ZSH_NO_PLUGINS="0" #Set this variable to "1" in $ZDOTDIR/user.zsh to disable HyDE's Zsh plugin loading.

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# # History configuration
HISTFILE=${HISTFILE:-$ZDOTDIR/.zsh_history}
if [[ -f $HOME/.zsh_history ]] && [[ ! -f $HISTFILE ]]; then
    echo "Please manually move $HOME/.zsh_history to $HISTFILE"
    echo "Or move it somewhere else to avoid conflicts"
fi
HISTSIZE=10000
SAVEHIST=10000


export HISTFILE ZSH_AUTOSUGGEST_STRATEGY HISTSIZE SAVEHIST

# HyDE Package Manager
PM_COMMAND=(brew)

# Optionally load user configuration // useful for customizing the shell without modifying the main file
if [[ -f $HOME/.hyde.zshrc ]]; then
    source $HOME/.hyde.zshrc # for backward compatibility
elif [[ -f $HOME/.user.zsh ]]; then
    source $HOME/.user.zsh # renamed to .user.zsh for intuitiveness that it is a user config
elif [[ -f $ZDOTDIR/user.zsh ]]; then
    source $ZDOTDIR/user.zsh
fi

_load_compinit

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    # Load plugins from plugin.zsh (Zinit)
    if source $ZDOTDIR/plugin.zsh >/dev/null 2>&1; then
        source $ZDOTDIR/plugin.zsh
        _load_prompt
        _load_functions
        _load_completions
    else
        echo "No plugin system found. Please create a $ZDOTDIR/plugin.zsh file."
    fi
else
    # Load user plugins if they exist
    # Assumes user has a plugin.zsh file in their $ZDOTDIR
    [[ -r $ZDOTDIR/plugin.zsh ]] && source $ZDOTDIR/plugin.zsh
    _load_prompt
    _load_functions
    _load_completions
fi

__package_manager () { 
    ${PM_COMMAND[@]} "$@"
}

alias c='clear' \
    in='__package_manager install' \
    un='__package_manager remove' \
    up='__package_manager upgrade' \
    pl='__package_manager search installed' \
    pa='__package_manager search all' \
    vc='code' \
    ..='cd ..' \
    ...='cd ../..' \
    .3='cd ../../..' \
    .4='cd ../../../..' \
    .5='cd ../../../../..' \
    mkdir='mkdir -p'

