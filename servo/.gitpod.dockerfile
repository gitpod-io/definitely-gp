FROM gitpod/workspace-full-vnc

USER root

# Install the latest rr.
RUN __RR_VERSION__="5.2.0" \
 && cd /tmp \
 && wget -qO rr.deb https://github.com/mozilla/rr/releases/download/${__RR_VERSION__}/rr-${__RR_VERSION__}-Linux-$(uname -m).deb \
 && sudo dpkg -i rr.deb \
 && rm -f rr.deb

# Install Servo build dependencies.
# Packages are from https://github.com/servo/servo/blob/master/README.md#on-debian-based-linuxes
# and https://github.com/servo/servo/issues/7512#issuecomment-216665988
RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends htop python-dev \
  git \
  curl \
  autoconf \
  libx11-dev \
  libfreetype6-dev \
  libgl1-mesa-dri \
  libglib2.0-dev \
  xorg-dev \
  gperf \
  g++ \
  build-essential \
  cmake \
  virtualenv \
  python-pip \
  libssl1.0-dev \
  libbz2-dev \
  liblzma-dev \
  libosmesa6-dev \
  libxmu6 \
  libxmu-dev \
  libglu1-mesa-dev \
  libgles2-mesa-dev \
  libegl1-mesa-dev \
  libdbus-1-dev \
  libharfbuzz-dev \
  ccache \
  libunwind-dev \
  libgstreamer1.0-dev \
  libgstreamer-plugins-base1.0-dev \
  libgstreamer-plugins-bad1.0-dev \
  autoconf2.13 \
  xserver-xorg-input-void \
  xserver-xorg-video-dummy \
  xpra \
&& rm -rf /var/lib/apt/lists/*

# Enable required Xvfb extensions for Servo.
# Source: https://github.com/servo/servo/issues/7512#issuecomment-216665988
RUN sed -i "s/\(Xvfb .*\)&\s*$/\1+extension RANDR +extension RENDER +extension GLX \&/" /usr/bin/start-vnc-session.sh
# FIXME: Maybe also add "-pn" ?
