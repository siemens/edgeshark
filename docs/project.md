# Project Edgeshark

> [!INFO] This information is primarily intended for packagers and developers,
> but not so much for end users.

## Service Architecture

The **Edgeshark** application internally consists of two micro-services.

### Gostwire

G(h)ostwire is the discovery service and also services the app's UI – however,
its service port 5000 is internal and thus *not exposed*. ([Ghostwire
Repository](https://github.com/siemens/ghostwire)).

As of version 2 of Edgeshark the new discovery engine is "Gostwire". This engine
a complete rewrite from ground up with better performance, reduced memory
footprint and better extensibility in mind. For instance, multiple incomming
requests are now handled concurrently.

### Packetflix

Packetflix is the packet capture streaming service that is exposed at port 5001
and also acts as the official service entry point. ([Packetflix
Repository](https://github.com/siemens/packetflix)):

- the specific capture API requests are processed in the Packetflix service
  itself.
- UI and discovery API requests are internally forwarded ("proxied") to the
  app-internal G(h)ostwire discovery service.

## Capture Clients

Remote packet capture is supported using the following clients:

- csharg Extcap Plugin for Wireshark.
- `csharg` CLI: a command-line tool for discovering containers and running
  packet captures from scripts, such as in test automation, et cetera.

## Code Repositories

- [edgeshark repository](https://github.com/siemens/edgeshark): this repository
  consists of the app-related deployment files as well as the Github page.
- [ghostwire repository](https://github.com/siemenss/ghostwire): container-aware
  virtual networking and network configuration discovery.
  - [mobydig repository](https://github.com/siemens/mobydig) resolves DNS names
    and pings them using worker pools.
  - [ieddata repository](https://github.com/siemens/ieddata) fetches
    Industrial Edge Device information from inside an IED itself, such as the
    IED core runtime version and the icons of the installed applications.
- [packetflix repository](https://github.com/siemens/packetflix):
  container-aware packet capture and streaming.
- [csharg capture plugin repository](https://github.com/siemens/cshargextcap):
  capture plugin for Wireshark implementing Wireshark's so-called "external
  capture plugin" API.
- [csharg repository](https://github.com/siemens/csharg): shared/reused code for
  working with the discovery and capture REST/websocket APIs.
