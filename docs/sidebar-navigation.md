# Navigation

After the first discovery the "[containees](containees.md)" section ❶ **in the
sidebar** will fill with the the names of containers and non-containerized
processes with (virtual) IP stacks.

![sidebar container/containee navigator](_images/sidebar-containees.png
':class=scrshot')

We use the term "containees" instead of "containers" in order to refer to
_different_ "things", all with their own virtual IP stacks: yes, containers, but
also stand-alone processes, even Kubernetes pods, and more.

- "Wiring" and "Network Namespace Details" views: clicking or tapping an item ❷
  from the containee list will scroll the corresponding container/containee into
  view as well as highlighting it.
- when the details of a single container/containee are shown: clicking or
  tapping an item ❷ from the containee list will instead switch to the details
  of the selected containee.

> [!NOTE] The Containee section will appear only while either the wiring view is
> shown, or the overall or individual detail views. The containee section stays
> hidden in all other views.

The color of the circle borders around individual container/containee icons
indicates their operational state:
- green: running
- yellow: paused
- blue: no process or a Kubernetes pod

A "strong arm" indication ![elevated
capabilities](_media/icons/containeestates/Capable.svg ':class=mdicon :no-zoom')
appears when a container has been given additional privileges (or more precise:
_capabilities_) than standard Docker containers default to. For fully privileged
Docker containers a "crown" indication
![privileged](_media/icons/containeestates/Privileged.svg ':class=mdicon
:no-zoom') will be shown instead.