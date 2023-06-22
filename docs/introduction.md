# Introduction

![Edgeshark logo](_images/edgeshark.png ':no-zoom :size=100 :class=mascot')

**Edgeshark** helps in diagnosing and optionally capturing the communication
between containers and with their outside world in Linux stand-alone container
hosts and KinD deployments. Not least, Edgeshark can easily be deployed to
[Siemens Industrial
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
  plugin](/getting-started#optional-capture-plugin) for Wireshark.

One thing to note is that Edgeshark **isn't** "Wireshark **in** a container".
That is beause first and foremost, Edgeshark is a more general stand-alone
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

With Edgeshark, the information displayed reflects the **active system state**
and not _some_ engineered (and sometimes ignored) configuration data somewhere
on disk.

- UI with light/dark theme switcher (in [settings](settings)) and [integrated
  multi-chapter help](sidebar-help) (accessible through side bar, click or tap
  on ![menu](_media/icons/Menu.svg ':class=mdicon :no-zoom') symbol).
- "[wiring](wiring)" view of the (virtual) network data-link layer.
- [detail](details) views for individual app containers or the host:
  - IP and MAC address, as well as IP routing configuration of host and app
    containers.
  - DNS configuration of host and app containers, including online validation.
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
- and finally: powered by ghosts, _not spectres_ ... lately with the help of
  some strange Gophers wearing blankets, for whatever reason.

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
