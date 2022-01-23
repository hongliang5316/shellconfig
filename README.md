# Docker

docker pull hongliang5316/my-work-env:v1.0.2

# shellconfig

include item2 vim git tmux config

NOTE: This is only for Centos & MacOS

VIM version: v8.0+

TMUX version: v2.6+

GIT version: 2.15+


# configure vim on Centos7.x

```bash

 yum install git gcc gcc-c++ ncurses-devel ctags -y
 cd /opt
 curl -SL "https://github.com/vim/vim/archive/v8.0.1241.tar.gz" -o vim-8.0.1241.tar.gz
 tar zxvf vim-8.0.1241.tar.gz
 cd vim-8.0.1241
 ./configure
 make
 make install
 cd ..
 rm -rf vim*

 git clone https://github.com/hongliang5316/shellconfig.git
 cd shellconfig
 cp -R .vim /root/
 cp -R .vimrc /root/

 export TERM=xterm-256color
```

NOTE: the theme of vim used [solarized dark](https://github.com/altercation/solarized)
