# Starship
eval "$(starship init zsh)"


# XBOXDRV
alias gamepad-xbox='sudo xboxdrv --device-by-id 0xffff:0xffff --type xbox360 --silent --force-feedback'
alias gamepad-n64='sudo xboxdrv --device-by-id 0xffff:0xffff --type xbox360 --silent --force-feedback --trigger-as-button'
alias gamepad-ps3='sudo xboxdrv --type xbox360 --silent --force-feedback --trigger-as-button --detach-kernel-driver'

alias docker='podman'
alias docker-run-mosquitto='docker run -ti -p 1883:1883 -p 9001:9001 \
    -v ~/Devel/DB/docker/mosquitto/config:/mqtt/config:ro \
    -v ~/Devel/DB/docker/mosquitto/log:/mqtt/log \
    -v ~/Devel/DB/docker/mosquitto/data/:/mqtt/data/ \
    --name mqtt toke/mosquitto'

# NEOVIM
alias vim='nvim'

alias htop='ytop'
alias du='dust'
alias cat='bat'
alias grep='rg'
alias exa='exa --long --header --git'
alias ls='exa'

alias dnfi='sudo dnf install'
alias dnfr='sudo dnf remove'
alias dnfs='dnf search'
alias dnfu='sudo dnf update'
alias docker='podman'
alias gd='git diff'
alias gdc='git diff --cached'
alias glog='git log --graph --all --oneline'
alias gst='git status'

# ******************************************************************************
# Other settings
# ******************************************************************************

# FZF Configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # tmuxp completion
# autoload bashcompinit
# bashcompinit
# eval "$(_TMUXP_COMPLETE=source tmuxp)"

# Add user python packages directory to path
path+=("~/.local/bin")
[ -d ~/.cargo/bin ] && path+=("~/.cargo/bin")
export PATH

# Terminal colors
export TERM=screen-256color

