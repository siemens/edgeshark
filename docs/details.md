# Detail View

Edgeshark shows network configuration detail information either in a
**host-overall view** ("Network Namespace Details") or alternatively in
individual **per-IP stack detail view**. The detail views are shown when
clicking on a specific containee (process, container, ...) in either the
"Wiring" or the "Network Namespace Details" views.

The following example shows the **network details of a single virtual IP
stack**, with only a single container in this case.

![networking details](_images/details.png ':class=scrshot')

Communication details are organized into four sections:

- containees (containers, non-containerized processes, …),
- routing,
- transport,
- and network interfaces.

Each section can be collapsed or expanded by clicking on the arrow symbol ❶ left
to a section header.

> [!TIP] Users can [set their personal preferences](settings.md) whether to
> always expand, always collapse, or collapse only large sections.

## Containers/Containees

This section show details about the [containers or stand-alone
processes](containees.md) attached to this particular virtual IP stack. The term
"containee" encompasses not only containers but also processes that haven't been
put into a container. There is even a special case where there are no processes
at all attached to a virtual IP stack.

![container/containee details](_images/details-containee.png ':class=scrshot')

Beside the container-related information (such as name and the separate
container ID), Edgeshark also displays communication-related information: the
container's hostname as well as DNS setup. This aids in diagnosing hard-to-find
issues (and also mistaken expectations) at the DNS and `/etc/hosts` level.

> [!NOTE] Docker differentiates between the (usually symbolic) **name** of a
> container, as opposed to the unique **ID**. The latter identifies a specific
> container instance from cradle to coffin. If a service gets restarted, the
> service container keeps the name, but gets a new and different ID.

## Neighborhood Services

This section only appears when Docker containers are present and the containers
shown in this detail view are connected to at least one Docker user-defined
network (that is, networks other than the default network named `bridge` with
its `docker0` Linux bridge).

### What's Here?

In this section you'll see all those (Composer) services and individual
containers that are DNS-addressable and reachable from the viewpoint of the
container(s) you are selected for its details. The DNS names of these Docker
services and individual containers are resolved by Docker's built-in "embedded"
DNS resolver itself, so they are not resolvable by a host-based or any upstream
DNS resolver.

![Neighborhood Services](_images/mobydig.png ':class=scrshot')

- ❶ the **names of individual containers** that are in the
  "neighborhood" (for lack of official Docker terminology) of the container for
  which the details are shown. These are containers that are reachable via user
  networks directly attached to the inspected container.

- ❷ the **DNS names of the service** the individual containers are
  part of. In the context of Industrial Edge Apps services typically consist of
  only a single container without horizontal load balancing.

- ❸ the **DNS names of individual containers**. Usually, these DNS names should
  not be used, but instead the service names in order to make use of horizontal
  scaling and load balancing.

Docker assigns to services and individual containers multiple DNS names:

- ❹ **single label DNS name** of a service or container ... but **don't use
  them**.

  > [!WARNING] Albeit most Docker Composer service examples show the use of
  > single label DNS service names, this is a potentially dangerous practice.
  > This more so when using multiple user-defined (or in case of the Industrial
  > Edge: App-defined) networks, because it can result in unexpected resolution
  > to a different App's service or even name resolution failure. For this
  > reason, **Edgeshark** grays out single label DNS name in order to dissuade
  > their use.

- ❺ **network-qualifying two-label DNS name** of a service or container: these
  DNS names do not only specify the service or individual container, but **also
  the specific user-defined network it is located on**. Especially in a 3rd
  party App service Docker host, such as the Industrial Edge, this avoids nasty
  surprises.

  > [!WARNING] **Always explicitly specify App-internal networks with unique
  > network names**, by prefixing your app-internal network name with your app's
  > project name. Then **always address all your App-internal services using a
  > network-qualified DNS service name**.

  > [!NOTE] You can probably guess that lots of IE Apps come with their own
  > App-internal `database` service. If multiple of these `database` services
  > end up on a shared network, especially `proxy-redirect`, then service name
  > resolution chaos ensues.

- ❻ the container from which perspective the neighborhood is shown. It is
  included for reference, but grayed out to indicate that it is the current
  location for the details.

