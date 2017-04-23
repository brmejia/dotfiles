# Path to your oh-my-zsh installation.
export ZSH=/home/andres/.oh-my-zsh


# Font Config
source /home/andres/.fonts/fontawesome-regular.sh
source /home/andres/.fonts/devicons-regular.sh
source /home/andres/.fonts/octicons-regular.sh
source /home/andres/.fonts/pomicons-regular.sh


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnosterzak"
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git dnf docker)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# XBOXDRV
alias gamepad-xbox='sudo xboxdrv --device-by-id 0xffff:0xffff --type xbox360 --silent --force-feedback'
alias gamepad-n64='sudo xboxdrv --device-by-id 0xffff:0xffff --type xbox360 --silent --force-feedback --trigger-as-button'
alias gamepad-ps3='sudo xboxdrv --type xbox360 --silent --force-feedback --trigger-as-button --detach-kernel-driver'


# VAGRANT aliases
alias vagrant-start='vagrant up && vagrant ssh'
alias vagrant-reload='vagrant reload && vagrant ssh'

#MATLAB
alias matlab='LD_PRELOAD="/usr/lib64/libstdc++.so.6" /opt/MATLAB/R2016b/bin/matlab'


#PYTHON
#alias python='/usr/bin/python3'

# ******************************************************************************
# AGNOSTERZAK THEME
# ******************************************************************************

# ## Main prompt
# build_prompt() {
#   RETVAL=$?
#   echo -n "\n"
#   prompt_status
#   prompt_battery
#   prompt_time
#   # prompt_virtualenv
#   prompt_dir
#   prompt_git
#   # prompt_hg
#   prompt_end
#   CURRENT_BG='NONE'
#   echo -n "\n"
#   prompt_context
#   prompt_end
# }


