# Network Interfaces

On a very high level, Linux separates network interfaces into just two
varieties:

1. ![HW network interface](_media/icons/nifs/HardwareNic.svg ':class=mdicon :no-zoom')
   **hardware/physical** network interfaces are network interfaces **with a
   "hardware" driver**. To make this terminology slightly more awkward, this
   also encompasses "virtualized" – or rather, *emulated* – network cards, such
   as E1000, RTL8139, et cetera. (These network cards are sometimes also termed
   "vNICs", virtual network interface cards.)

2. everything else are **virtual** network interfaces in the narrower meaning of
   the Linux kernel have **direct kernel built-in support**, so no "hardware
   driver". Some examples of virtual network interfaces are bridges, virtual
   Ethernet "cable ends" (which only come in pairs), and overlay networks.

## Physical Network Interfaces

Edgeshark marks hardware/physical network interfaces (including vNICs) with ![HW
network interface](_media/icons/nifs/HardwareNic.svg ':class=mdicon :no-zoom').
Please note that Edgeshark does not differentiate different types of hardware
network interfaces and simply uses a unified "cable" icon for identification.

## Virtual Network Interfaces

For virtual network interfaces, Edgeshark shows the following icons, depending
on the type of virtual network interface:

| Network Interface | Type | Description |
| --- | --- | --- |
| ![bridge](_media/icons/nifs/Bridge.svg ':class=mdicon :no-zoom') | **Bridge** | a virtual bridge: this is the network interface of the bridge itself and it always connects the bridge to the virtual IP stack, but never to anywhere else. Additional network interfaces will act as the (Ethernet) ports of the virtual bridge. |
| ![internal bridge](_media/icons/nifs/BridgeInternal.svg ':class=mdicon :no-zoom') | **Internal Bridge** | this virtual bridge has additional packet filters installed that block external traffic. Please note that the host itself is still reachable from containers on an internal bridge, as can the host reach the containers attached to this virtual bridge. |
| ![VETH](_media/icons/nifs/Veth.svg ':class=mdicon :no-zoom') | **VETH** | one of exactly two virtual Ethernet network interfaces connected to each other. |
| ![MACVLAN](_media/icons/nifs/Macvlan.svg ':class=mdicon :no-zoom') | **MACVLAN** | an additional "virtual LAN" card to a hardware/physical network interface. The term "VLAN" might be totally misleading, as a MACVLAN network interface is not a separate VLAN in the IEEE 802 sense, but instead adds a separate MAC address on an existing hardware/physical network interface and handles its traffic through this separate network interface. |
| ![MACVLAN master](_media/icons/nifs/MacvlanMaster.svg ':class=mdicon :no-zoom') | (**MACVLAN master**) | a hardware/physical network interface to which one or more MACVLAN network interfaces have been added (attached). This is signalled by an Ethernet plug and cable, but with side branches going off to the left and right. |
| ![VxLAN](_media/icons/nifs/Overlay.svg ':class=mdicon :no-zoom') | **VxLAN** | an overlay network interface for [virtual extensible LANs](https://en.wikipedia.org/wiki/Virtual_Extensible_LAN): it carries Ethernet traffic via UDP/IP datagrams. |

## Operational State

The so-called "operational state" indicates the real working state of a network
interface, as opposed to the desired "administrative" state. Edgeshark only
depicts the operational state, as this is "where the rubber meets the road".

| Network Interface | State | Description |
| --- | --- | --- |
| ![operstate up](_media/icons/operstates/Up.svg ':class=mdicon :no-zoom') | **up** | this network interface is operational "up" and can be used. |
| ![operstate unknown](_media/icons/operstates/Unknown.svg ':class=mdicon :no-zoom') | **unknown** | while this network interface is in an unknown state (because no specific state is available), it is yet to be considered operational. For this reason, Edgeshark depicts the "unknown" state the same as the "up" state. A common example for network interfaces in "unknown" state are the "lo" loopback network interfaces. |
| ![operstate dormant](_media/icons/operstates/Dormant.svg ':class=mdicon :no-zoom') | **dormant** | while the physical layer of this network interface is up, the network interface is waiting for an external event to become fully operational. |
| ![operstate down](_media/icons/operstates/Down.svg ':class=mdicon :no-zoom') | **down** | this network interface is unable to transfer any data. |
| ![operstate lower layer down](_media/icons/operstates/LowerLayerDown.svg ':class=mdicon :no-zoom') | **lower&nbsp;layer down** | this network interface is stacked onto another network interface, and the underlying network interface currently is "down". |

## Promiscuous Mode

A network interface operating in "promiscuous mode" passes all network traffic
it receives to the network stack (virtual IP stack), instead of only the traffic
specifically addressed to it. As promiscuous mode increases system load (because
the system now has to process all traffic really destined for it) this mode is
normally switched off on network interfaces, unless it is needed:

- [capturing](capture) all traffic visible at a specific network interface
  (even if just passing by). Please note that capturing does not strictly
  require promiscuous mode, in this case only the part of traffic gets captured
  that is specifically addressed to a network interface. However, capturing
  tools often automatically request promiscuous during capture, unless
  explicitly told to not do so.

- briding network traffic between network interfaces of a virtual bridge.

Edgeshark marks network interfaces in promiscuous mode with
![promiscuous mode](_media/icons/Promiscuous.svg ':class=mdicon :no-zoom').
