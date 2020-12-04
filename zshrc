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
PATH=$PATH:~/.local/bin:~/.cargo/bin

# Terminal colors
export TERM=screen-256color

