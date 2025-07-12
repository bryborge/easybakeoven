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

**TODO:** script out a process to easily create a new recipe from template

TBD ...

### Generating an Artifact

To kick off the artifact generation process, simply run the `generate.sh`
convenience script at the root of the project and pass in the name of the
recipe you want to generate an artifact against.

For example, generate an image from the provided template recipe:

```sh
./generate.sh _template
```
