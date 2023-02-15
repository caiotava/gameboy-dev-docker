# GameBoy Dev Docker

[![Build Image](https://github.com/caiotava/gameboy-dev-docker/actions/workflows/docker-image.yml/badge.svg?branch=main)](https://github.com/caiotava/gameboy-dev-docker/actions/workflows/docker-image.yml/badge.svg?branch=main)

GameBoy Dev Docker is a docker image that gathers a bunch of compilers and  tools used to develop `GameBoy` games.

The main aims of this project are:
1. Avoid installing and configuring these compilers and tools in your local machine.
2. Create a stable, easily and cross-platform environment for newcomers.
3. Be a reliable option of pre-built image for continuous integration.

## Available compilers and tools:
#### Assemblers and Compilers
- [RGBDS](https://github.com/gbdev/rgbds) - Assembler and linker package. [Documentation](https://rgbds.gbdev.io/docs/).
- [GBDK](https://github.com/gbdk-2020/gbdk-2020/) - Maintained and modernized GBDK (Game Boy Development Kit) powered by an updated version of the SDCC toolchain. Provides a C compiler, assembler, linker and a set of libraries.
- [gbdk-go](https://github.com/pokemium/gbdk-go) - A compiler translates Go programs to C code. The output C code is built into GB ROM by GBDK.

#### Graphics utilities
- [bmp2cgb](https://github.com/gitendo/bmp2cgb) - Graphics converter for Game Boy Color development providing real time palette adjustments.
- [png2gb](https://github.com/LuckyLights/png2gb) - CLI tool to convert image file to game boy .c array.

#### Other Compilers/Dev Tools
- Gcc
- G++
- Make
- CMake
- Git
- Golang


___

## Usage

### 1. Compiling your projects

This is an example of how to compile a HelloWorld ROM using GDBK.

```shell
# We'll use the root folder of `gameboy-dev-docker` as example in this case.
$ docker run -v $PWD:/app -w /app caiotava/gameboy-dev lcc -o game.gb examples/hello_world.c
```

### 2. Compiling Pokemon Red

```bash
# First, we need to remove the pokemon-builder container
# if, for some reason, it has already existed.
$ docker rm -f pokemon-builder

# Start a new docker container with the name `pokemon-builder`.
$ docker run -t -d --name pokemon-builder --entrypoint /bin/bash caiotava/gameboy-dev

# Cloning the Pokemon Red repository inside our docker container.
$ docker exec pokemon-builder git clone --recursive https://github.com/pret/pokered.git --shallow-since=2021-04-01 --single-branch

# Compiling Pokemon Red using RGBDs.
$ docker exec -w /pokered pokemon-builder make -j4 compare

# Copying the rom compiled from the docker container to your machine.
$ docker cp pokemon-builder:/pokered/pokered.gbc .
```

## Building the docker image from Dockerfile

```shell
# This recipe will build the image and tag it as: `caiotava/gameboy-dev`
$ make build-docker-image
```

## Contributing

Have you missed some compiler, tool, or lib?

Just create a new PR adding it in the Dockerfile and README.