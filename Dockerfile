FROM gcc:8.2.0

# CMake
ENV cmake_version_major 3
ENV cmake_version_minor 13
ENV cmake_version_patch 0-rc2
ENV cmake_installer cmake-$cmake_version_major.$cmake_version_minor.$cmake_version_patch-Linux-x86_64.sh
RUN wget --no-verbose https://cmake.org/files/v$cmake_version_major.$cmake_version_minor/$cmake_installer
RUN sh ./$cmake_installer --prefix=/usr --skip-license
RUN cmake --version

RUN apt-get update && apt-get install -y \
  # Conan prerequisite
  python3-pip \
  # SDL2 prerequisites
  freeglut3-dev \
  libasound2-dev \
  # SFML prerequisites
  libflac-dev \
  libfreetype6-dev \
  libjpeg-dev \
  libopenal-dev \
  libudev-dev \
  libvorbis-dev \
  libxrandr-dev

RUN pip3 install conan
RUN conan --version
