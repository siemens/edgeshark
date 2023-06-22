# Capturing Container Traffic

> [!ATTENTION] You **must access** the Edgeshark user interface on port `:5001`
> in order to successfully start captures from the UI. Attempting to start
> captures when accessing the user interface via an IED's reverse proxy at port
> `:443` will fail with authentication failures. Unfortunately, this cannot be
> fixed without proper IED support for session hand-overs.

If you haven't done yet so, please follow first the ["Getting started"
instructions](getting-started.md) to install the required capture plugin for
Wireshark on your desktop computer system, and then return here.

Live network packet captures can be started in different ways:

- [starting a capture from the web user interface](capture-ui)
- [starting a capture from Wireshark](capture-extcap)
- [starting a scripted/automated capture from the CLI](capture-cli)
