# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
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
	grep -5 -nair "$1" /home/maur0x/.config/hexchat/logs/redhat-znc/*
}

export PS4='+(${BASH_SOURCE:-}:${LINENO:-}): ${FUNCNAME[0]:+${FUNCNAME[0]:-}(): }'

export HISTFILESIZE=100000
# User specific aliases and functions
[[ -f ~/.bashrc.git ]] && source ~/.bashrc.git

export PATH=$PATH:~/bin

