<!-- markdownlint-disable MD001 -->
# FAQ

### Error by extcap pipe

This error is usually triggered when trying to start a capture from Edgeshark's
UI while accessing it via an IED's _reverse proxy_.

> [!ATTENTION] Please access Edgeshark's UI directly via port 5001 of an IED,
> instead of using the reverse proxy at port 443.

### Exposed host ports

Click or touch the action bar "burger" icon and then select the item "Open & Forwarding Host Ports".

## Exposed container ports

Click or touch a container badge in order to show the container's communication
details. These details will show a section titled "port forwarding".

### How does Edgeshark capture network traffic?

Edgeshark internally uses Wireshark's
[dumpcap](https://www.wireshark.org/docs/man-pages/dumpcap.html) tool for the
traffic capture itself. Edgeshark hides the technical obstacles of attaching
`dumpcap` to the virtual IP stacks of containers and streaming the capture
stream over a websocket connection.

Unfortunately, `tcpdump` and similar tools are unsuitable when capturing from
"all" network interfaces simultaneously, as they then bang all traffic together
as originating from a single "all" network interface. Nice hack, but often
unsuitable for deeper traffic analysis.

### Edgeshark or Ghostwire?

Admittedly, we messed that one up and need to take classes on branding.

- _Ghostwire_ is the discovery engine that also provides the user interface.
- _Edgeshark_ then is the name of the Industrial Edge app.
- wait, there's one thing more: _Packetflix_ is the packet capture streaming
  service.

### What is Packetflix?

_Packetflix_ is both the name of the network capture streaming service as well
as of the `packetflix:` URL scheme for starting Wireshark capture sessions from
a web browser.

### There's a Typo in Gostwire

Not necessarily. The new version 2 of network discovery engine is nicknamed
"Gostwire" instead of "Ghostwire" because it is implemented in
[Go](https://golang.org/).
