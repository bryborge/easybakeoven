# Easy Bake Oven

The [Easy-Bake Oven](https://en.wikipedia.org/wiki/Easy-Bake_Oven) is a toy that
was first introduced to the market in 1964. I didn't actually know that until I
started thinking about what to name this project. But it seems so fitting,
right? Easy-Bake Oven is a functional toy used to bake things like biscuits and
cookies. This project is a functional "toy" that I use to "bake" custom golden
Raspberry Pi images. Unlike confectionaries however, the images are not tasty.
But the process is satisfying all the same.

## Getting Started

These instructions will walk you through the process of setting up this project
on a development system.

### Prerequisites

- [Podman](https://docs.podman.io/en/latest/)
- [Podman Compose](https://github.com/containers/podman-compose)
    - (This ships with Podman by default)

### Defining a New Recipe

**TODO:** script out a process to easily create a new recipe from base.

TBD ...

### Baking an Artifact

1.  You'll want to set the `device_hostname`, `device_user1`, and
    `device_user1pass` in the `my.options` file for your preferred recipe.

2.  To kick off the artifact generation process, simply run the `bake.sh`
    convenience script at the root of the project and pass in the name of the
    recipe you want to follow.

    For example, generate an image from the provided base recipe:

    ```sh
    ./bake.sh base
    ```
