# Introduction

![Edgeshark logo](_images/edgeshark.png ':no-zoom :size=100 :class=mascot')

> Quick, just get me 🚀&nbsp;**[started](getting-started)!**

**Edgeshark** visualizes the communication of containers and thus helps in
diagnosing it, both in-between containers as well as with the "outside world".
It can be deployed to Linux stand-alone container hosts, including
[KinD](https://kind.sigs.k8s.io/) deployments. Edgeshark also supports capturing
container traffic using [Wireshark](https://wireshark.org). Another natural
habitat of Edgeshark are [Siemens Industrial
Edge](https://new.siemens.com/global/en/products/automation/topic-areas/industrial-edge.html)
devices.

![wiring](_images/teaser-wiring.png ':class=teaser')
![communication details](_images/teaser-comm-details.png ':class=teaser')

Things you can do with Edgeshark:

- discover the virtual "wiring" between containers as well as between containers
  and the IE device host in Edgeshark's web-based user interface.

- quickly find out about various network-related configuration settings of your
  app containers, such as IP and MAC addresses, IP routing, and DNS
  configuration.

- comfortably capture live container network traffic in
  [Wireshark](https://wireshark.org), using the [csharg external capture
  plugin](/getting-started#optional-capture-plugin) for Wireshark. This
  Wireshark plugin is available for:
  - Linux AMD64/x86-64 and ARM64: Alpine, AUR, Debian/Ubuntu DEB, RPM, plain binary,
  - macOS AMD64/x86-64 and ARM64, and
  - Windows AMD64/x86-64 only.

One thing to note is that Edgeshark **isn't** "Wireshark **in** a container".
That is because first and foremost, Edgeshark is a more general stand-alone
virtual network/communication diagnosis tool. Only then it additionally doubles
as a packet capture "streaming service" that is aware of containers, including
Industrial Edge apps, and that can stream packet captures into a (remote)
Wireshark application.

For analysing container traffic simply use
[Wireshark](https://www.wireshark.org/) installed into your desktop/development
system and then [connect Wireshark to Edgeshark](capture). This can be either
done from the web UI of Edgeshark or via our [csharg external
capture](https://github.com/siemens/cshargextcap) plugin from inside Wireshark.

## Features

The general idea of Edgeshark is to display the **real system state**, and not
_some_ engineered configuration data from somewhere on disk.

Alas, Edgeshark features:

- UI with light/dark theme switcher (in [settings](settings)) and [integrated
  multi-chapter help](sidebar-help) (accessible through side bar, click or tap
  on ![menu](_media/icons/Menu.svg ':class=mdicon :no-zoom') symbol).
- a "[wiring](wiring)" view of the (virtual) network data-link layer.
- [detail](details) views for individual app containers or the host:
  - IP and MAC address, as well as IP routing configuration of host and app
    containers.
  - DNS configuration of host and app containers, including online validation.
- filtering the containers/network namespaces displayed
  <nobr>(<kbd>Ctrl</kbd>+<kbd>f</kbd></nobr> or <nobr><kbd>/</kbd>)</nobr>.
- the [open & forwarded host ports](open-house).
- system information about host OS and Industrial Edge runtime.
- (experimental) shows IE App icons for quick visual identification. (needs to
  be [enabled in Settings](settings?id=siemens-industrial-edge) first)
- integrated screenshot function for easy documentation.
- bookmarkable views.
- full IPv4/IPv6 dual stack awareness and support.
- no modification of containers needed in order to capture their network traffic.
- live network packet capture _streaming_ in well-established pcapng "quasi
  standard" format.
- enhanced capture meta data showing the correct app container name (as opposed
  to unique ID) and correct IED host name.
- remote capture with app container-awareness that can be started just with a
  click/touch from the UI.
- REST/websocket service API for discovery and capture.

... and finally: Edgeshark is powered by ghosts, _not spectres_, lately also
with the help of some weird Gophers wearing _blankets_, for whatever reason.

## Supported Container Engines

- [containerd](https://containerd.io/),
- [Docker](https://docker.com/),
- [CRI-O](https://cri-o.io/) – requires [Event PLEG
  API](https://kubernetes.io/docs/tasks/administer-cluster/switch-to-evented-pleg/)
  to be enabled,
- [podman](https://podman.io/) – when set up to be socket-activated by `systemd`
  (see also [podman Quick Start: Starting the service with
  systemd](https://github.com/containers/podman/blob/main/pkg/bindings/README.md#quick-start)).
  Please note that we only support the Docker-compatible API, but not the
  podman-proprietary pod workload features. Discovery of podman's v4+ [netavark
  network driver
  stack](https://www.redhat.com/sysadmin/podman-new-network-stack) should work.

## Requested Privileges

> [!ATTENTION] Edgeshark requests the following privileges in order to discover
> and diagnose networking, including the networking of other apps and
> containers:
>
> - `pid:host`: discovering network and mount namespaces.
> - `CAP_SYS_ADMIN`: switching into network and mount namespaces for discovery.
> - `CAP_SYS_CHROOT`: switching into mount namespaces in order to read
>   `/etc/hosts`, `/etc/hostname`, and `/etc/resolv.conf`.
> - `CAP_SYS_PTRACE`: discovering namespaces via procfs.
> - `CAP_DAC_READSEARCH`: discovering namespaces from open file descriptors.
> - `CAP_DAC_OVERRIDE`: accessing container engine API sockets.
> - `CAP_NET_RAW`: capturing network traffic.
>
> No other capabilities are requested.
