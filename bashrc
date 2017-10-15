# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# VirtualenvWrapper Settings
export WORKON_HOME=~/.virtualenvs # Work directory
source /usr/bin/virtualenvwrapper.sh # Source of wrapper commands

# Firefox geckodriver
PATH=$PATH:/opt/geckodriver
#so as not to be disturbed by Ctrl-S ctrl-Q in terminals:
stty -ixon

# tmuxp completion
eval "$(_TMUXP_COMPLETE=. tmuxp)"
export DISABLE_AUTO_TITLE='true'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
