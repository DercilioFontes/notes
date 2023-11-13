# [docker](https://docs.docker.com)

- Docker client: `docker` command.

- Docker server: `dockerd` command.

- Dockerfile: [reference](https://docs.docker.com/engine/reference/builder/)

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

- You can verify images available by `docker image ls`.

- You can verify containers running by `docker container ls`.

- You inspect a image with `docker image inspect <image-name>`.

- You can stop the running container by typing `docker container stop <container-name/id>`.

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

- You can then use the container ID to export the files in the container into a tarball.

  - Example: `docker container export <container-name/id> -o web-app.tar`

- There is a way you can constrain containers to an even smaller size in many cases: **multistage builds**. This is how we recommend that you build most production containers. You don’t have to worry as much about bringing in extra resources to build your application, and you can still run a lean production container. Multistage containers also encourage doing builds inside Docker, which is a great pattern for repeatability in your build system.

  - Example: [multi-stage.dockerfile](./multi-stage.dockerfile)

> ["Ship artifacts, not build environments."](https://medium.com/@adriaandejonge/simplify-the-smallest-possible-docker-image-62c0e0d342ef)

- You can define a specific Dockerfile by using flag `-f`

  - Example : `docker image build -f multi-stage.dockerfile .`

- You can see the history of an image with `docker image history <image-name>` command.

- An important thing to understand is that image layers are strictly additive in nature. Once a layer is created, nothing can be removed from it. This means that you cannot make earlier layers in an image smaller by deleting files in subsequent layers. When you delete or edit files in subsequent layers, you’re simply masking the older version with the modified or removed version in the new layer. This means that the only way you can make a layer smaller is by removing files before you save the layer. The most common way to deal with this is by stringing commands together on a single `Dockerfile` line. You can do this very easily by taking advantage of the `&&` operator. This operator acts as a Boolean `AND` statement and basically translates into English as “and if the previous command ran successfully, run this command.” In addition to this, you can take advantage of the `\` operator, which is used to indicate that a command continues after the newline. This can help improve the readability of long commands.

```Dockerfile
FROM docker.io/fedora
RUN dnf install -y httpd && \
    dnf clean all
CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
```

- A important lesson to take is that order matters, and in general, you should always try to order your Dockerfile so that the most stable and time-consuming portions of your build process happen first and your code is added as late in the process as possible.

- Create a container from the underlying image with `docker container create` command.

- Execute the container with `docker container start` command.

- The `docker container run` is really a convenience command that wraps the two separate steps above into one.

- If you want to give your container a specific name, you can use the `--name` argument.

  - Example: `docker container create --name="awesome-service" ubuntu:latest sleep 120`

- You can delete a container with `docker container rm <container-name/id>` command.

- It is possible to add new labels to the containers so that you can apply metadata that might be specific to that single container:

```fish
docker container run --rm -d --name has-some-labels \
  -l deployer=Mike -l tester=Harvey \
  ubuntu:latest sleep 1000
```

- You can then search for and filter containers based on this metadata, using commands like `docker container ls`:

  - Example: `docker container ls -a -f label=deployer=Dercilio`

- You can use the `docker container inspect` command to see all the labels that a container has.

- The `--rm` argument tells Docker to delete the container when it exits.

- The `-t` argument tells Docker to allocate a pseudo-TTY.

> TTY stands for Teletype and can be interpreted as a device that offers basic input-output. The reason it’s a pseudo-TTY is that there’s no physical teletype needed, and it’s emulated using a combination of display driver and keyboard driver. [ref](https://www.baeldung.com/linux/docker-run-interactive-tty-options#:~:text=From%20the%20official%20documentation%2C%20Docker,that%20offers%20basic%20input%2Doutput.)

- The `-i` argument tells Docker that this is going to be an interactive session and that we want to keep STDIN open.

  - Exmaple: `docker container run --rm -ti ubuntu:latest /bin/bash`

- When you see any examples with a prompt that looks something like `root@hashID`, it means that you are running a command within the container instead of on the local host.

- Constraints are normally applied at the time of container creation. If you need to change them, you can use the `docker container update` command or deploy a new container with the adjustments.

- To see your kernel info, run `docker system info`

- When you use the `--memory` option alone, you are setting both the amount of RAM and the amount of swap that the container will have access to. Docker supports `b`, `k`, `m`, or `g`, representing bytes, kilobytes, megabytes, or gigabytes, respectively. If you would like to set the swap separately or disable it altogether, you need to also use the `--memory-swap` option.

  - Example: `docker container run --rm -ti --memory 512m --memory-swap=768m`

  - We’re telling the kernel that this container can have access to 512 MB of memory and 256 MB of additional swap space.

- We could use the container long hash, but if we failed to note it down, we can also list all the containers on the system and filter by it ancestor:

  - Exmaple: `docker container ls -a --filter ancestor=redis:2.8`

- Most Docker commands will work with the container name, the full hash, the short hash, or even just enough of the hash to make it unique.

- We can tell Docker to manage restarts on our behalf by passing the `--restart` argument to the `docker container run` command. It takes four values: `no`, `always`, `on-failure`, or `unless-stopped`.

- If you need to prevent a container from doing any additional work, without actually stopping the process, then you can pause the Linux container with `docker container pause` and `unpause`.

## Reference

- [“Docker: Up & Running, 3e, by Sean P. Kane with Karl Matthias (O’Reilly). Copyright 2023 Sean P. Kane and Karl Matthias, 978-1-098-13182-1.”](https://learning.oreilly.com/library/view/docker-up/9781098131814/)
