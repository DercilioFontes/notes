# [docker](https://docs.docker.com)

- Docker client: `docker` command.

- Docker server: `dockerd` command.

- The `ARG` parameter provides a way for you to set variables and their default values, which are only available during the image build process. You can provide a new value for the `ARG` via the `--build-arg` command-line argument to `docker image build`.

```fish
docker image build --build-arg email=dercilio@example.com \
    -t example/docker-node-hello:latest .
```

- Unlike the `ARG` instruction, the `ENV` instruction allows you to set shell variables that can be used by your running application for configuration, in addition to being available during the build process. You also add environment variable with `--env` argument to`docker container run` command.

```fish
docker container run --rm -d \
  --publish mode=ingress,published=8080,target=8080 \
  --env WHO="Mike Ross" \
  example/docker-node-hello:latest
```

- Applying labels (`LABEL`) to images and containers allows you to add metadata via key/value pairs that can later be used to search for and identify Docker images and containers. You can see the labels applied to any image using the `docker image inspect` command.

- By default, Docker runs all processes as `root` within the container, but you can use the `USER` instruction to change this.

- You’ll use a collection of `RUN` instructions to start and create the required file structure that you need, and install some required software dependencies.

- The `COPY` instruction is used to copy files from the local filesystem into your image.

- With the `WORKDIR` instruction, you change the working directory in the image for the remaining build instructions and the default process that launches with any resulting containers.

- And finally, you end with the `CMD` instruction, which defines the command that launches the process that you want to run within the container.

- Using `docker image build` is functionally the same as using `docker build`.

  - Example: `docker image build -t example/docker-node-hello:latest .`

- Once you have successfully built the image, you can run it on your Docker host with the following command `docker container run`.

  - Example: `docker container run --rm -d -p 8080:8080 example/docker-node-hello:latest`

- You can verify containers running by `docker container ls`.

- You inspect a image with `docker image inspect <image-name>`.

- You can stop the running container by typing `docker container stop <container-id>`.

- Log in to the Docker Hub registry with `docker login`.

- You can also log out of a registry if you no longer want to cache the credentials with `docker logout`.

- When you are going to upload your image to a real registry, you need the registry and repository name to match the login. You can easily edit the tags on the image that you already created by running the following command and replacing `<myuser>` with your Docker Hub username.

```fish
docker image tag example/docker-node-hello:latest \
    docker.io/<myuser>/docker-node-hello:latest
```

- You can upload the image to the Docker repository by using the `docker image push` command.

- If the image was uploaded to a public repository, anyone in the world can now easily download it by running the `docker image pull` command.

  - Example: `docker image pull dercilio/docker-node-hello:latest`

- You can also use the `docker search` command to find images that might be useful.

  - Example: `docker search node`

## Reference

- [“Docker: Up & Running, 3e, by Sean P. Kane with Karl Matthias (O’Reilly). Copyright 2023 Sean P. Kane and Karl Matthias, 978-1-098-13182-1.”](https://learning.oreilly.com/library/view/docker-up/9781098131814/)
