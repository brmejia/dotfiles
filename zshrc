# VirtualenvWrapper Settings
export WORKON_HOME="~/.virtualenvs" # Work directory
# source /usr/bin/virtualenvwrapper.sh # Source of wrapper commands

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
ZSH_THEME="spaceship"

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
export ZSH="$HOME/.oh-my-zsh";
export ZSH_CUSTOM="$HOME/.dotfiles/oh-my-zsh/custom";

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  zsh_reload
  git
  dnf
  docker
  python
  pipenv
  django
  sublime
  tmux
  virtualenv
  virtualenvwrapper
  zsh-autosuggestions
  zsh-syntax-highlighting
)


# ******************************************************************************
# SPACESHIP THEME
# ******************************************************************************
SPACESHIP_ROOT="$ZSH_CUSTOM/themes/spaceship-prompt"
# USER
# SPACESHIP_USER_PREFIX="" # remove `with` before username
# SPACESHIP_USER_SUFFIX="" # remove space before host

# HOST
# Result will look like this:
#   username@:(hostname)
SPACESHIP_HOST_PREFIX="@:("
SPACESHIP_HOST_SUFFIX=") "

# DIR
SPACESHIP_DIR_PREFIX='' # disable directory prefix, cause its not the first section
SPACESHIP_DIR_TRUNC=4 # show only last directory

# GIT
# Disable git symbol
# SPACESHIP_GIT_SYMBOL="" # disable git prefix
# SPACESHIP_GIT_BRANCH_PREFIX="" # disable branch prefix too
# Wrap git in `git:(...)`
SPACESHIP_GIT_PREFIX='('
SPACESHIP_GIT_SUFFIX=") "
SPACESHIP_GIT_BRANCH_SUFFIX=" " # remove space after branch name
# Unwrap git status from `[...]`
SPACESHIP_GIT_STATUS_PREFIX=""
SPACESHIP_GIT_STATUS_SUFFIX=""

# NODE
SPACESHIP_NODE_PREFIX="("
SPACESHIP_NODE_SUFFIX=") "
# SPACESHIP_NODE_SYMBOL=""

# DOCKER
SPACESHIP_DOCKER_PREFIX="("
SPACESHIP_DOCKER_SUFFIX=") "
# SPACESHIP_DOCKER_SYMBOL=""

# VENV
SPACESHIP_VENV_PREFIX="(\U1F40D "
SPACESHIP_VENV_SUFFIX=") "

# # PYENV
SPACESHIP_PYENV_SHOW=true
SPACESHIP_PYENV_PREFIX="python:("
SPACESHIP_PYENV_SUFFIX=") "
SPACESHIP_PYENV_SYMBOL=""

# User configuration
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"


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


#MATLAB
alias matlab='LD_PRELOAD="/usr/lib64/libstdc++.so.6" ~/Matlab/bin/matlab'

# Drupal8 - Docker commands
alias d8-docker-populate='docker run --rm drupal tar -cC /var/www/html/sites . | tar -xC ~/www/d8_docker/sites'
alias d8-docker-create='docker run --name drupal8 --link pgDB:postgres -d \
    -v ~/www/d8_docker/modules:/var/www/html/modules \
    -v ~/www/d8_docker/profiles:/var/www/html/profiles \
    -v ~/www/d8_docker/sites:/var/www/html/sites \
    -v ~/www/d8_docker/themes:/var/www/html/themes \
    -p 8080:80 \
    drupal'
alias pgadmin4-create='docker run --name pgadmin4 \
    --link pgDB:postgres \
    -p 5050:5050 \
    -e DEFAULT_USER=admin \
    -d fenglc/pgadmin4'
alias docker-run-postgres='docker run --name pgDB \
    -v ~/Devel/DB/docker/postgresql/data:/var/lib/postgresql/data \
    -p 5432:5432 \
    -e POSTGRES_PASSWORD=postgres \
    -d postgres'
alias docker-run-pgadmin='docker-run-postgres && pgadmin4-create'
alias docker-run-mosquitto='docker run -ti -p 1883:1883 -p 9001:9001 \
    -v ~/Devel/DB/docker/mosquitto/config:/mqtt/config:ro \
    -v ~/Devel/DB/docker/mosquitto/log:/mqtt/log \
    -v ~/Devel/DB/docker/mosquitto/data/:/mqtt/data/ \
    --name mqtt toke/mosquitto'

#PYTHON
#alias python='/usr/bin/python3'

# NEOVIM
alias vim='nvim'
# ******************************************************************************
# Other settingzs
# ******************************************************************************

# CONTEXT
DEFAULT_USER=$(whoami)

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # tmuxp completion
# autoload bashcompinit
# bashcompinit
# eval "$(_TMUXP_COMPLETE=source tmuxp)"

# Add user python packages directory to path
PATH=$PATH:~/.local/bin

# Terminal colors
export TERM=screen-256color

