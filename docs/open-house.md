# Open & Forwarding Ports

This view shows all TCP and UDP transport ports of a host system that are either
opened directly by processes, or host ports that are being forwarded to other IP
addresses and ports, usually belonging to service containers.

![open/forwarding ports](_images/ports.png ':class=scrshot')

This view thus gives an overview on the externally accessible host ports in a
single place – but please notice it can additionally include host-local services
that aren't accessible from the outside. Such host-local services are bound to
the loopback IP addresses `127.0.0.0/8` and/or `::1` in case of IPv6.

Please note that this view **does not show any established TCP or UDP
connections**, but only "open" in the sense of "listening" and "forwarding".

Information about established communication connections can be found instead in
the [transport details](details#transport) of the corresponding containers, as
well as the initial process (such as `systemd(1)`). For this, please navigate to
the wiring view and then touch or click on a container/containee to see its
details.
