# System Information

After discovery information has been gathered for the first time, the
[wiring](wiring) and [detail](details) views additionally show system
information, such as:

- (system) host name,
- host OS information read from the host's `/etc/os-release`,
- Linux kernel information from host's `/proc/version`,
- runtime version of Industrial Edge Device,
- the version(s) of the container engine(s) detected.

![system information](_images/discovery-metadata.png ':class=scrshot')

The system information can be collapsed and expanded by clicking or tapping the
arrow symbol ❶ horizontally centered at the top of the view. This display state
is kept across sessions and the different views, on a per-device basis.

As the system information is included in [snapshots](snapshot), this keeps it
right next to the communication and network configuration information.
