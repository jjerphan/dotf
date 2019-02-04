#                    ___           ___           ___           ___           ___
#     _____         /\  \         /\__\         /\  \         /\  \         /\__\
#    /::\  \       /::\  \       /:/ _/_        \:\  \       /::\  \       /:/  /
#   /:/\:\  \     /:/\:\  \     /:/ /\  \        \:\  \     /:/\:\__\     /:/  /
#  /:/ /::\__\   /:/ /::\  \   /:/ /::\  \   ___ /::\  \   /:/ /:/  /    /:/  /  ___
# /:/_/:/\:|__| /:/_/:/\:\__\ /:/_/:/\:\__\ /\  /:/\:\__\ /:/_/:/__/___ /:/__/  /\__\
# \:\/:/ /:/  / \:\/:/  \/__/ \:\/:/ /:/  / \:\/:/  \/__/ \:\/:::::/  / \:\  \ /:/  /
#  \::/_/:/  /   \::/__/       \::/ /:/  /   \::/__/       \::/~~/~~~~   \:\  /:/  /
#   \:\/:/  /     \:\  \        \/_/:/  /     \:\  \        \:\~~\        \:\/:/  /
#    \::/  /       \:\__\         /:/  /       \:\__\        \:\__\        \::/  /
#     \/__/         \/__/         \/__/         \/__/         \/__/         \/__/


# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Global shells settings
source $HOME/.comrc

# bash specific settings
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ @\1/'
}

# User or root color
UC=$COLOR_BROWN
[ $UID -eq "0" ] && UC=$COLOR_RED

# Prompt
PS1="$TITLEBAR\n\[${UC}\]\u \[${COLOR_LIGHT_GRAY}\]\${PWD}\[${COLOR_BROWN}\]\$(parse_git_branch)\[\033[00m\]\n\[${COLOR_LIGHT_GREEN}\]→\[${COLOR_NC}\] "
