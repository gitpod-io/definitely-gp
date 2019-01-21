FROM gitpod/workspace-full-vnc

# Install Prerequisites
COPY compile /tmp
USER root
RUN cd /tmp && /tmp/compile && rm -rf /tmp/compile
USER gitpod