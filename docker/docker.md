# [docker](https://docs.docker.com)

- Docker client: `docker` command

- Docker server: `dockerd` command

- The `ARG` parameter provides a way for you to set variables and their default values, which are only available during the image build process.

- Unlike the `ARG` instruction, the `ENV` instruction allows you to set shell variables that can be used by your running application for configuration, in addition to being available during the build process.

- Applying labels (`LABEL`) to images and containers allows you to add metadata via key/value pairs that can later be used to search for and identify Docker images and containers. You can see the labels applied to any image using the `docker image inspect` command.

- By default, Docker runs all processes as `root` within the container, but you can use the `USER` instruction to change this

- You’ll use a collection of `RUN` instructions to start and create the required file structure that you need, and install some required software dependencies.

- The `COPY` instruction is used to copy files from the local filesystem into your image.

- With the `WORKDIR` instruction, you change the working directory in the image for the remaining build instructions and the default process that launches with any resulting containers.

- And finally, you end with the `CMD` instruction, which defines the command that launches the process that you want to run within the container.