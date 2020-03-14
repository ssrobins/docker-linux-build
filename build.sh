set -e

cd $(dirname "$0")

gcc_version=9.3.0

if [ -z "$CI_REGISTRY_IMAGE" ]; then
    CI_REGISTRY_IMAGE=docker-linux-build
fi

docker build --pull --tag "$CI_REGISTRY_IMAGE:gcc$gcc_version" . --build-arg "gcc_version=$gcc_version"
