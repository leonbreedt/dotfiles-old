# : bitserf's zshrc

# : functions
reload() {
  source ~/.zshrc 
}
env_less() {
  which lesspipe &>/dev/null
  test $? -eq 0 && export LESSOPEN="|lesspipe %s" && return
  which lesspipe.sh &>/dev/null
  test $? -eq 0 && export LESSOPEN="|lesspipe.sh %s" && return
}
env_dircolors() {
  which dircolors 2>&1 >/dev/null
  test $? -eq 0 && eval `dircolors`
}
var_append() {
  var="$1"; shift
  for entry in $@; do
    if [ X"${(e)var:+\$$var}[(r)$entry]" = X ]; then
      set -A ${var} ${(e)var:+\$$var} ${entry}
    fi
  done
}
var_prepend() {
  var="$1"; shift
  for entry in $@; do
    if [ X"${(e)var:+\$$var}[(r)$entry]" = X ]; then
      set -A ${var} ${entry} ${(e)var:+\$$var}
    fi
  done
}
is_root() {
  test "x`id -u`" = "x0"
}
is_osx() {
  test "x`uname`" = "xDarwin"
}
is_linux() {
  test "x`uname`" = "xLinux"
}
path_append() {
  var_append path $@
}
path_prepend() {
  var_prepend path $@
}

# : environment
export PAGER=less
export EDITOR=mvim
export SVN_EDITOR=mvim
export VISUAL=$EDITOR
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE=~/.zsh_history
export EMAIL=bitserf@gmail.com

[ -d ~/Bin ] && path_prepend ~/Bin

env_less
env_dircolors

# : aliases
is_osx && alias ls='ls -G'
is_linux && alias ls='ls --color=auto -F'
is_osx && alias vi=mvim
is_linux && alias vi=vim

# : zsh options
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_PARAM_SLASH
setopt AUTO_LIST
setopt NO_BAD_PATTERN
setopt NO_BEEP
setopt BANG_HIST
setopt BSD_ECHO
setopt INC_APPEND_HISTORY
setopt HIST_NO_STORE
setopt MARK_DIRS
setopt C_BASES
setopt SHARE_HISTORY
setopt NO_CHECK_JOBS
setopt CLOBBER
setopt COMPLETE_ALIASES
setopt COMPLETE_IN_WORD
setopt NO_CORRECT
setopt NO_CORRECT_ALL
setopt EQUALS
setopt NO_FLOW_CONTROL
setopt NO_AUTO_MENU
setopt NO_MENU_COMPLETE
setopt NO_NOMATCH
setopt RM_STAR_SILENT
setopt NO_RM_STAR_WAIT
setopt NO_HUP
setopt PROMPT_SUBST

# : key bindings
bindkey -e

# : load environment-specific variables
test -f ~/.profile && source ~/.profile

# : prompt
autoload -U colors && colors
autoload -U promptinit && promptinit

prompt bitserf

# : rvm (Ruby Version Manager)
[ -s "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"
