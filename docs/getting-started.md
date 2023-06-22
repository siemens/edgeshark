<!-- markdownlint-disable MD029 -->
# Getting Started

Edgeshark consists of two services
([Ghostwire](https://github.com/siemens/ghostwire) and
[Packetflix](https://github.com/siemens/packetflix)), as  well as an _optional_
Wireshark [csharg external capture
plugin](https://github.com/siemens/cshargextcap) for live remote capture of
network traffic.

Siemens Industrial Edge users can simply deploy the Edgeshark App.

For "plain" stand-alone container hosts, deploy the
[Ghostwire](https://github.com/siemens/ghostwire) and
[Packetflix](https://github.com/siemens/packetflix) using their respective
Docker composer deployment files.

## Industrial Edge App

> [!ATTENTION] Please note that we're working on providing in the future IE App
> build artefacts in the download section of this project.

1. Import the Edgeshark app (file named `edgeshark_*.app`) into your IEM
   Industrial Edge Management system.

2. Go to the catalog of your IEM and install the Edgeshark app onto your IED
   Industrial Edge Device(s).

  > [!WARNING] The Edgeshark UI and services are exposed on port 5001 on your
  > IED hosts **without any user authorization**. This is required in order to
  > support initiating remote packet captures from the user interface. (There's
  > nothing we can do until the IED-OS starts supporting session hand-overs from
  > a user web browser to an external application.)

3. Navigate your browser to port HTTP 5001 on your IED:
   `http://`_ied-ip-address_`:5001` (please make sure to use `http:` and **not**
   `https:`). You should now see the "Edgeshark" user interface.

   > [!NOTE] You can use the remote access and then click on or touch the
   > Edgeshark app tile in the IED user interface. However, you cannot use
   > remote access to start remote captures (due to the aforementioned IED-OS
   > limitation).

Please see [Getting around](getting-around) for a tour of the user interface.

Deploying Edgeshark on an Industrial Edge looks as below, with the service
exposed via port `:443` (TLS, via the IED reverse proxy service) and directly
HTTP-only on port `:5001`.

![Edgeshark Services](_media/edgeshark-services.png)

## Optional Capture Plugin

Please note that you only need to install the external capture plugin
"[cshargextcap](https://github.com/siemens/cshargextcap)" for Wireshark if you
intend to live capture container network traffic. Otherwise, you can completely
ignore this section.

### Windows 64 bit

We offer a Windows 64 bit installer (amd64 only) for the compiled plugin binary.

1. Make sure that you have Wireshark (64 bit) installed, at least version 3.0.2
   or later is required (otherwise the plugin won't work correctly due to bugs
   in Wireshark).

2. run the appropriate installer `csharg-*.exe` and follow the on-screen
   instructions.

Please see [Capturing](capture) for how to capture container network traffic
using Wireshark with Edgeshark.

### Debian/Ubuntu Linux 64 bit

As we don't offer an installer at this time, please install the plugin binary as
follows:

1. install Wireshark `sudo apt-get install wireshark` and allow it to be used by
   non-root users.
2. [add your user to the wireshark group](https://askubuntu.com/a/461037):

   ```bash
   sudo gpasswd -a $USER wireshark
   ```

   – Wireshark needs to run `dumpcap` from your
   non-root user in order to use the external capture plugin.
3. log out of your session and then in again so that the new group assignment
   takes effect.
4. to install the plugin package suitable for your Linux distribution, such as
   on Debian-based distributions:
   
   ```bash
   sudo dpkg -i cshargextcap-*.deb
   ```

5. optionally: start Wireshark to check that the plugin was correctly detected
   and queried: three new external capture targets should have been added
   ("Docker host capture" and "packetflix:// remote cluster and container host
   capture").

   ![external capture plugins](_images/wireshark-linux-extcaps-list.png
   ':class=scrshot')

6. [starting a capture via Web UI](capture-ui).
