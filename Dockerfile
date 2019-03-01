FROM gcc:8.2.0

RUN apt-get update && apt-get install -y \
python3-pip \
# SDL2 prerequisites
freeglut3-dev \
libasound2-dev \
libusb-dev \
# SFML prerequisites
libflac-dev \
libfreetype6-dev \
libjpeg-dev \
libopenal-dev \
libudev-dev \
libvorbis-dev \
libxrandr-dev

# CMake
ARG cmake_version_major=3
ARG cmake_version_minor=14
ARG cmake_version_patch=0-rc1
ARG cmake_version_full=$cmake_version_major.$cmake_version_minor.$cmake_version_patch
ARG cmake_installer=cmake-$cmake_version_full-Linux-x86_64.sh
RUN wget --no-verbose https://cmake.org/files/v$cmake_version_major.$cmake_version_minor/$cmake_installer
RUN sh ./$cmake_installer --prefix=/usr --skip-license
RUN rm $cmake_installer
RUN if [ "$cmake_version_full" != "$(cmake --version | head -n 1 | cut -d ' ' -f3)" ]; then echo "CMake version $cmake_version_full not found!"; exit 1; fi

# Conan
ARG conan_version=1.12.3
RUN pip3 install conan==$conan_version
RUN if [ "$conan_version" != "$(conan --version | grep Conan | cut -d ' ' -f3)" ]; then echo "Conan version $conan_version not found!"; exit 1; fi
RUN conan remote add conan https://api.bintray.com/conan/stever/conan

# Run 'conan new' to create a default profile then update it
# to prevent an 'OLD ABI' warning.
RUN mkdir test && \
cd test && \
conan new test/0.0.1@steve/testing && \
conan install . && \
sed -i 's/libstdc++/libstdc++11/' /root/.conan/profiles/default && \
cd .. && \
rm -rf test

RUN gcc --version