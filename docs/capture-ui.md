# Capture via Web UI

> [!ATTENTION] You **must access** the Edgeshark user interface on port `:5001`
> in order to successfully start captures from the UI. Attempting to start
> captures when accessing the user interface via an IED's reverse proxy at port
> `:443` will fail with authentication failures. Unfortunately, this cannot be
> fixed without proper IED support for session hand-overs.

Throughout the wiring and detail views, you should notice symbolized "shark
fins" ![capture](_media/icons/Capture.svg ':class=mdicon :no-zoom'), like ❶ and
❷.

![capture buttons](_images/wiring-capture.png ':class=scrshot')

Clicking or tapping these capture symbols will start Wireshark and automatically
begin the live capture.

- ❶ captures from all network interfaces (including "lo", even if [not
  shown](settings)) of a container/containee.
- ❷ captures only from the single network interface next to the capture symbol.

Please note that capture buttons get disabled for network interfaces that are in
down operational state (that is, when the corresponding network interface is showing
a reddish halo).
