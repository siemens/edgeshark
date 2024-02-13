# Capture via Web UI

You can easily start [Wireshark](https://www.wireshark.org/) live capture
session from Edgeshark's web UI.

> [!ATTENTION] Siemens Industrial Edge users: you **must access** the Edgeshark
> user interface on port `:5001` in order to successfully start captures from
> the UI. Attempting to start captures when accessing the user interface via an
> IED's reverse proxy at port `:443` will fail with authentication failures.
> Unfortunately, this cannot be fixed without proper IED support for session
> hand-overs.

## One-Click Capture

Throughout the wiring and detail views, you should notice symbolized **shark
fins** ![capture](_media/icons/Capture.svg ':class=mdicon :no-zoom'), like ❶ and
❷.

![capture buttons](_images/wiring-capture.png ':class=scrshot')

Clicking or tapping these capture symbols will start Wireshark and automatically
begin the live capture.

- ❶ captures **from all network interfaces** (including "lo", even if [not
  shown](settings)) of a container/containee.
- ❷ captures only **from the single network interface** next to the capture
  symbol.

Please note that capture buttons for network interfaces in the "down"
operational state are automatically disabled. Network interfaces that are "down"
show a reddish halo.

## Specific Multi-Interface Capture

When you need to capture from multiple, specific network interfaces – but not
from _all_ – tap or click the "multi-fin"
![multi-select](_media/icons/CaptureMulti.svg ':class=mdicon :no-zoom') symbol
❶. You are now switching into multiple interface selection mode for this
particular virtual IP stack. The above mentioned capture symbols next to
containees and network interfaces are hidden while in this selection mode.

![multi-select](_images/wiring-capture-multipass.png ':class=scrshot')

Please note that you can leave the multiple interface selection mode at any time
by tapping the ![multi-select](_media/icons/CaptureMultiOn.svg ':class=mdicon
:no-zoom') symbol ❷.

Now you can select or unselect the network interfaces ❸ you want to capture
from. Selected network interfaces show a check mark in form of a shark fin
![selected network interface](_media/icons/CaptureCheck.svg ':class=mdicon
:no-zoom'). Network interfaces in "down" operational mode cannot be selected,
their selection boxes are grayed out.

![select network interfaces](_images/wiring-capture-selection.png ':class=scrshot')

To start a new Wireshark live capture session, tap or click the
![capture](_media/icons/Capture.svg ':class=mdicon :no-zoom') symbol ❹
immediately to the left of the multi-select mode symbol.

![start multi-interface capture](_images/wiring-capture-multi-start.png
':class=scrshot')

Please note that the network interface selection is kept even after leaving the
selection mode, and as long as the particular virtual IP stack instance exists,
across discovery refreshes. However, it is **not kept** across reloading the
Edgeshark web UI.
