
.PHONY: all test install

all: ;

install: all
	cp -r .vim ~/
	cp -r .vimrc ~/
	cp -r .screenrc ~/
	cp -r .gitconfig ~/
	cp -r .bashrc ~/
