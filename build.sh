set -e

cd $(dirname "$0")

gcc_version=10.3.0

if [ -z "$DOCKER_IMAGE_NAME" ]; then
    DOCKER_IMAGE_NAME=docker-linux-build
fi

docker build --pull --tag "$DOCKER_IMAGE_NAME:gcc$gcc_version" . --build-arg "gcc_version=$gcc_version"
