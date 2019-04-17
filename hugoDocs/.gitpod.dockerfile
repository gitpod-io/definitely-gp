FROM gitpod/workspace-full

# install hugo
RUN wget -qO- https://github.com/gohugoio/hugo/releases/download/v0.52/hugo_0.52_Linux-64bit.tar.gz | tar xvz -C /usr/bin
