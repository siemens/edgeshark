# Network Namespaces

…are a Linux kernel-level mechanism to virtualize IP stacks at the OS level. So,
a single Linux OS can have many distinct network/IP stacks at the same time.

## Technical Background

What we slightly sloppily call “virtual IP network stacks” are actually a highly
useful Linux technology termed "[network
namespaces](https://man7.org/linux/man-pages/man7/network_namespaces.7.html)".
Despite the terminology and in a twist of irony, these Linux “**namespaces**”
**do not have names**. Historically, the first type of namespace in Linux was
the“mount” type of namespace and this type is all about file system paths … now
we can see where the meaning of “namespace” originates from.

Luckily, Edgeshark tries its best to give network namespaces useful names: for
instance, taken from the names of containers or processes that are using these
network namespaces. This enhances your user experience and makes diagnosing
virtual communication so much easier: “morbid_moby” instead of a non-permanent
inode number, such as “4026531905”, or some arcane file system reference such as
"/proc/12345/ns/net".

Throughout Edgeshark, we use the term “[containees](containees.md)” whenever we
are referring to containers, standalone processes, or even so-called
“bind-mounted” network namespaces (the latter are without _any_ process, not
least any whacky container).

## Containers ≠ Namespaces

While containers make use of Linux network namespaces, "containers" and
"namespaces" are _two completely separate_ technologies. Containers are a
user-space “lie” in that they don’t exist at all at the level of the Linux
kernel. But containers combine several “first class” kernel-space elements to
make their lie more convincing, not least network namespaces.
