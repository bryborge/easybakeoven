#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

generate_opts_file() {
    local recipe_name="$1"
    local recipe_dir="/home/imagegen/recipes/$recipe_name"

    cp "$recipe_dir/my.options.tmpl" "$recipe_dir/my.options"
}

set_user_opts() {
    local recipe_name="$1"

    echo
    read -p "Enter a hostname: " hostname
    read -p "Enter a username: " username
    read -p "Enter a password: " password
    echo

    opts_file="/home/imagegen/recipes/$recipe_name/my.options"

    echo "device_hostname=$hostname" >> $opts_file
    echo "device_user1=$username" >> $opts_file
    echo "device_user1pass=$password" >> $opts_file
}

mount_binfmt_misc() {
    print_info "Mounting binfmt_misc ..."
    print_warning "Enter the imagegen user's password (imagegen)!"

    if sudo mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc;
    then
        print_success "binfmt_misc mounted successfully."
    else
        print_error "Failed to mount binfmt_misc."
        exit 1
    fi
}

build_image() {
    local recipe_name="$1"
    local recipe_dir="/home/imagegen/recipes/$recipe_name"

    print_info "Using recipe: $recipe_name"
    print_info "Recipe directory: $recipe_dir"

    local options_file="$recipe_dir/my.options"
    if [ ! -f "$options_file" ]; then
        print_error "Configuration file not found: $options_file"
        exit 1
    fi

    local config_file="$recipe_dir/config/$recipe_name.cfg"
    local image_name=$(awk '/^\[image\]/{flag=1; next} flag && /^name=/{sub(/^name=/, ""); print; exit} /^\[.*\]$/{flag=0}' "$config_file")

    if [ -z "$image_name" ]; then
        print_error "Could not find name= under [image] section in config file: $config_file"
        exit 1
    fi

    if ./build.sh -D "$recipe_dir" -c "$recipe_name" -o "$options_file";
    then
        print_success "Baking finished successfully!"

        out_dir="/home/imagegen/_out/$(date +'%d%m%Y-%H%M%S')"
        print_info "Creating output directory: $out_dir"

        if mkdir -p "$out_dir" && cd "$out_dir";
        then
            cp -r /home/imagegen/rpi-image-gen/work/${image_name}/deploy/* .
            print_success "Generated files copied to output directory."
            print_info "Building artifacts location: $out_dir \n"
            print_info "Files generated:"
            ls -la
        else
            print_warning "Could not create output directory. Files remain in:"
            print_warning "/home/imagegen/rpi-image-gen/work/"
        fi
    else
        print_error "Image build failed!"
        exit 1
    fi
}

main() {
    local recipe_name="$1"

    cat << "EOF"
   _____                 ______       _          _____
  |  ___|                | ___ \     | |        |  _  |
  | |__  __ _ ___ _   _  | |_/ / __ _| | _____  | | | |_   _____ _ __
  |  __|/ _` / __| | | | | ___ \/ _` | |/ / _ \ | | | \ \ / / _ \ '_ \
  | |__| (_| \__ \ |_| | | |_/ / (_| |   <  __/ \ \_/ /\ V /  __/ | | |
  \____/\__,_|___/\__, | \____/ \__,_|_|\_\___|  \___/  \_/ \___|_| |_|
                   __/ |
                  |___/
EOF
    generate_opts_file "$recipe_name"
    set_user_opts "$recipe_name"
    # TODO: Only run this if host has non-ARM cpu architecture.
    mount_binfmt_misc
    build_image "$recipe_name"

    print_success "Image generation process completed!"
}

main "$@"
