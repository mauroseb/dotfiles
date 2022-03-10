# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# Set shell options
shopt -s cdspell dirspell histappend checkwinsize

# Some generic aliases and functions
validate_yaml() {
    ruby -ryaml -e "YAML.load_file '$1'"
}

validate_erb() {
    erb -P -x -T '-' $1 | ruby -c
}

jsonize() {
	python -m json.tool $1
}

chatlog() {
	grep -5 -nair "$1" ${HOME}/.config/hexchat/logs/*/*
}

# Debug prompt for shell scripts
export PS4='+(${BASH_SOURCE:-}:${LINENO:-}): ${FUNCNAME[0]:+${FUNCNAME[0]:-}(): }'

export HISTSIZE=10000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTCONTROL=ignoredups

export PATH=$PATH:$HOME/bin:$HOME/.local/bin

# cat clone with wings
alias cat=bat

# Git specific vars, aliases and functions
[[ -f ~/.bashrc.git ]] && source ~/.bashrc.git

# k8s specific vars, aliases and functions
[[ -f ~/.bashrc.k8s ]] && source ~/.bashrc.k8s

# Ansible specific vars, aliases and functions
[[ -f ~/.bashrc.ansible ]] && source ~/.bashrc.ansible

# Go vars
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

