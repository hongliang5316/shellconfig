FROM centos:7

RUN yum install wget make automake gcc openssl-devel curl-devel expat-devel gettext ncurses-devel libevent-devel zsh which sudo -y

ENV PATH="/usr/local/go/bin:/root/.cargo/bin:/root/bin:${PATH}"
ENV SHELL="/usr/bin/zsh"

WORKDIR /opt

# install ctags
RUN wget https://github.com/universal-ctags/ctags/archive/refs/tags/p5.9.20220123.0.tar.gz \
    && tar zxvf p5.9.20220123.0.tar.gz \
    && cd ctags-p5.9.20220123.0 \
    && ./autogen.sh \
    && ./configure \
    && make -j8 \
    && make install \
    && cd .. \
    && rm -rf p5.9.20220123.0.tar.gz ctags-p5.9.20220123.0

# install git
RUN wget https://github.com/git/git/archive/refs/tags/v2.34.1.tar.gz \
    && tar zxvf v2.34.1.tar.gz \
    && cd git-2.34.1 \
    && make -j8 \
    && make install \
    && cd .. \
    && rm -rf v2.34.1.tar.gz git-2.34.1

# install vim
RUN wget https://github.com/vim/vim/archive/refs/tags/v8.2.4186.tar.gz \
    && tar zxvf v8.2.4186.tar.gz \
    && cd vim-8.2.4186 \
    && ./configure \
    && make -j8 \
    && make install \
    && cd .. \
    && rm -rf v8.2.4186.tar.gz vim-8.2.4186

# install tmux
RUN wget https://github.com/tmux/tmux/archive/refs/tags/2.7.tar.gz \
    && tar zxvf 2.7.tar.gz \
    && cd tmux-2.7 \
    && ./autogen.sh \
    && ./configure \
    && make -j8 \
    && make install \
    && cd .. \
    && rm -rf 2.7.tar.gz tmux-2.7

# install oh-my-zsh
RUN chsh -s $(which zsh) \
    && sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-syntax-highlighting
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install dircolors-solarized
RUN git clone https://github.com/seebi/dircolors-solarized.git \
    && mv dircolors-solarized /root/

# install shellconfig
RUN wget https://github.com/hongliang5316/shellconfig/archive/refs/tags/v1.4.tar.gz \
    && tar zxvf v1.4.tar.gz \
    && cd shellconfig-1.4 \
    && make zsh-install \
    && cd .. \
    && rm -rf v1.4.tar.gz shellconfig-1.4

# install golang
RUN wget https://go.dev/dl/go1.16.13.linux-amd64.tar.gz \
    && tar zxvf go1.16.13.linux-amd64.tar.gz \
    && mv go /usr/local/ \
    && rm -rf go1.16.13.linux-amd64.tar.gz

# install cargo
RUN curl https://sh.rustup.rs -o cargo-install.sh \
    && chmod +x cargo-install.sh \
    && ./cargo-install.sh -y \
    && rm -rf cargo-install.sh
