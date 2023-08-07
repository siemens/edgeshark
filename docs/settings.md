# Settings

The Edgeshark UI settings are accessed from the sidebar. These settings allow
tweaking certain user interface aspects, most prominently switching between a
light or dark theme.

Settings are stored in your web browser using [web (local)
storage](https://en.wikipedia.org/wiki/Web_storage), but never on any Industrial
Edge device itself. The settings are individually stored inside the browser per
host name. They can be fully cleared in browsers, please see your browser's user
manual for details about how to clear web storage.

![settings](_images/settings.png ':class=scrshot')

## Appearance

- Switches between a light and dark theme. It optionally takes user preferences
  into account, though whether desktops actually pass their user's preference to
  browser is still a topic for endless discussions and experiments.

## Display Filters Layer 2/3

- **IP address families**: Edgeshark is fully IPv6 and "dual stack"-enabled.
  However, to avoid explosive allergic user reactions to overlong IPv6 addresses
  the default setting is to show only IPv4 addresses.
- **"isolated" network namespaces with only "lo"**: Edgeshark defaults to **not
  showing** such virtual IP stacks that do not possess any physical network
  interface or connection to any other virtual IP stack. This hides
  system-internal isolated IP stacks in order to reduce visual clutter.
- **"lo" interfaces**: each and every virtual IP stack possesses at least a
  so-called "loopback" network interface named "lo". In order to reduce visual
  clutter, Edgeshark on default hides the loopback network interfaces.
- **MAC addresses**: Edgeshark defaults to hiding the MAC (data link layer)
  addresses of network interfaces.

## Containee Details

"Containees" is a summary term encompassing not only containers, but also
non-containerized processes and even virtual IP stacks without any process.
(It's even possible to "anchor" process-less IP stacks to the file system using
so-called "bind mounts".)

- **"sandbox" containers**: only applicable in Kubernetes environments, so it
  has no effect on IEDs.
- **namespace identifiers**: nerd option that enables displaying the inode
  numbers of the [network namespaces](netns) acting as the virtual IP stacks.
  Sadly, Linux-kernel namespaces don't have names, they only have inode numbers
  for their identification.

## Detail Sections Default Expansion

The detail information about the communication of a virtual IP stack is divided
into logical sections:
- [container (containee) details](details#containerscontainees),
- [neighborhood services](details#neighborhood-services) (Docker only),
- forwarded TCP/UDP ports,
- [TCP/UDP transport ports](details#transport),
- [IP stack routes](details#routing),
- [network interfaces configuration](details#interface-configuration).

As the information at least in some sections can get quite large, users might
want to set their preferences as to when to collapse or expand the individual
sections, based on the amount of information present.

In general, user can control for each individual section:

- **always show collapsed** (minimized),
- **always show expanded**,
- up to a **threshold** of 1-5, 10, 20, or 30 items expand the section, if above
  the threshold then show the section collapsed.

## Siemens Industrial Edge

- Experimental option to enable showing IE App icons and titles. Edgeshark
  defaults to **not showing** individual IE App icons, so users need to
  explicitly enable this feature when wanted. App-related information about
  icons and titles is read directly from an IED's local device database and thus
  does not require any IEM connectivity.