### Check Reachability

![Neighborhood Service DNS Name Validation](_images/mobydig-validated.png ':class=scrshot')

Clicking or tapping the "CHECK" button ❶ starts the validation and the
reachability verification process for the service/container DNS names shown.

The individual DNS names (both network-qualified as well as single-label DNS
names) are resolved using Docker's embedded DNS resolver and the resolved IP
addresses shown. These IP addresses ❷ are then pinged in order to validate that
they are actually IP-reachable from the container whose details are representing
the current location.

- ![ongoing verification](_media/icons/neighborhood/in-verification.svg
  ':class=mdicon :no-zoom') ongoing DNS name and IP address reachability
  verification.

- ![valid DNS name and IP address](_media/icons/neighborhood/verified.svg
  ':class=mdicon :no-zoom') successfully resolved the service/container DNS name
  and the service/container is reachable via IP.

- ![invalid DNS name or unreachable IP
  address](_media/icons/neighborhood/invalid.svg ':class=mdicon :no-zoom')
  either the DNS name could not be resolved or the IP reachability test failed.
  Normally, this should only happen when containers stop or restart during
  verification. You might refresh the discovery information to make sure it
  properly reflects the current workload situation and then start the checks
  again.

> [!NOTE] Albeit **Edgeshark** runs the DNS queries and IP pings in the context
> of current location container's virtual IP stack, it doesn't require any DNS
> and IP tools (such as dig and ping) to be installed into containers.

## Port Forwarding