# Git: branch/detached head, dirty status
prompt_git() {
set_default POWERLEVEL9K_GIT_FOREGROUND "green"
#«»±˖˗‑‐‒ ━ ✚‐↔←↑↓→↭⇎⇔⋆━◂▸◄►◆☀★☗☊✔✖❮❯⚑⚙
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\Ue0a0'         # 
  }
  local ref dirty mode repo_path clean has_upstream
  local modified untracked added deleted tagged stashed
  local ready_commit git_status bgclr fgclr
  local commits_diff commits_ahead commits_behind has_diverged to_push to_pull

  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    git_status=$(git status --porcelain 2> /dev/null)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      clean=''
      bgclr='yellow'
      fgclr='magenta'
    else
      clean=' ✔'
      bgclr='green'
      fgclr='white'
    fi

    local upstream=$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)
    if [[ -n "${upstream}" && "${upstream}" != "@{upstream}" ]]; then has_upstream=true; fi

    local current_commit_hash=$(git rev-parse HEAD 2> /dev/null)

    local number_of_untracked_files=$(\grep -c "^??" <<< "${git_status}")
    # if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $number_of_untracked_files◆"; fi
    if [[ $number_of_untracked_files -gt 0 ]]; then untracked=" $number_of_untracked_files☀"; fi

    local number_added=$(\grep -c "^A" <<< "${git_status}")
    if [[ $number_added -gt 0 ]]; then added=" $number_added✚"; fi

    local number_modified=$(\grep -c "^.M" <<< "${git_status}")
    if [[ $number_modified -gt 0 ]]; then
      modified=" $number_modified●"
      bgclr='red'
      fgclr='white'
    fi

    local number_added_modified=$(\grep -c "^M" <<< "${git_status}")
    local number_added_renamed=$(\grep -c "^R" <<< "${git_status}")
    if [[ $number_modified -gt 0 && $number_added_modified -gt 0 ]]; then
      modified="$modified$((number_added_modified+number_added_renamed))±"
    elif [[ $number_added_modified -gt 0 ]]; then
      modified=" ●$((number_added_modified+number_added_renamed))±"
    fi

    local number_deleted=$(\grep -c "^.D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 ]]; then
      deleted=" $number_deleted‒"
      bgclr='red'
      fgclr='white'
    fi

    local number_added_deleted=$(\grep -c "^D" <<< "${git_status}")
    if [[ $number_deleted -gt 0 && $number_added_deleted -gt 0 ]]; then
      deleted="$deleted$number_added_deleted±"
    elif [[ $number_added_deleted -gt 0 ]]; then
      deleted=" ‒$number_added_deleted±"
    fi

    local tag_at_current_commit=$(git describe --exact-match --tags $current_commit_hash 2> /dev/null)
    if [[ -n $tag_at_current_commit ]]; then tagged=" ☗$tag_at_current_commit "; fi

    local number_of_stashes="$(git stash list -n1 2> /dev/null | wc -l)"
    if [[ $number_of_stashes -gt 0 ]]; then
      stashed=" $number_of_stashes⚙"
      bgclr='magenta'
      fgclr='white'
    fi

    if [[ $number_added -gt 0 || $number_added_modified -gt 0 || $number_added_deleted -gt 0 ]]; then ready_commit=' ⚑'; fi

    local upstream_prompt=''
    if [[ $has_upstream == true ]]; then
      commits_diff="$(git log --pretty=oneline --topo-order --left-right ${current_commit_hash}...${upstream} 2> /dev/null)"
      commits_ahead=$(\grep -c "^<" <<< "$commits_diff")
      commits_behind=$(\grep -c "^>" <<< "$commits_diff")
      upstream_prompt="$(git rev-parse --symbolic-full-name --abbrev-ref @{upstream} 2> /dev/null)"
      upstream_prompt=$(sed -e 's/\/.*$/ ☊ /g' <<< "$upstream_prompt")
    fi

    has_diverged=false
    if [[ $commits_ahead -gt 0 && $commits_behind -gt 0 ]]; then has_diverged=true; fi
    if [[ $has_diverged == false && $commits_ahead -gt 0 ]]; then
      if [[ $bgclr == 'red' || $bgclr == 'magenta' ]] then
        to_push=" $fg_bold[white]↑$commits_ahead$fg_bold[$fgclr]"
      else
        to_push=" $fg_bold[black]↑$commits_ahead$fg_bold[$fgclr]"
      fi
    fi
    if [[ $has_diverged == false && $commits_behind -gt 0 ]]; then to_pull=" $fg_bold[magenta]↓$commits_behind$fg_bold[$fgclr]"; fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    # prompt_segment $bgclr $fgclr

    echo -n "$fg_bold[$fgclr]${ref/refs\/heads\//$PL_BRANCH_CHAR $upstream_prompt}${mode}$to_push$to_pull$clean$tagged$stashed$untracked$modified$deleted$added$ready_commit$fg_no_bold[$fgclr]"
    "$1_prompt_segment" "${0}_${(U)current_state}" "$2" "${vcs_states[$current_state]}" "$DEFAULT_COLOR" "$vcs_prompt" "$vcs_visual_identifier"

  fi
}


# ******************************************************************************
# POWERLEVEL9K THEME
# ******************************************************************************
POWERLEVEL9K_MODE='awesome-fontconfig'
# POWERLEVEL9K_MODE='awesome-patched'

# PROMPT
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv root_indicator context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time battery)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\U250f"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%F{249}%}\U2517%{%F{default}%} "
POWERLEVEL9K_SHORTEN_DIR_LENGTH=5
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_ROOT_ICON='⚡'
# POWERLEVEL9K_LINUX_ICON='⚡'
POWERLEVEL9K_HOME_ICON='\U1F3E0'
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON='\U1F5BF'
POWERLEVEL9K_PYTHON_ICON='\U1F40D'
POWERLEVEL9K_VIRTUALENV_BACKGROUND='NONE'
POWERLEVEL9K_VIRTUALENV_FOREGROUND='green'
# POWERLEVEL9K_VIRTUALENV_FOREGROUND=$DEFAULT_COLOR

# CONTEXT
DEFAULT_USER=$(whoami)

# BATTERY
POWERLEVEL9K_BATTERY_CHARGING='yellow'
POWERLEVEL9K_BATTERY_CHARGED='green'
POWERLEVEL9K_BATTERY_ICON='\U1F50B'
# POWERLEVEL9K_BATTERY_ICON='\Uf17e'
# POWERLEVEL9K_BATTERY_ICON="\Uf241"
# POWERLEVEL9K_BACKGROUND_JOBS_ICON='⚙'
# POWERLEVEL9K_SWAP_ICON='SWP'
# POWERLEVEL9K_RAM_ICON='RAM'

