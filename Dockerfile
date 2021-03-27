ARG gcc_version
FROM gcc:$gcc_version

# CMake
ARG cmake_version=3.20.0
ARG cmake_installer=cmake-$cmake_version-Linux-x86_64.sh
RUN wget --no-verbose https://github.com/Kitware/CMake/releases/download/v$cmake_version/$cmake_installer \
&& sh ./$cmake_installer --prefix=/usr --skip-license \
&& rm $cmake_installer
RUN if [ "$cmake_version" != "$(cmake --version | head -n 1 | cut -d ' ' -f3)" ]; then echo "CMake version $cmake_version not found!"; exit 1; fi

# Ninja
ARG ninja_version=1.10.2
ARG ninja_zip=ninja-linux.zip
RUN wget --no-verbose https://github.com/ninja-build/ninja/releases/download/v$ninja_version/$ninja_zip \
&& unzip $ninja_zip \
&& cp ninja /usr/bin/ \
&& rm $ninja_zip
RUN if [ "$ninja_version" != "$(ninja --version)" ]; then echo "Ninja version $ninja_version not found!"; exit 1; fi

# Conan
ARG conan_version=1.34.1
RUN apt-get update \
&& apt-get install --no-install-recommends -y python3-pip python3-setuptools python3-wheel \
&& pip3 install conan==$conan_version \
&& apt-get autoremove -y \
&& rm -rf /var/lib/apt/lists/*
RUN if [ "$conan_version" != "$(conan --version | grep Conan | cut -d ' ' -f3)" ]; then echo "Conan version $conan_version not found!"; exit 1; fi

RUN gcc --version
