FROM gcc:8.2.0

# CMake
ARG cmake_version_major=3
ARG cmake_version_minor=13
ARG cmake_version_patch=0-rc2
ARG cmake_installer=cmake-$cmake_version_major.$cmake_version_minor.$cmake_version_patch-Linux-x86_64.sh
RUN wget --no-verbose https://cmake.org/files/v$cmake_version_major.$cmake_version_minor/$cmake_installer
RUN sh ./$cmake_installer --prefix=/usr --skip-license
RUN rm $cmake_installer

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

# Run 'conan new' to create a default profile then update it
# to prevent an 'OLD ABI' warning.
RUN mkdir test; \
    cd test; \
    conan new test/0.0.1@steve/testing; \
    conan install .; \
    sed -i 's/libstdc++/libstdc++11/' /root/.conan/profiles/default; \
    cd ..; \
    rm -rf test

RUN gcc --version
RUN cmake --version
RUN conan --version
