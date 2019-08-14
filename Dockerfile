FROM gcc:9.2.0

RUN apt-get update && apt-get install --no-install-recommends -y \
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
libxrandr-dev && \
rm -rf /var/lib/apt/lists/*

# CMake
ARG cmake_version_major=3
ARG cmake_version_minor=15
ARG cmake_version_patch=2
ARG cmake_version_full=$cmake_version_major.$cmake_version_minor.$cmake_version_patch
ARG cmake_installer=cmake-$cmake_version_full-Linux-x86_64.sh
RUN wget --no-verbose https://cmake.org/files/v$cmake_version_major.$cmake_version_minor/$cmake_installer && \
sh ./$cmake_installer --prefix=/usr --skip-license && \
rm $cmake_installer
RUN if [ "$cmake_version_full" != "$(cmake --version | head -n 1 | cut -d ' ' -f3)" ]; then echo "CMake version $cmake_version_full not found!"; exit 1; fi

# Conan
ARG conan_version=1.18.1
RUN apt-get update && apt-get install --no-install-recommends -y \
python3-dev python3-pip python3-setuptools python3-wheel && \
pip3 install conan==$conan_version && \
apt-get remove -y \
python3-dev python3-pip python3-setuptools python3-wheel && \
rm -rf /var/lib/apt/lists/*
RUN if [ "$conan_version" != "$(conan --version | grep Conan | cut -d ' ' -f3)" ]; then echo "Conan version $conan_version not found!"; exit 1; fi

RUN gcc --version
