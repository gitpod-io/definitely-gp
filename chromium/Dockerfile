FROM gitpod/workspace-full-vnc:latest

USER root

# Install Chromium build dependencies
RUN apt update \
 && curl -L https://chromium.googlesource.com/chromium/src/+/master/build/install-build-deps.sh?format=TEXT | base64 --decode > /tmp/install-build-deps.sh \
 && sed -ri 's/\(trusty\|xenial\|artful\|bionic\)/(trusty|xenial|artful|bionic|cosmic)/' /tmp/install-build-deps.sh \
 && chmod +x /tmp/install-build-deps.sh \
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | debconf-set-selections \
 && /tmp/install-build-deps.sh --no-prompt --no-arm --no-chromeos-fonts --no-nacl \
 && wget -qO /tmp/libgcrypt11.deb https://launchpad.net/ubuntu/+archive/primary/+files/libgcrypt11_1.5.3-2ubuntu4.2_amd64.deb \
 && dpkg -i /tmp/libgcrypt11.deb \
 && rm -rf /tmp/install-build-deps.sh /tmp/libgcrypt11.deb /var/lib/apt/lists/*

# Install the latest Ninja.
RUN git clone https://github.com/ninja-build/ninja /tmp/ninja \
 && cd /tmp/ninja \
 && git checkout v1.8.2 \
 && ./configure.py --bootstrap \
 && mv ninja /usr/bin/ninja \
 && mv misc/bash-completion /home/gitpod/.ninja-bash-completion \
 && mv misc/zsh-completion /home/gitpod/.ninja-zsh-completion \
 && echo "\n# Ninja completion helpers." >> /home/gitpod/.bashrc \
 && echo ". /home/gitpod/.ninja-bash-completion" >> /home/gitpod/.bashrc \
 && rm -rf /tmp/ninja

USER gitpod

# Install Chromium's depot_tools.
RUN git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git /home/gitpod/depot_tools
ENV PATH $PATH:/home/gitpod/depot_tools
RUN echo "\n# Add Chromium's depot_tools to the PATH." >> /home/gitpod/.bashrc \
 && echo "export PATH=\"\$PATH:/home/gitpod/depot_tools\"" >> /home/gitpod/.bashrc

# Enable bash completion for git cl.
RUN echo "\n# The next line enables bash completion for git cl." >> /home/gitpod/.bashrc \
 && echo "if [ -f \"/home/gitpod/depot_tools/git_cl_completion.sh\" ]; then" >> /home/gitpod/.bashrc \
 && echo "  . \"/home/gitpod/depot_tools/git_cl_completion.sh\"" >> /home/gitpod/.bashrc \
 && echo "fi" >> /home/gitpod/.bashrc

# Disable gyp_chromium for faster updates.
ENV GYP_CHROMIUM_NO_ACTION 1
RUN echo "\n# Disable gyp_chromium for faster updates." >> /home/gitpod/.bashrc \
&& echo "export GYP_CHROMIUM_NO_ACTION=1" >> /home/gitpod/.bashrc

# Give back control.
USER root
