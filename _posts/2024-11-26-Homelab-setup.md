---
title: Mini PCs as servers for my homelab
author: peter
date: 2024-11-26 02:48:22 +0800
categories: [SelfHosting]    # 0-2 categories. Blogging | Electronics | Programming | Mechanical | SelfHosting | Guides | University
tags: [homelab,selfhosting,wyse,power,efficiency]   # 0-\infty. systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-11-26-Homelab-setup/preview.png
---

## Dell Wyse 5070

This is my first server which I purchased in April 2024. While I've always been interested in having a server, I never had anything to justify it until I wanted to self-host my Git repositories. Since I wasn't planning on hosting much initially, the criteria for selecting the server was:

- Low idle power consumption (<10 W, comparable to Raspberry Pi 4)
- Low cost (~100 AUD) / better value than Raspberry Pi

### Hardware

I purchased the Dell Wyse 5070 from an [eBay listing](https://www.ebay.com.au/itm/266079359057) for 50 AUD. The package arrived in a box with the charging adapter included.

I populated the *SATA* (Not NVME!) m.2 slot inside the Wyse with a Teamgroup MS30 512 GB m.2 SATA SSD purchased for 65 AUD. The Wyse did **not** come with mounting hardware for the SSD, so I scavenged a 0.6 mm M3 brass standoff and M3 screw from an old motherboard and used it to mount the SSD.

The Wyse came with one 2666 MHz DDR4 4 GB SODIMM populated in one of the two SODIMM slots. I scavenged some 8 GB 2666 MHz DDR4 SODIMMs from an unused laptop to upgrade the 4 GB RAM to 16 GB.

The Wyse appears to have one PCIe slot which was not populated with a connector. While I bought the connector from Mouser, I have not soldered it on or tested if this slot works. The part I bought was the [Amphenol 10018783-10101TLF](https://au.mouser.com/ProductDetail/Amphenol-FCI/10018783-10101TLF?qs=jHhfy7zYaunGToTtySwueg%3D%3D)

### Services

The server uses the Proxmox virtual environment. I am hosting the following in LXCs:

- [Gitea repository](https://git.petertanner.dev/)
- Nginx
- Wireguard VPN
- Paperless NGX
- Owntracks

A Gitea repository and one public Immich instance are the only services exposed to the internet. The other services are only available through the Wireguard VPN for security.

I also have a Debian 12 virtual machine which is for running docker containers. This is used to host Immich, since LXCs are not supported by the Immich project. Two Immich instances are hosted, one for hosting photos to be shared to friends and one which is completely private and can only be accessed through the VPN. While Immich has features to limit who can see photos, I still wanted the security of having two completely isolated instances.

### Power usage

I am measuring the power consumption of the server with a [cheap watt meter](https://www.aliexpress.com/item/1005005916193146.html), these have been thoroughly [reviewed on YouTube](https://www.youtube.com/watch?v=fRGKilvExMo) and appear to be accurate.

The server idles at around 7 W at a load average of ~0.25 and has a maximum power draw at 100% CPU utilization of 14.5 W. An all-time high of 28.2 W was shown on the meter, I believe this was when I was using the USB ports on the Wyse to charge a device.

Over the 228 days the server has been online, it has drawn 36.75 kWh of energy. The running costs are therefore quite low.

The system used 1.2 W when powered off.

### Conclusion

It's been an adequate PC and is a much better choice than the Raspberry Pi platform, but the lack of SATA ports holds this back from being a good server for hosting Immich, since I would like to use cheaper HDDs for future storage.

The main m.2 slot being SATA instead of NVME was annoying since I found NVME drives to be cheaper and more common than m.2 SATA.

## Old computer with i7 8700

🚧🚧🚧 under construction 🚧🚧🚧\
🚧🚧🚧 under construction 🚧🚧🚧\
🚧🚧🚧 under construction 🚧🚧🚧

I have not decided if I will use this server or something else

🚧🚧🚧 under construction 🚧🚧🚧\
🚧🚧🚧 under construction 🚧🚧🚧\
🚧🚧🚧 under construction 🚧🚧🚧

The main problem of the Wyse is the lack of storage expansion, as it is a thin client. I was searching for new servers that could accommodate more drives for cheap, a common recommendation was the HP Elitedesk 800 G3. The i5-6500 variant are available on eBay for ~120 AUD, the i7-7700 variant cost ~200 AUD.

However, at this point it would make sense to just use my old PC which has an i7-8700 since the power usage are relatively similar.

I needed to upgrade the power supply since currently it was using the case included power supply (fire hazard and low efficiency).

### Old setup

This computer was built in 2017 and was used to run Windows 10 desktop. The computer has:

- Intel i7 8700
- Geforce GTX 1060 3 GB
- 16 GB ram (2x 8 GB DDR4 2666 MHz)
- 2x 3 TB WD blue 3.5" drives
- Crucial BX500 480 GB SATA SSD

The system idles at ~52 W at the login screen. With the GPU removed it idles at ~42 W at the login screen. With both HDDs removed it idles at ~35 W at the login screen (I plan to have the HDDs automatically spin down to save power in the final build).

### Storage

### Power usage

I unplugged all HDDs, the disk drive and the GPU.

I used a live USB of Ubuntu 24.01 and used the `powertop` command. Initially the package was only at C2, but after running `sudo powertop --auto-tune` I was able to reduce it to C3 and the power consumption dropped from ~28 W to ~23 W when idle on the desktop of the live USB.

I installed Ubuntu on a spare partition on the SSD, but I could not get it to go below C3, and I could not enable SATA link power management for the SATA port connected to the SSD.

<!-- 
In the BIOS I:

- Disable audio controller
- Enable CEC 2019 Ready
- Enable CPU fan stop in smart fan 5 settings to stop the fan when the CPU temperature is low.
- Change CPU internal AC/DC load line to Power Saving
 -->

In the BIOS I:

<!-- - Enable Platform Power Management
  - Enable ASPM for all (DO NOT ENABLE - THIS PREVENTS ENTERING C3 STATE) -->
- Disable audio controller
- Enable CEC 2019 Ready
- Enable CPU fan stop in smart fan 5 settings to stop the fan when the CPU temperature is low.
- Change CPU internal AC/DC load line to Power Saving
- Turn off RGB fusion
- Under advanced CPU core settings:
  - Enable all C states, set package C state limit to C10
  - Enable CPU EIST Function
  - Enable Race To Halt
  - Enable Energy Efficient Turbo
  - Enable Voltage Optimization
  - Disable Intel® Turbo Boost Technology (Yes this will impact performance, but I wanted to minimize power since I don't need the extra performance)


The system used 1.2 W when powered off.

## Future plans

- [ ] Purchase a cheap UPS
