FROM centos

RUN yum install make git vim ctags -y

WORKDIR /opt

RUN curl -SL https://github.com/hongliang5316/shellconfig/archive/v1.1.tar.gz -o shellconfig.tar.gz \
    && tar zxvf shellconfig.tar.gz \
    && cd shellconfig-1.1 \
    && make install \
    && cd .. \
    && rm -rf shellconfig*

ENV TERM=xterm-256color

WORKDIR /opt

CMD ["vim"]
