set -e

cd $(dirname "$0")

gcc_version=9.3.0

CI_REGISTRY_IMAGE=ghcr.io/ssrobins/docker-linux-build


docker build --pull --tag "$CI_REGISTRY_IMAGE:gcc$gcc_version" . --build-arg "gcc_version=$gcc_version"
