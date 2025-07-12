#!/bin/bash

# This script provides a simple entry point from the project root.

set -e

if [ $# -eq 0 ]; then
    echo -e "Usage: $0 <recipe-name>\n"
    echo "Available recipes:"

    ls -1 recipes/ | grep -v '^_' || echo -e "\tNo recipes found"
    exit 1
fi

RECIPE_NAME="$1"

if [ ! -d "recipes/$RECIPE_NAME" ]; then
    echo "Error: Recipe '$RECIPE_NAME' not found in recipes/ directory"
    exit 1
fi

exec ./scripts/build-env.sh "$RECIPE_NAME"
