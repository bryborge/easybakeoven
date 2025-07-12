#!/bin/bash

set -e

RECIPE_NAME="$1"

check_prerequisites() {
    echo "Checking prerequisites ..."

    if [ ! -f "compose.yml" ]; then
        echo "compose.yml not found. Please run this script from the project root directory."
        exit 1
    fi
}

run_container_build() {
    echo "Starting container and launching image build process ..."
    echo -e "This will build the container if needed and run the image generation process.\n"

    exec podman compose run --remove-orphans --build rpi_imagegen bash -c "
        /home/imagegen/generate-artifact.sh $RECIPE_NAME
    "
}

main() {
    if [ -z "$RECIPE_NAME" ]; then
        echo "Error: Recipe name is required"
        exit 1
    fi

    check_prerequisites
    run_container_build
}

main "$@"