This section lists the TCP and UDP ports forwarded inside this specific
(virtual) IP stack (network namespace). More precisely, this table covers TCP
and UDP ports that undergo "destination NAT"
([dNAT](https://en.m.wikipedia.org/wiki/Network_address_translation#DNAT)) for
incoming packets, as well as the inverse translation for any replies.

> [!NOTE] Please keep **port forwarding** apart from **source NAT**
> ([sNAT](https://en.m.wikipedia.org/wiki/Network_address_translation#SNAT))
> that instead covers traffic originating from a non-globally routable container
> IP address and thus needs its source IP address replaced with one of the
> host's externally facing IP addresses.

**Edgeshark**'s port forwarding table covers both TCP and UDP ports forwarded
using packet filter operations as well as via user-space [`docker-proxy`
processes](https://windsock.io/the-docker-proxy/).

In particular, **Edgeshark** detects (only)
**[netfilter](https://en.m.wikipedia.org/wiki/Netfilter)-managed** packet
mangling rules. However, as all relevant Linux distributions already have
migrated to the netfilter framework years ago, this should not come as a real
restriction. Interestingly, while Docker itself doesn't directly integrate with
netfilter, it gets integrated via netfilter's iptables legacy integration layer.

Edgeshark automatically detects **user-space [`docker-proxy` port forwarding
processes](https://windsock.io/the-docker-proxy/)** that are [required under
certain conditions](https://stackoverflow.com/a/49070640) for correctly
forwarding traffic coming from a container into another container via (local)
host port forwarding. These forwarded ports are aggregated with the ports
discovered from packet-mangling rules and in particular, they are _not
separately identified_.

The port forwarding table not only shows the IP addresses and ports TCP and UDP
ports get forwarded to, but additionally the containers/containees serving these
ports.

> [!NOTE] Docker users might notice TCP and UDP ports 53 getting forwarded
> inside their containers solely on the loopback address `127.0.0.11`. These
> ports belong to Docker's embedded DNS service that resolves container and
> service DNS names locally. In consequence, these forwarded ports are handled
> by the `dockerd` daemon itself. These DNS service-related port forwardings are
> only present if a container is attached to at least one custom (user-defined)
> network, but not when a container is only attached to the `docker0`
> default/legacy network.

## Transport

This section is a special feature of Edgeshark (kind of
"_[netstat(8)](https://man7.org/linux/man-pages/man8/netstat.8.html) on
stimulants_"). Where `netstat` (and similar tools) only show the open sockets of
a single (host) IP stack and only with process names, Edgeshark is
container-aware, up to the identification of the processes using these sockets
(in KinD clusters it is even "pod"-aware).

![transport details](_images/details-transport.png ':class=scrshot')

> [!TIP] The transport table can be sorted by clicking on column headers. The
> table supports so-called "stable sorting": the contents can be sorted along
> multiple columns by sorting one column after another in _reverse order_. For
> instance, to sort by protocol, then state, simply click on the column headers
> in that order.

The "**St**" or **state column** signals the socket connection state:

- ❶ identifies a socket in "listening" mode that is accepting incoming
  connections.
  > [!NOTE] UDP sockets are usually always in "listing" mode even while
  > communication carries on, unless they are bound to a specific remote
  > address: only then they will be listed as "connected".
- ❷ identifies a "connected" socket. The "Remote" and (Remote) "Port" column
  then shows the IP address and port number of the remote end of the connection.

The "**Group · Container · Process**" column ❸ not only identifies the process
using a particular socker by name and PID, but additionally the containing
container (if any).

On Docker hosts, eagle-eyed users might spot a "guest" ❹ opening sockets in IP
stacks of their containers: this is Docker's dynamic DNS server. It resolves
container names and is automatically made available to the containers of all IE
apps. It's a valid use case, and a very useful one on top of that.

## Routing

IP routes are always attached to a whole IP stack, **but never** to any (single)
network interface. The rationale is that as interfaces may come up or go down
routing tables do not need to be reconfigured but instead routes simply become
active or inactive, or even do not change at all as another network interface
now services the existing route. In consequence, Edgeshark shows IP routes in
its own separate per-IP stack section.

![routing details](_images/details-routes.png ':class=scrshot')

Individual routes ❶ show their destination network (using the common and more
compact network "address/prefix" length notation) as well as the IP address of
the next hop ❷, if any, to take. If you can see from the above example, only the
so-called "default route" has a next hop defined, while the other two IPv4
networks `172.17.1.0/24` and `172.17.2.0/24` are so-called "direct subnets"
without any next hops for routing beyond these direct subnets.

> [!TIP] The network part of IP addresses is underlined to make it visually more
> easily recognizable. The host part (which should be all zeros for routing
> entries) is rendered without underlining and has a different color. If the
> network-host boundary falls inside a single IPv4 octet (or IPv6 nibble
> respectively), then the underlining will end at the latest boundary (IPv4
> octet or IPv6 nibble).

For convenience, the (outgoing) network interfaces ❸ are additionally shown to
aid in tracing IP traffic along the layer 2 topology. This also aids in quickly
spotting unusable routes where their outgoing network interface is down.

The route icons signal visually the type of route:

- ![default route](_media/icons/routes/DefaultRoute.svg ':class=mdicon
  :no-zoom') indicates a default route.
- ![route](_media/icons/routes/Route.svg ':class=mdicon :no-zoom') is a (or
  aggregated) route to multiple IP networks.
- ![direct subnet route](_media/icons/routes/DirectSubnetRoute.svg
  ':class=mdicon :no-zoom') marks a route to a directly reachable subnet route
  assigned to a local network interface and thus without the need to hop through
  an IP router.
- ![host route](_media/icons/routes/HostRoute.svg ':class=mdicon :no-zoom') is a
  route to a single IP address (host).
- ![no route](_media/icons/routes/NoRoute.svg ':class=mdicon :no-zoom') is a
  blocked or "blackhole" route sending all IP traffic to nowhere.

## Interface Configuration

The section on [network interfaces](nifs.md) shows the parts of the current
networking configuration that directly applies to network interfaces ❶. In
particular, you'll find here the IP addresses ❷ configured for the network
interfaces.

![network interface details](_images/details-nifs.png ':class=scrshot')

In addition, this section also shows how the network interfaces of this virtual
IP stack are related to other network interfaces ❸ within the same Industrial
Edge device. The relation is indicated by a short dashed line. In addition to
the name of a related network interface, Edgeshark additionally shows the
container the network interface belongs to. If the network interface is part of
a virtual bridge then the name of the bridge (as well as the name of its Docker
network like "proxy-redirect") is shown too.

> [!TIP] Clicking or tapping a related network interface, bridge or container
> switches to the detail view of the related virtual IP stack.
