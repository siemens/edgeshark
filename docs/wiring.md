# Wiring View

The **wiring view** is Edgeshark's trademark view that is shown by default. As
suggested by its name, the wiring view displays the potentially many virtual
data link-layer communication relations inside a container host in form of
"virtual wires".

## Virtual IP Stacks (Cards)

The wiring view into an Industrial Edge device is divided into multiple vertical
"cards" ❶, ❷, ❸, and so on. Each card represents an individual (virtual) IP
stack (a so-called "[network namespace](netns)" in Linux parlance). These IP
stacks are completely separated from each other, so each of them has its own set
of network interfaces, IP addresses, routes, et cetera.

![virtual IP stacks](_images/wiring-ipstack-cards.png ':class=scrshot')

The "badges" ❶, ❷, ❸, … in each IP stack card identify the IE app container,
system container, or system process the IP stack is attached to. Throughout
Edgeshark these different things attached to virtual IP stacks are simply summed
up as "containees".

| No. | Symbol | Meaning |
| --- | ---  | --- |
| ❸ | ![IE App container](_media/icons/containees/IEApp.svg ':class=mdicon :no-zoom') | refers to an IE App container named "edgeshark_edgeshark_1", as can be glanced from the icon for Industrial Edge apps. _Note:_ App-individual icons can be enabled in [settings](settings). |
| ❷ | ![Industrial Edge Runtime](_media/icons/containees/IERuntime.svg ':class=mdicon :no-zoom') | identifies the IED-OS runtime ("core") itself that, beside many other things, also houses the IED user interface. |
| ❶ | ![stand-alone process](_media/icons/containees/Netns.svg ':class=mdicon :no-zoom') | "init (1)" refers to the initial process of the Linux host system and thus to the host's IP stack (as opposed to container IP stacks) |
|    | ![Docker container](_media/icons/containees/Docker.svg ':class=mdicon :no-zoom') | indicates a Docker container. |
|    | ![k8s pod](_media/icons/containees/K8sPod.svg ':class=mdicon :no-zoom') | indicates a k8s pod. |
|    | ![KinD node](_media/icons/containees/Kind.svg ':class=mdicon :no-zoom') | indicates Docker container acting as a [KinD](https://github.com/kubernetes-sigs/kind) node. |

The colored badge edges signal the container execution state: while a green
badge edge means "running", yellow indicates a "paused" container.

> [!TIP] Hovering over the name badge of an IP stack card shows the type of
> container and its state.

With the exception of the initial/host IP stack "init (1)", all IP stack cards
are sorted alphabetically by the names of the associated containers. The
initial/host IP stack gets sorted first as it usually contains kind of a central
wiring only then fanning out to individual containers.

## Wires

### Types of Wires

The color and style of the "virtual wires" indicates different types of
"connections" inside an Industrial Edge device, such as shown next:

![wire types](_images/wiring-wire-types.png ':class=scrshot')

| No. | Symbol | Meaning |
| --- | ---  | --- |
| ❶ | ![VETH](_media/icons/nifs/Veth.svg ':class=mdicon :no-zoom') | **virtual Ethernet point-to-point connections** ("**veth**") are rendered using solid Profinet-greenish lines. At each end of veth connections is always exactly one network interface. |
| ❷ | ![HW network interface](_media/icons/nifs/HardwareNic.svg ':class=mdicon :no-zoom') |  **physical network cards** (or virtual "physical" network cards in case of virtual IEDs) show a stylized pale wire to the "outside world". |
| ❸ | ![MACVLAN master](_media/icons/nifs/MacvlanMaster.svg ':class=mdicon :no-zoom')–![MACVLAN](_media/icons/nifs/Macvlan.svg ':class=mdicon :no-zoom') | a so-called "**MACVLAN**" data link layer connection between a physical network card and a container. |
| | ![VxLAN](_media/icons/nifs/Overlay.svg ':class=mdicon :no-zoom') | not shown: Edgeshark additionally understands [VxLAN](https://en.wikipedia.org/wiki/Virtual_Extensible_LAN) overlay network interfaces and then shows a "VxLan" wire between the _overlay_ VxLAN network interface and the corresponding _underlay_ network interface, the latter used for the encapsulated traffic. |

### Navigating the Wiring

More complex Industrial Edge configurations might well feature quite a bunch of
virtual wires. But Edgeshark to the rescue – except that there's no wire cutter
for good reason.

- **Hovering over a wire** highlights the wire itself and also dims all other
  wires. Connected network interfaces also get highlighted. As soon as you move
  the mouse pointer away, all wires return to their normal and non-highlighted
  display.

- **Clicking on a wire** "selects" this wire until either clicking the wire
  again or clicking somewhere else. While a wire is selected, you can move and
  scroll around while the wire stays selected and thus highlighted.
  
  It's even possible to download a screenshot with a wire selected and all other
  wires dimmed: just click on the wire, then click or tap
  ![screenshot](_media/icons/Screenshot.svg ':class=mdicon :no-zoom') in the
  action bar.

## Network Interfaces

Network interfaces in Edgeshark not only show their names, but additional useful
information when dealing with communication.

### Container-Engine Networks

In case a network interface belongs to a container engine-managed network, this
network name will show up as an additional "alias" ❶. For instance below,
_proxy-redirect_ is the name of a Docker-managed container network:

![LAN party!](_images/bridge-alias.png ':class=scrshot')

In addition, network interfaces also show their operational state, such as with
a green "up" arrow ![up](_media/icons/operstates/Up.svg ':class=mdicon
:no-zoom'), a red "down" arrow ![down](_media/icons/operstates/Down.svg
':class=mdicon :no-zoom'), et cetera.

### Physical Network Interfaces

Another useful information is the NIC ("network interface card") icon
![NIC](_media/icons/nifs/HardwareNic.svg ':class=mdicon :no-zoom') that appears
only next to physical network interfaces. On a second thought, "physical"
actually also includes virtual "physical" network interfaces of VMs.

### IP Interface Addresses

Hovering over a network interface shows its type and IP address(es).

![network interface tooltip](_images/nif-tooltip.png ':class=scrshot')

### Related Network Interfaces

When a network interface is connected to at least one other network interface,
then clicking or tapping the network interface badge opens a "navigation" menu.
This menu lists the related (connected) network interfaces together with the
container a particular network interface is placed in.

![network interface navigation](_images/nif-navigation.png ':class=scrshot')

In case "the other end" of an VETH network interface is connected to a
Linux-kernel bridge then Edgeshark displays the bridge name (or its container
engine-managed network name) instead of a usually less helpful `veth...` name.

![VETH navigation](_images/nif-navigation-alias.png ':class=scrshot')

MACVLAN network interfaces offer direct data-link layer 2 access to containers,
it is often of high interest to which physical network interface the container
is actually wired up – as well as the name of the corresponding container
engine-managed network. Edgeshark then shows both the master network interface
name, as well as the container engine network name.

![MACVLAN navigation](_images/nif-navigation-macvlan-master.png ':class=scrshot')

## Networking Details

On purpose, the wiring view does not show most network configuration details –
in order to not totally clog up the display.

To drill down into the network configuration of one of your app containers,
click or tap on a containee badge ❶. You don't need to hit the zoom icon inside
the badge, just clicking or tapping anywhere on the badge is sufficient. This
will switch to a [detail view](details) with information about IP addresses and
routes, DNS configuration, et cetera.

![zoom into details](_images/wiring-zoom.png ':class=scrshot')

Similar, clicking or tapping the zoom symbol ❷ in the top-right corner of any
card will also switch to the detail view for this virtual IP stack. The
difference between ❶ and ❷ is as follows:

- ❶ uses the containee's name for reference, so after a container or app restart
  you can simply refresh the detail view to get the most recent network
  configuration shown.

- In contrast, ❷ uses a Linux-kernel reference to the virtual IP stack and that
  might change after a container restart. However, ❷ is useful in use cases
  where multiple containers sharing the same virtual IP stack and the containers
  might come and go, but never get restarted.
