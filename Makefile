
.PHONY: all test install docker-build

all: ;

install: all
	cp -r .vim ~/
	cp -r .vimrc ~/
	cp -r .screenrc ~/
	cp -r .gitconfig ~/
	cp -r .bashrc ~/
	cp -r .gdbinit ~/
	cp -r .tmux.conf ~/
	cp -r .myclirc ~/

zsh-install:
	echo 'You should install zsh & oh-my-zsh'
	cp -r .vim ~/
	cp -r .vimrc ~/
	cp -r .screenrc ~/
	cp -r .gitconfig ~/
	cp -r .bashrc ~/
	cp -r .gdbinit ~/
	cp -r .tmux.conf ~/
	cp -r .myclirc ~/
	cp -r .zshrc ~/
	cp -r agnoster.zsh-theme.modify ~/.oh-my-zsh/themes/agnoster.zsh-theme

docker-build:
	docker build -t docker-env .
