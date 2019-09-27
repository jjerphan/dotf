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


# Path to oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

source $ZSH/oh-my-zsh.sh
plugins=(git zsh-autosuggestions virtualenv fzf-zsh)

# For colors
setopt prompt_subst
autoload -U colors && colors

# Enable command auto-correction.
ENABLE_CORRECTION="false"

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Cool git prompt
# see: https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
  local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
  local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "\033[38;5;15m±" )
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "\033[38;5;15m$GIT_LOCATION%{$reset_color%}" )
  echo "${(j: :)GIT_INFO}"

}

# Use → as the non-root prompt character; # for root
# Change the prompt character color if the last command had a nonzero exit code
PS1='%B⋅%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[white]%}%~%{$fg[red]%}%{$reset_color%} 🚀 %b $(git_info)
%(?.%{$fg[green]%}.%{$fg[red]%})%(!.#. →)%{$reset_color%} '

# For syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

# Autocompletion for kubectl
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

# Enable Ctrl-x-e to edit command line
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Global shells settings
source $HOME/.comrc

# Suffix aliases
alias -s md=$EDITOR
alias -s tex=$EDITOR
alias -s py=python

# Quick navigation between previous folders
d='dirs -v | head -20'
1='cd -'
2='cd -2'
3='cd -3'
4='cd -4'
5='cd -5'
6='cd -6'
7='cd -7'
8='cd -8'
9='cd -9'
10='cd -10'
11='cd -11'
12='cd -12'
13='cd -13'
14='cd -14'
15='cd -15'
16='cd -16'
17='cd -17'
18='cd -18'
19='cd -19'
20='cd -20'

# Global aliases
alias -g C='| wc -l'
alias -g ELS='|& less -S'
alias -g ETL='|& tail -20'
alias -g ET='|& tail'
alias -g G='| egrep'
alias -g H='| head'
alias -g HL='|& head -20'
alias -g Sk="*~(*.bz2|*.gz|*.tgz|*.zip|*.z)"
alias -g LL="2>&1 | less"
alias -g L="| less"
alias -g LS='| less -S'
alias -g M='| more'
alias -g NE="2> /dev/null"
alias -g NS='| sort -n'
alias -g NUL="> /dev/null 2>&1"
alias -g RNS='| sort -nr'
alias -g S='| sort'
alias -g TL='| tail -20'
alias -g T='| tail'
alias -g US='| sort -u'
alias -g X='| xargs'