# TIME
#POWERLEVEL9K_CUSTOM_TIME_FORMAT="%D{\Uf017 %H:%M:%S}"
# POWERLEVEL9K_TIME_FORMAT="%D{\Uf017 %H:%M \Uf073 %d.%m.%y}"
POWERLEVEL9K_TIME_FORMAT="%D{\U23F0%H:%M}"

# STATUS
# POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
# POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
# POWERLEVEL9K_FAIL_ICON= ✘
# POWERLEVEL9K_OK_ICON= ✓

# GIT
# POWERLEVEL9K_VCS_GIT_ICON="\U$CODEPOINT_OF_AWESOME_GITHUB "
# POWERLEVEL9K_VCS_GIT_ICON='\Ue60a'
# POWERLEVEL9K_VCS_STAGED_ICON='\U00b1'
# POWERLEVEL9K_VCS_UNSTAGED_ICON='\U00b1'
POWERLEVEL9K_VCS_UNSTAGED_ICON="\U$CODEPOINT_OF_AWESOME_DOT_CIRCLE_ALT "
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON="\U$CODEPOINT_OF_AWESOME_ARROW_DOWN "
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON="\U$CODEPOINT_OF_AWESOME_ARROW_UP "
# POWERLEVEL9K_VCS_CLEAN_ICON='\Uf030'
POWERLEVEL9K_VCS_DELETED_ICON="\U$CODEPOINT_OF_AWESOME_MINUS_SIGN_ALT"
POWERLEVEL9K_VCS_UNTRACKED_ICON="\U$CODEPOINT_OF_AWESOME_QUESTION"
POWERLEVEL9K_VCS_COMMIT_ICON="\U$CODEPOINT_OF_AWESOME_FLAG_CHECKERED"
# POWERLEVEL9K_VCS_BOOKMARK_ICON= ☿
# POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
# POWERLEVEL9K_VCS_STASH_ICON= ⍟
# POWERLEVEL9K_VCS_REMOTE_BRANCH_ICON= →
# POWERLEVEL9K_VCS_BRANCH_ICON= 
# POWERLEVEL9K_VCS_TAG_ICON=

POWERLEVEL9K_VCS_CLEAN_FOREGROUND='white'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='white'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='red'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'

# DIR
POWERLEVEL9K_DIR_HOME_FOREGROUND="white"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"
# POWERLEVEL9K_DIR_HOME_BACKGROUND="magenta"
# POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="bla ck"

# OVERRIDE
# Virtualenv: current working virtualenv
# More information on virtualenv (Python):
# https://virtualenv.pypa.io/en/latest/
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n "$virtualenv_path" && "$VIRTUAL_ENV_DISABLE_PROMPT" != true ]]; then
    # "$1_prompt_segment" "$0" "$2" "$POWERLEVEL9K_VIRTUALENV_BACKGROUND" "$POWERLEVEL9K_VIRTUALENV_FOREGROUND" "[$POWERLEVEL9K_PYTHON_ICON:$(basename $(dirname "$virtualenv_path"))/$(basename "$virtualenv_path") ]"
    "$1_prompt_segment" "$0" "$2" "$POWERLEVEL9K_VIRTUALENV_BACKGROUND" "$POWERLEVEL9K_VIRTUALENV_FOREGROUND" "[ $POWERLEVEL9K_PYTHON_ICO$(basename "$virtualenv_path") ]"
  fi
}

# VirtualenvWrapper Settings
export WORKON_HOME=~/.virtualenvs # Work directory
source /usr/bin/virtualenvwrapper.sh # Source of wrapper commands

# Firefox geckodriver
PATH=$PATH:/opt/geckodriver

# Mostrando un mensaje interesante con cowsay
if [ -x /usr/bin/cowsay -a -x /usr/bin/fortune ]; then
    fortune | cowsay
    # fortune | cowsay -f elephant-in-snake
fi
#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# tmuxp completion
eval "$(_TMUXP_COMPLETE=source tmuxp)"
export DISABLE_AUTO_TITLE = 'true'
