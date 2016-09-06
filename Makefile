VIM_RUNTIME=~/.vim

.PHONY: all test install

all: ;

install: all
	cp -r autoload $(VIM_RUNTIME)/
	cp -r colors $(VIM_RUNTIME)/
	cp -r ftplugin $(VIM_RUNTIME)/
	cp -r indent $(VIM_RUNTIME)/
	cp -r record $(VIM_RUNTIME)/
	cp -r syntax $(VIM_RUNTIME)/
	cp -r tools $(VIM_RUNTIME)/
	cp -r .vimrc ~/
	cp -r .screenrc ~/
