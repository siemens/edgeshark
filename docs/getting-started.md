<!-- markdownlint-disable MD029 -->
# Getting Started

**Edgeshark** consists of
1. two containerized 🛎 services named
   [Ghostwire](https://github.com/siemens/ghostwire) and
   [Packetflix](https://github.com/siemens/packetflix),
2. as  well as an _optional_ Wireshark ⚙️ [csharg external capture
   plugin](https://github.com/siemens/cshargextcap) for live remote capture of
   network traffic.

## Service Deployment

We provide multi-architecture Docker images for the `linux/amd64` and
`linux/arm64` architectures.

<!-- tabs:start -->

#### **Docker Compose v2**

First, ensure that you have the Docker compose plugin v2 installed: `docker
compose version` should display the compose plugin version, but not any error.
For Debian users we recommend installing `docker-ce` instead of `docker.io`
packages, as the `docker-ce` packages are updated on a regular basis.

Then copy and paste the following command into a terminal to deploy the
Edgeshark services:

```bash
wget -q --no-cache -O - \
  https://github.com/siemens/edgeshark/raw/main/deployments/nocomposer/edgeshark.sh \
  | docker compose -f - up
```

Finally, visit http://localhost:5001 and start looking around your container
host virtual networking.

> [!WARNING] This quick start deployment will **expose TCP port 5001** also to
> clients external to your host. Make sure to have proper network protection in
> place.

#### **Docker Bash**

In case your particular system doesn't support Docker compose v2, we provide a
simple fallback using a plain `bash` script.

```bash
wget -q --no-cache -O - \
  https://github.com/siemens/edgeshark/raw/main/deployments/bash/docker-compose.yaml \
  | bash -s up
```

The bash script takes a single argument, either `up` or `down`.

Finally, visit http://localhost:5001 and start looking around your container
host virtual networking.

> [!WARNING] This quick start deployment will **expose TCP port 5001** also to
> clients external to your host. Make sure to have proper network protection in
> place.

#### **Industrial Edge**

1. Download the [latest Edgeshark app `.zip`
   file](https://github.com/siemens/edgeshark/releases/latest) from the releases
   section of this project. At the moment, we provide only app files for the
   `linux/amd64` platform (a.k.a. `linux/x86-64`).

2. Unpack the contained `edgeshark.app` file inside the `.zip` archive.

3. Import the Edgeshark app file `edgeshark.app` into your IEM
   Industrial Edge Management system.

4. Go to the catalog of your IEM and deploy/install the Edgeshark app onto your IED
   Industrial Edge Device(s).

  > [!WARNING] The Edgeshark UI and services are exposed on port 5001 on your
  > IED hosts **without any user authorization**. This is required in order to
  > support initiating remote packet captures from the user interface. (There's
  > nothing we can do until the IED-OS starts supporting session hand-overs from
  > a user web browser to an external application.)

5. Navigate your browser to port HTTP 5001 on your IED:
   `http://`_ied-ip-address_`:5001` (please make sure to use `http:` and **not**
   `https:`). You should now see the "Edgeshark" user interface.

   > [!NOTE] You can use the remote access and then click on or touch the
   > Edgeshark app tile in the IED user interface. However, you cannot use
   > remote access to start remote captures (due to the aforementioned IED-OS
   > limitation).

<!-- tabs:end -->

Please see [Getting around](getting-around) for a tour of the user interface.

Deploying Edgeshark creates the two services named packetflix and gostwire, and
expose **port 5001** on the host as shown below. Please note that access via the
Industrial Edge device reverse proxy is specific to this platform. 

![Edgeshark Services](_media/edgeshark-services.png)

## Optional Capture Plugin

Please note that you only need to install the external capture plugin
"[cshargextcap](https://github.com/siemens/cshargextcap)" for Wireshark if you
intend to live capture container network traffic. Otherwise, you can completely
ignore this section.

<!-- tabs:start -->

#### **Windows 64bit**

We offer a Windows 64 bit installer for the `amd64` (`x86-64`) platform only.

1. Make sure that you have a sufficiently recent [Wireshark (64
   bit)](https://wireshark.org) installed. At least version 3.0.2 or later is
   required, as otherwise the plugin won't work correctly due to bugs in
   Wireshark. Wireshark 4.x is also supported.

2. [Download the latest Windows
   installer](https://github.com/siemens/cshargextcap/releases/latest) `.zip`
   file from the releases page of the siemens/csharkextcap project.

3. Double click on the downloaded `.zip` file to view its contents and then
   simply run the included installer executable inside it. Next, follow the
   on-screen instructions of the installer.

#### **Linux 64bit**

We offer distribution-specific packages in `.apk`, `.deb`, and `.rpm` formats
for both `amd64` and `arm64` architectures.

1. install Wireshark from your distribution repositories and allow it to be used
   by non-root users.
2. [add your user to the wireshark group](https://askubuntu.com/a/461037) (ask
   Ubuntu):

   ```bash
   sudo gpasswd -a $USER wireshark
   ```

   This is necessary so that Wireshark can correctly execute `dumpcap` for your
   non-root user in order to use the external capture plugin.
3. log out of your session and then in again so that the new group assignment
   takes effect.
4. [Download the latest plugin package](https://github.com/siemens/cshargextcap/releases/latest) suitable for your distribution and CPU architecture.
5. install the downloaded plugin package.
6. _optionally:_ start Wireshark to verify that the plugin was correctly
   detected and queried: three new external capture targets should have been
   added ("Docker host capture" and "packetflix:// remote cluster and container
   host capture").

   ![external capture plugins](_images/wireshark-linux-extcaps-list.png
   ':class=scrshot')

<!-- tabs:end -->

Please see [Capturing](capture) for how to capture container network traffic
using Wireshark with Edgeshark.
