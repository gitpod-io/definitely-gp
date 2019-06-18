FROM gitpod/workspace-full-vnc

USER root

# Install the latest rr.
RUN __RR_VERSION__="5.2.0" \
 && cd /tmp \
 && wget -qO rr.deb https://github.com/mozilla/rr/releases/download/${__RR_VERSION__}/rr-${__RR_VERSION__}-Linux-$(uname -m).deb \
 && dpkg -i rr.deb \
 && rm -f rr.deb

# Install Firefox build dependencies.
# One-line setup command from:
# https://developer.mozilla.org/en-US/docs/Mozilla/Developer_guide/Build_Instructions/Linux_Prerequisites#Most_Distros_-_One_Line_Bootstrap_Command
RUN apt-get update \
 && apt-get install -y htop mercurial python-requests \
 && git clone https://github.com/mozilla/gecko/ /tmp/gecko \
 && cd /tmp/gecko \
 && python2.7 python/mozboot/bin/bootstrap.py --no-interactive --application-choice=browser \
 && rm -rf /tmp/gecko /var/lib/apt/lists/*

USER gitpod

# Install git-cinnabar.
RUN git clone https://github.com/glandium/git-cinnabar $HOME/.git-cinnabar \
 && $HOME/.git-cinnabar/git-cinnabar download \
 && echo "\n# Add git-cinnabar to the PATH." >> $HOME/.bashrc \
 && echo "PATH=\"\$PATH:$HOME/.git-cinnabar\"" >> $HOME/.bashrc
ENV PATH $PATH:$HOME/.git-cinnabar

# Install the latest Phabricator helper.
RUN mkdir $HOME/.phacility \
 && cd $HOME/.phacility \
 && git clone https://github.com/phacility/libphutil \
 && git clone https://github.com/phacility/arcanist \
 && echo "\n# Phabricator helper." >> $HOME/.bashrc \
 && echo "PATH=\"\$PATH:$HOME/.phacility/arcanist/bin\"" >> $HOME/.bashrc

# Install Phlay to support uploading multiple commits to Phabricator.
RUN git clone https://github.com/mystor/phlay/ $HOME/.phlay \
 && echo "\n# Add Phlay to the PATH." >> $HOME/.bashrc \
 && echo "PATH=\"\$PATH:$HOME/.phlay\"" >> $HOME/.bashrc

# Also install moz-phab to support uploading multiple commits to Phabricator.
RUN git clone https://github.com/mozilla-conduit/review/ /home/user/.moz-phab \
 && echo "\n# Add moz-phab to the PATH." >> /home/user/.bashrc \
 && echo "PATH=\"\$PATH:/home/user/.moz-phab\"" >> /home/user/.bashrc
