#!/usr/bin/env zsh
# ------------------------------------------------------------------------------
# Prompt for the Zsh shell:
#   * One line.
#   * VCS info on the right prompt.
#   * Only shows the path on the left prompt by default.
#   * Crops the path to a defined length and only shows the path relative to
#     the current VCS repository root.
#   * Wears a different color wether the last command succeeded/failed.
#   * Shows user@hostname if connected through SSH.
#   * Shows if logged in as root or not.
# ------------------------------------------------------------------------------

# Customizable parameters.
PROMPT_PATH_MAX_LENGTH=25
PROMPT_DEFAULT_END='λ'
PROMPT_ROOT_END='#'
if [ "$(hostname)" != "$HOME_SYSTEM" ]; then
  PROMPT_SUCCESS_COLOR=$FG[205]
else
  PROMPT_SUCCESS_COLOR=$FG[008]
fi
PROMPT_FAILURE_COLOR=$FG[009]
PROMPT_VCS_INFO_COLOR=$FG[242]
PROMPT_STAGED_COLOR=$FG[002]
PROMPT_UNSTAGED_COLOR=$FG[001]
PROMPT_UNTRACKED_COLOR=$FG[202]

# Set required options.
setopt promptsubst

# Load required modules.
autoload -U add-zsh-hook
autoload -Uz vcs_info

# Add hook for calling our VCS checking before each command.
function check_vcs() {
  if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null) ]] {
    zstyle ':vcs_info:*:*' formats "%S " "%r/%s/%b %u%c"
    zstyle ':vcs_info:*:*' actionformats "%S " "%r/%s/%b %u%c (%a)"
  } else {
    zstyle ':vcs_info:*:*' formats "%S " "%r/%s/%b %{$PROMPT_UNTRACKED_COLOR%}●%{$FX[reset]%}%u%c"
    zstyle ':vcs_info:*:*' actionformats "%S " "%r/%s/%b %{$PROMPT_UNTRACKED_COLOR%}●%{$FX[reset]%}%u%c (%a)"
  }
  vcs_info
}
add-zsh-hook precmd check_vcs

# Set vcs_info parameters.
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' check-for-changes true # Can be slow on big repos.
zstyle ':vcs_info:*:*' stagedstr "%{$PROMPT_STAGED_COLOR%}●%{$FX[reset]%}"
zstyle ':vcs_info:*:*' unstagedstr "%{$PROMPT_UNSTAGED_COLOR%}●%{$FX[reset]%}"
zstyle ':vcs_info:*:*' nvcsformats "%2(~.%1d.%1d) " ""

# Define prompts.
PROMPT_PATH_COLOR="%(0?.%{$PROMPT_SUCCESS_COLOR%}.%{$PROMPT_FAILURE_COLOR%})"
PROMPT_PATH="%{$FX[bold]%}%$PROMPT_PATH_MAX_LENGTH<..<"'${vcs_info_msg_0_%%. }'"%<<%{$FX[no-bold]%}$FG[250]"
PROMPT_RESET="%{$FX[reset]%}"

PROMPT="$PROMPT_PATH_COLOR$PROMPT_PATH%(!.$PROMPT_ROOT_END.$PROMPT_DEFAULT_END)$PROMPT_RESET "
RPROMPT="%{$PROMPT_VCS_INFO_COLOR%}"'$vcs_info_msg_1_'"%{$FX[reset]%}"
