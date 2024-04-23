# Containees

In short, "**containees**" is our general term for lumping different things
together that can have their own virtual IP stack (network namespace), such
as...

- *containers* of various sorts,
- *stand-alone processes*,
- and process-less *"bind-mounted"* network namespaces (which you should rarely
  encounter on Industrial Edge devices, but one never knows).

A core principle of Linux network namespaces (as well as any Linux namespace in
general) is that they cannot simply exist out of their own will. Instead, they
need processes attached to them, where these processes can be either outside or
inside "containers" (managed by a container engine, such as Docker).
Additionally, namespaces can also be "anchored" to the file system without any
process (currently) attached to them. But without a process or a file system
anchor, network namespaces will simply vanish -- and even our <Brand/> won't be
able to detect any trace of them anymore.

> [!TIP] Clicking a containee "badge" (button) navigates to a [detailed view](details) of
> the network namespace (virtual IP stack) this particular container, process,
> ... is currently attached to.

| Containee | Description |
| --- | --- |
| ![host](_media/icons/containees/Initial.svg ':class=mdicon :no-zoom') | the **host networking** (_just as in the old golden days_). |
| ![stand-alone process](_media/icons/containees/Netns.svg ':class=mdicon :no-zoom') | a **"stand-alone" process** (not part of any container). |
| ![IE App container](_media/icons/containees/IEApp.svg ':class=mdicon :no-zoom') | an **IE App container**. The colored bar at the left edge signals the container state, with green indicating a running container, yellow signalling a paused container, and red showing an exited container. |
| ![Industrial Edge Runtime](_media/icons/containees/IERuntime.svg ':class=mdicon :no-zoom') | the **Industrial Edge Runtime container**. |
| ![Docker container](_media/icons/containees/Docker.svg ':class=mdicon :no-zoom') | a **Docker container**. The colored bar at the left edge signals the container state, with green indicating a running container, yellow signalling a paused container, and red showing an exited container. |
| ![containerd container](_media/icons/containees/Containerd.svg ':class=mdicon :no-zoom') | a sideloaded **containerd container**. The colored bar at the left edge signals the container state, with green indicating a running container and red showing an exited container. |
| ![Kubernetes CRI container](_media/icons/containees/CRI.svg ':class=mdicon :no-zoom') | a **Kubernetes CRI container** that is managed by a CRI API-supporting container engine, such as _containerd_. The colored bar at the left edge signals the container state, with green indicating a running container, yellow signalling a paused container, and red showing an exited container. |
| ![podman container](_media/icons/containees/Podman.svg ':class=mdicon :no-zoom') | a **Podman container**. The colored bar at the left edge signals the container state, with green indicating a running container, yellow signalling a paused container, and red showing an exited container. |
| ![stand-alone process](_media/icons/containees/Netns.svg ':class=mdicon :no-zoom') | a **process-less network namespace** that has been bound to a file system path in order to prevent the namespace from getting garbage collected. Such "bind-mounted" namespaces can serve both more permanent tasks in some segmented network setups, as well as temporarily appear while a container engine is configuring the networking of a new container and the container's initial process hasn't even started yet. |

> [!NOTE] multiple containees can share the same virtual IP stack (network
> namespace).
