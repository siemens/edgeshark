# Capture via Wireshark Plugin

Depending on your workflow, you might prefer to directly work in Wireshark all
the time, instead of using the browser-based UI.

Before you start Wireshark, make sure you have [installed the ClusterShark
plugin](getting-started) and then start Wireshark as usual.

## Wireshark "Capture" Screen

Wireshark's "capture" screen should now list three new capture interfaces, but
we're only interested in the one named "**Docker host capture…**". In the
screenshot below we've hidden all other capture interfaces in order to show an
uncluttered picture, you'll usually see many more capture interfaces and
plugins. (As this user documentation focuses on Edgeshark, we won't detail the
other plugins.)

![Wireshark Capture](_images/cs-docker-defaulttab.png ':class=scrshot')

1. **Double-click once on the gear icon. Do NOT double-click on "Docker host
   capture…"**

   > [!NOTE] If you accidentally double-clicked on the text then you'll need to
   > wait a few seconds for Wireshark sorting out lots of things until it
   > realizes it was a failure. Simply then try again by double-clicking the
   > gear icon this time.

This brings up the capture dialog.

## Capture Dialog

![Capture dialog](_images/cs-docker-defaulttab.png ':class=scrshot')

To start your capture…

2. enter the http(!) URL with the DNS name/IP address of your Industrial Edge
   Device and port `5001`, such as `http://myied.my-company.com:5001`.
   Do **not use https://**.
3. click or tap the refresh button right to the "Containers" selection.
4. select the container you want to capture from.
5. click or tap the "Start" button to start the capture (unless you need special
   proxy settings in which case you should have a look at the "Proxy" tab
   first).

> [!NOTE] If you get an error after some time for failed authentication or
> failed certificate verification you most probably have used "https:" instead
> of "http:". It's not possible at this time to use the reverse proxy of IEDs
> for live capture. Checking "Skip server certificate validation" will not help,
> as the authentication with the reverse proxy then will fail.

<!-- -->
> [!NOTE] On purpose, there's no automatic refresh because otherwise a
> non-responding IED or invalid URL will cause the dialog to initially hang for
> at lots of seconds before finally timing out and Wireshark doesn't support
> canceling operations from a capture dialog._)

## Live Capture

Wireshark now changes into its "main" view with the famous network packet
display. It might take a few seconds for Wireshark to start the capture plugin
and to connect to your remote Industrial Edge device with its Edgeshark capture
service.

![live capture view](_images/wireshark-view.png ':class=scrshot')

Live captures can be stopped as usual by pressing the "stop" button in
Wireshark's toolbar.

A special feat (and feature) of Edgeshark is hiding behind the capture
properties button ❶ in Wireshark's status bar. Clicking or tapping it opens the
standard capture properties … but with some quite useful additional
information not offered by standard capture tools.

## Enhanced Capture Properties

Edgeshark is unique in that it enhances capture properties with details that
today's tools ignore, yet that are important for diagnosis in container systems.

![enhanced capture properties](_images/wireshark-capture-props.png ':class=scrshot')

- container-related information ❶ detailing, for instance, the container name.
  As a container's hostname is usually its unique ID as opposed to its (service)
  name, this is an important piece of information to keep with your captures.
- even when capturing form all network interfaces of a container simultaneously,
  the interface statistics ❷ still list the individual network interfaces. No ugly "all" mess without any interface differentiation.

## Restart Last Capture

Users can (re)start a new capture without going through the capture dialog by
simply double-clicking on the "Docker host capture…" item in Wireshark's
capture list.

The new capture session will capture from the same container and network
interface(s) as the previous session. This works also after restarting IE app
containers … and even after deinstalling and reinstalling an IE app. The reason
is that Edgeshark captures use the _name_ of a container (whenever possible) as
opposed to some transient Linux IP-stack identifier.
