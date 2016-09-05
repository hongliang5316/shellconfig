# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ls='ls --color=auto'
alias ll='ls -al'
alias g='git'
alias mk='make'
alias v='vim'
alias mkt='make test'
alias mkb='make build'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export VISUAL='vim'

PATH=$PATH:$HOME/bin

