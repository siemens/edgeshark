# Filtering

In the [Wiring](wiring) and [Details](details) views, Edgeshark allows filtering
the discovered virtual IP stacks. However, when viewing the details of a
_single_ virtual IP stack, filtering is not possible and the filtering pattern
input together with the options buttons hidden.

To open the sidebar and place the text cursor into the filter pattern field,
ready for input, press either <span class="key">Ctrl</span>+<span
class="key">f</span> or <span class="key">/</span>.

![filtering](_images/filtering.png ':class=scrshot')

- ❶ filter pattern, either taken as:
  - a _substring_ that must be included in a containee's name, Composer porject,
    or Kubernetes pod,
  - or a [_regular expression_](https://regex101.com/) in ECMAScript/JavaScript
    syntax when the option ![regexp](_media/icons/Regexp.svg ':class=mdicon
    :no-zoom') ❸ is active.
- ❷ ![regexp](_media/icons/Case.svg ':class=mdicon :no-zoom') switches
    between _case-insensitive_ and _case-sensitive_ pattern matching.
- ❸ ![regexp](_media/icons/Regexp.svg ':class=mdicon :no-zoom') switches between
  _substring_ pattern matching and _regular expression_ matching.

Press <span class="key">Enter</span> or <span class="key">Esc</span> to close
the sidebar.

When filtering is active – that is, the filter pattern is not empty –, Edgeshark
displays a notice at the top of the wiring and details views. This is to remind
you that the filter is currently restricting the amount of virtual IP stacks
displayed, so you aren't wondering in vain why the display looks like it is
incomplete. 

![filtering notice](_images/filtering-notice.png ':class=scrshot')
