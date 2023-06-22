# Getting Around

The Edgeshark user interface is web-based and only requires a decent HTML5
browser (Microsoft IE isn't supported).

At a quick first glance:

![Edgeshark web UI](_images/overview.png ':class=scrshot')

* ❶ [Sidebar & Help](sidebar-help) as well as [Navigation](sidebar-navigation)
* ❷ [Discovery](discovery)
* ❸ host information (collapsible to hide it from view) – on Siemens Industrial
  Edge devices this contains additional IED-related information.
* ❹ [Wiring View](wiring)
* [Detail View](details)
* ❺ [Snapshot](snapshot)
* ❻ [Containee Types](containees) (containers, processes, ...)
* ❼ Docker composer projects, including [IE App icons where
  applicable](settings?id=siemens-industrial-edge) (IE App icons only when
  enabled in [settings](settings))
* ❽ [Network Interfaces](nifs)

The Edgeshark user interface gets loaded into the user browser _once_ (and is
compressed to save network resources and time, with only the parts required
getting loaded on demand). The web UI then talks to the JSON API of the
Edgeshark service on the particular container host, fetching only the "raw"
discovery data and rendering it itself in the browser.
