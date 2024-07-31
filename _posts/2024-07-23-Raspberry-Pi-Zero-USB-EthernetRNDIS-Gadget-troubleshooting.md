---
title: Raspberry Pi Zero USB Ethernet/RNDIS Gadget troubleshooting
author: peter
date: 2024-07-23 05:43:32 +0800
categories: [Blogging] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [getting started] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-07-23-Raspberry-Pi-Zero-US/preview.png
---

This is a VERY messy guide outlining my struggles to get raspberry pi zero W USB Ethernet/RNDIS Gadget working on Windows with a shared internet connection.

## TL;DR:

- Download the ACER RNDIS driver
- Add the drivers to the boot
- Set a static IP address and set this in your host operating system's network manager
- When sharing network, add some stuff to the `/etc/network/interfaces` file and most importantly NEVER USE WSL in NAT networking mode (Use `bridged` on windows 11 or the undocumented `virtioproxy` on windows 10) to connect to the pi since wsl has issues with internet connection sharing (ICS) on windows.
- Don't use bookworm, just use bullseye? **For this guide I'm using bullseye since I gave up on bookworm**

## `/boot/config.txt`

Add this to the end of `/boot/config.txt`

```ini
[all]
dtoverlay=dwc2,dr_mode=peripheral
```

## `/boot/cmdline.txt`

Add `modules-load=dwc2,g_ether` after `rootwait`. Not sure if the order matters, but this is what my cmdline looks like with the modification.

```bash
console=serial0,115200 console=tty1 root=PARTUUID=$UID rootfstype=ext4 fsck.repair=yes rootwait modules-load=dwc2,g_ether cfg80211.ieee80211_regdom=AU
```

**Reboot the pi**

## RPI shows up as USB COM port/Serial device in device manager

Right click the device > update driver > browse my computer for drivers

