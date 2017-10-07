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
alias grep='grep --color'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export VISUAL='vim'

export TERM='xterm-256color'

PATH=$PATH:$HOME/bin

export GPG_TTY=$(tty)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)
