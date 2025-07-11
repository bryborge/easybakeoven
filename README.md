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

### Installation

1.  Clone the project and change into the project directory.

    ```sh
    git clone https://github.com/bryborge/easybakeoven && cd $_
    ```

2.  Use podman compose to build the container.

    ```sh
    podman compose build
    ```

3.  Run the container and remote into it.

    ```sh
    podman compose run --build rpi_imagegen bash
    ```
