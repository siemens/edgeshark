# Filtering

In the [Wiring](wiring) and [Details](details) views, Edgeshark supports
filtering the discovered virtual IP stacks, in order to reduce the amount of
information displayed for busy container hosts.

To set a filter, press either <nobr><kbd>Ctrl</kbd>+<kbd>f</kbd></nobr> or
<kbd>/</kbd>: this opens the sidebar and places the text cursor into the filter
pattern field. Edgeshark supports both substring patterns as well as regular
expressions.

![filtering](_images/filtering.png ':class=scrshot')

- ❶ the **filter pattern**, either:
  - a **substring** that must be included in a containee's name, Composer
    porject, or Kubernetes pod,
  - or a [**regular expression**](https://regex101.com/) in
    ECMAScript/JavaScript syntax when the option
    ![regexp](_media/icons/Regexp.svg ':class=mdicon :no-zoom') ❸ is active.
- ❷ ![regexp](_media/icons/Case.svg ':class=mdicon :no-zoom') switches
    between _case-insensitive_ and _case-sensitive_ pattern matching.
- ❸ ![regexp](_media/icons/Regexp.svg ':class=mdicon :no-zoom') switches between
  _substring_ pattern matching and _regular expression_ matching.

Press <kbd>Enter</kbd> or <kbd>Esc</kbd> to close the sidebar, so that when you
return to a host the last filter set will be applied again.

Filtering pattern and options are stored in your browser's per-host local
storage.

When filtering is active – that is, the filter pattern is not empty –, Edgeshark
displays a notice ❶ at the top of the wiring and details views. This is to
remind you that the filter is currently restricting the amount of virtual IP
stacks displayed, so you aren't wondering in vain why the display looks like it
is incomplete. 

![filtering notice](_images/filtering-notice.png ':class=scrshot')
