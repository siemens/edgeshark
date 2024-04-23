# KinD

[Kubernetes-in-Docker ("KinD")](https://kind.sigs.k8s.io/) is a tool to run
local Kubernetes clusters inside Docker containers. Edgeshark comes with
KinD/Kubernetes awareness built-in and it **does not access** the Kubernetes
control plane API. Instead, it notices special KinD markers on "node
containers". Moreover, Edgeshark detects the presence of [CRI "Container Runtime
Interface"](https://github.com/kubernetes/cri-api) API endpoints and uses it
with [containerd](https://containerd.io/) and [cri-o](https://cri-o.io/) to
discover the pod and container workload.

Please note that Edgeshark requires the [event-based container status updates
("Evented PLEG")
API](https://kubernetes.io/docs/tasks/administer-cluster/switch-to-evented-pleg/)
to be enabled. KinD as of v0.22 or later fits the bill right out of the box.

## kube-proxy

The [Kubernetes network
proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/)
runs on each Kubernetes node and configures port forwardings to cluster
services, based on the deployed services. Edgeshark then discovers these port
forwardings in the packet filtering and forwarding rules of
[nftables](https://wiki.nftables.org/wiki-nftables/index.php/What_is_nftables%3F)
(more specific, the "xtables" legacy infrastructure).

The service address/port forwardings can be seen when switching into the [detail
view](details) of a KinD "cluster node" container.

![kube-proxy port forwarding](_images/kind-portfwd.png ':class=scrshot')

This screenshot shows port forwardings for the k8s API, the cluster DNS
resolvers, and finally the health monitoring of the DNS resolvers – in an
"empty" KinD single node cluster, right after `kind create cluster`.

> [!NOTE] Detection of port forwardings in KinD on WSL2 is currently
> **unsupported**.
