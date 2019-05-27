#      ___           ___           ___           ___           ___
#     /\__\         /\__\         /\  \         /\  \         /\__\
#    /::|  |       /:/ _/_        \:\  \       /::\  \       /:/  /
#   /:/:|  |      /:/ /\  \        \:\  \     /:/\:\__\     /:/  /
#  /:/|:|  |__   /:/ /::\  \   ___ /::\  \   /:/ /:/  /    /:/  /  ___
# /:/ |:| /\__\ /:/_/:/\:\__\ /\  /:/\:\__\ /:/_/:/__/___ /:/__/  /\__\
# \/__|:|/:/  / \:\/:/ /:/  / \:\/:/  \/__/ \:\/:::::/  / \:\  \ /:/  /
#     |:/:/  /   \::/ /:/  /   \::/__/       \::/~~/~~~~   \:\  /:/  /
#     |::/  /     \/_/:/  /     \:\  \        \:\~~\        \:\/:/  /
#     |:/  /        /:/  /       \:\__\        \:\__\        \::/  /
#     |/__/         \/__/         \/__/         \/__/         \/__/
#
#

# Color support
export TERM="xterm-256color"

# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel9k/powerlevel9k"

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git zsh-autosuggestions virtualenv fzf-zsh)

source $ZSH/oh-my-zsh.sh

# Shorter prompt
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir rbenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status virtualenv root_indicator background_jobs history time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true

# Add a space in the first prompt
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%f"

# Visual customisation of the second prompt line
local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
    user_symbol = "#"
fi
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%{%B%F{black}%K{yellow}%} $user_symbol%{%b%f%k%F{yellow}%} %{%f%}"

# For syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# New line on complete
POWERLEVEL9K_PROMPT_ADD_NEWLINE=truei

# Colorise the top Tabs of Iterm2 with the same color as background
# Just change the 18/26/33 wich are the rgb values
echo -e "\033]6;1;bg;red;brightness;18\a"
echo -e "\033]6;1;bg;green;brightness;26\a"
echo -e "\033]6;1;bg;blue;brightness;33\a"

# Global shells settings
source $HOME/.comrc

# Autocompletion for kubectl

if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
