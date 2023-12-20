# Docker Desktop

When deploying Edgeshark to [Docker
Desktop](https://www.docker.com/products/docker-desktop/) on a WSL2 or macOS
configuration, it will reveal much more containers than just your user
containers. This is because the user-facing Docker daemon is actually not
running directly on the
([WSL2](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux#WSL_2) or VM)
Linux Docker host, but instead inside a [containerd](https://containerd.io/)
container.

> [!TIP] Yes, that's correct: the Docker daemon lives _inside another
> container_.

## Infrastructure

Following is an example from a Docker Desktop on
[WSL2](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux#WSL_2)
installation:

![Docker Desktop infrastructure](_images/docker-desktop-wsl2.png ':class=scrshot')

All these behind-the-scenes containers are *never* showing up in your `docker
ps`, because technically they aren't managed by the Docker daemon. Instead,
these containers making up the Docker Desktop infrastructure are managed by a
separate _containerd_ engine – the same that also houses the Docker daemon.

## "Odd" Container Names

As Docker Desktop puts the Docker daemon inside a container, Edgeshark
automatically shows this hierarchy as part of the container names. In
particular, the prefix `[services.linuxkit/docker]:` identifies the Docker
daemon managing the user containers.

![Docker-in-Container](_images/docker-in-container.png ':class=scrshot')

> [!NOTE] While the Docker daemon process _runs_ inside a container, the
> containers managed by this Docker instance – that is, _your_ containers –
> technically aren't inside this Docker daemon container from the perspective of
> networking. [Network namespaces](netns) cannot be nested, thus Edgeshark
> always shows them side-by-side. The hierarchy exists (only) from the process
> (PID namespaces) as well as from the logical perspective.

## Nerd Trivia

- The container name prefix `services.linuxkit/` refers to the containerd
  namespace used to separate Docker Desktop containers from other containers on
  the level of the containerd engine – even as there aren't any other containers
  deployed to this "outer" containerd engine.

- The discovery details (at the top of the discovery display) will actually show
  _two_ containerd engines. One is the "outer" engine for the Docker Desktop
  infrastructure containers and the Docker engine itself, the second one belongs
  to the Docker engine. The Docker daemon itself always needs a container engine
  that does the lower level work.