Select the folder containing the **unzipped** [ACER RNDIS driver](https://www.catalog.update.microsoft.com/Search.aspx?q=usb%5Cvid_0525%26pid_a4a2). You may use 7-zip to unzip catalog files.

Download the driver [here](https://www.catalog.update.microsoft.com/Search.aspx?q=usb%5Cvid_0525%26pid_a4a2)

Then the device should show up as an RNDIS Gadget device instead of the serial device.

Reload the `g_ether` module (see next part)

## Tip: command to re-enumerate the device without unplugging and replugging

This unloads and reloads the `g_ether` driver which makes the gadget renumerate (at least on windows).

```bash
sudo modprobe -r g_ether && sleep 3 && sudo modprobe g_ether
```

## Cannot resolve hostname, status is Media Disconnected in `ipconfig`

Example `ipconfig` output:

```
Ethernet adapter Ethernet 4:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : USB Ethernet/RNDIS Gadget
   Physical Address. . . . . . . . . : 11-22-33-44-55-66
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
```

You'll need to go through the steps of setting the static IP address

Follow this [adafruit tutorial](https://learn.adafruit.com/turning-your-raspberry-pi-zero-into-a-usb-gadget/ethernet-gadget)

TLDR of the adafruit tutorial:

1. Add this to the end of `/etc/dhcpcd.conf` (Avoid changing `/etc/network/interfaces` which is old)

   (Change the address/gateway as required)

```
interface usb0
static ip_address=192.168.0.15/24
static routers=192.168.0.1
static domain_name_servers=1.1.1.1
```

2. Reload `g_ether` module as described earlier

3. Follow steps in the adafruit tutorial to configure the network in network and sharing center.

   Right click RNDIS network adapter in network and sharing center > properties > select Internet Protocol Version 4 (TCP/IPv4) > properties

   Set to "use the following ip address" and put the gateway address (`192.168.7.1`) for **BOTH IP address AND default gateway**, use a mask of 255.255.255.0

## SSH

SSH to the address (in this example 192.168.7.**2**, NOT the gateway address 192.168.7.**1**)

```bash
ssh pi@192.168.7.2
```

## Share your network adapter

Without sharing having the usb ethernet gadget connected seems to disconnect the pi from the internet, even if the wifi is enabled.

Not sure if this is required since I tested this after I caught the WSL error (see below), but I added the following lines `/etc/network/interfaces` as per the adafruit guide:

```
auto lo usb0
iface lo inet loopback

iface eth0 inet manual

allow-hotplug wlan0
iface wlan0 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

allow-hotplug wlan1
iface wlan1 inet manual
    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

allow-hotplug usb0
iface usb0 inet manual
```

You need to share your main network adapter, for example a wifi card with the ethernet gadget adapter. Double-click your main adapter (ethernet or wifi card for example) > properties > sharing

Check "Allow other network users to connect ..." then select the adapter for the raspberry pi. You do not need to check the box allowing the adapter to take control of the host adapter.

Press OK and confirm.

⚠ Note that I changed the PI's IP address to match the local network (192.168.137.1). If you need to change the IP address you will get a dialog box when you confirm network sharing. For example, I got a dialog stating an IP address of 192.168.137.1, so change the PI's IP address to something like 192.168.137.135. Don't forget to update the static IPs.

![ics warning](/assets/img/2024-07-23-Raspberry-Pi-Zero-US/warning-ics.png)

Now when you ssh into the pi from cmd.exe (NOT FROM WSL: See below), you should be able to access the internet.

```
C:\Users\Peter>ssh peter@192.168.137.135
The authenticity of host '192.168.137.135 (192.168.137.135)' can't be established.
-- ✂ snip --
peter@raspberrypi:~ $ ls
peter@raspberrypi:~ $ ping google.com
PING google.com (ADDRESS2) 56(84) bytes of data.
64 bytes from ADDRESS1 (ADDRESS2): icmp_seq=1 ttl=56 time=50.9 ms
64 bytes from ADDRESS1 (ADDRESS2): icmp_seq=2 ttl=56 time=50.8 ms
64 bytes from ADDRESS1 (ADDRESS2): icmp_seq=3 ttl=56 time=49.9 ms
^C
--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2004ms
rtt min/avg/max/mdev = 49.909/50.530/50.855/0.439 ms
```

### ⚠ IMPORTANT NOTE ON WSL1/2 and `Destination Host Unreachable` error:

DO NOT USE WSL to connect to the device in NAT mode, internet connection sharing (ICS) seems to break WSL networking resulting in any attempts to ping devices on the network failing (example errors for searchability)

This appears to be related to this [github issue](https://github.com/microsoft/WSL/issues/8428)

EDIT 2024-07-28: It appears that the NAT networking mode specifically causes this issue, you may try bridged networking mode in windows 11 (I am using windows 10 so I cannot test this) or the undocumented virtioproxy mode in windows 10.

Add this to your `wsl.conf` or `.wslconfig` file and restart wsl:

```ini
[wsl2]
networkingMode=virtioproxy
```

Note that the `virtioproxy` mode does appear to slow networking down, for example when I run a GUI X program such as `cool-retro-term` over the network to xming on the windows host side, the performance is heavily degraded when using `virtioproxy`.

Example of me failing to ping the device over wifi when using NAT mode

```
[13:08:21] peter@MACHINE : ~ (master)
$ ssh peter@10.1.1.124
ssh: connect to host 10.1.1.124 port 22: No route to host
[13:08:58] peter@MACHINE : ~ (master)
$ ping 10.1.1.124
PING 10.1.1.124 (10.1.1.124) 56(84) bytes of data.
From HOST icmp_seq=3 Destination Host Unreachable
From HOST icmp_seq=6 Destination Host Unreachable
^C
--- 10.1.1.124 ping statistics ---
7 packets transmitted, 0 received, +2 errors, 100% packet loss, time 6218ms
```

Example of me failing to ping the ethernet gadget directly when using NAT mode

```
[13:07:20] peter@MACHINE : ~ (master)
$ ssh peter@192.168.137.135
ssh: connect to host 192.168.137.135 port 22: No route to host
[13:08:07] peter@MACHINE : ~ (master)
$ ping 192.168.137.135
PING 192.168.137.135 (192.168.137.135) 56(84) bytes of data.
From HOST icmp_seq=3 Destination Host Unreachable
From HOST icmp_seq=6 Destination Host Unreachable
^C
--- 192.168.137.135 ping statistics ---
9 packets transmitted, 0 received, +2 errors, 100% packet loss, time 8283ms
```

## General Failure when pinging the machine after rebooting Windows

- If you are using a Wireguard VPN client which is activated on startup, try disconnecting and reconnecting the VPN tunnel
- Make sure the the static IP configuration is still correct (You might need to re-configure this when switching to a new network if it gets reset)

## It still doesn't work

I originally used debian bookworm lite as my OS, but looks like there are still a lot of issues specifically with the ethernet gadget and I never got it to work (In my case, while I could ping the pi I could never ssh into it, it appeared that the packets were never being recevied by the pi according to the `sshd` logs).

In the end I just switched to bullseye and everything worked fine.

## Other notes

- I ran this command `sudo systemctl enable getty@ttyGS0.service` in desperation on the bullseye OS installation, but I'm not sure if this is required for SSH access. This was from a random section in the [USB ethernet guide](https://forums.raspberrypi.com/viewtopic.php?t=306121) and appears to be for enabling the `screen` command to work properly, so probably not necessary for SSH.
