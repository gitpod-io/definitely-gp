FROM gitpod/workspace-full

# add your tools here
RUN apt-get update --fix-missing \
    && apt-get install -y graphviz

USER gitpod
RUN /home/gitpod/.cargo/bin/cargo install mdbook --vers 0.1.7
