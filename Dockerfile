FROM gcc:8.2.0

# CMake
ENV cmake_version_major 3
ENV cmake_version_minor 13
ENV cmake_version_patch 0-rc2
ENV cmake_installer cmake-$cmake_version_major.$cmake_version_minor.$cmake_version_patch-Linux-x86_64.sh
RUN wget --no-verbose https://cmake.org/files/v$cmake_version_major.$cmake_version_minor/$cmake_installer
RUN sh ./$cmake_installer --prefix=/usr --skip-license

# SDL2 prerequisites
RUN apt-get update && apt-get install -y \
  freeglut3-dev \
  libasound2-dev

# SFML prerequisites
RUN apt-get update && apt-get install -y \
  libflac-dev \
  libfreetype6-dev \
  libjpeg-dev \
  libopenal-dev \
  libudev-dev \
  libvorbis-dev \
  libxrandr-dev
