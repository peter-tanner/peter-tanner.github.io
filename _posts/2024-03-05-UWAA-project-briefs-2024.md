---
title: UWAA project briefs 2024
author: peter
date: 2024-03-05 10:40:20 +0800
categories: [UWAA] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, projects] # systems | embedded | rf | microwave | electronics | solidworks | automation
# image: assets/img/2024-03-05-UWAA-project-briefs-/preview.png
toc: true
---

Updating this as I add new projects this year.

# Telemetrum ground station

The Telemetrum's Teledongle ground station is out of stock everywhere. We should make our own.

## Success criteria

- Receive signals from the [Telemetrum](https://altusmetrum.org/TeleMetrum/) flight computer over a distance of at least 10 kft.
- Send data to a computer over USB virtual COM port in a format which can be interpreted in real time by the [AltosUI flight monitoring software](https://altusmetrum.org/AltOS/).

## Scope

- Make a PCB which contains a cheap microcontroller with USB support and the CC12xx or CC11xx radio transceiver.
  - Make sure the PCB has mounting holes so it can fit into a case.
  - Use an SMA connector.
- Create software to copy the data from the receiver to the computer over USB through an intermediate MCU.

## Hints and notes

- You must read this [protocol specification](https://altusmetrum.org/AltOS/doc/telemetry.html) for the AltusMetrum devices. Luckily, the Teledongle does minimal processing of the raw data, it only encodes it into an ASCII format before transmitting it over serial.
- You should look at the schematics and PCB layout for the Teledongle for inspiration https://altusmetrum.org/TeleDongle/.
  - I advise you don't use the NXP LPC11U14 since a cheaper microcontroller can do well
- [!] PRO TIP: Use JLCPCB's part library to save on money! It tends to be cheaper per unit than buying from distributors online since JLC buys the parts at wholesale prices.
  - You should consider using the [basic parts library](https://jlcpcb.com/parts/basic_parts) to place passives (resistors, capacitors). On Altium, all components in this library will have a `JLC_PN` attribute.
  - Using extended parts outside the basic library list will incur a $3 USD fee per unique part, but when assembling 5 boards this still beats distributor prices. Of course, if a part is in the basic library it should be used if possible
  - You may decide to use this alternative site to look up parts since JLC's parametric search isn't great https://yaqwsx.github.io/jlcparts/
  - Try to place all/as many components on one side of the board only so you can use economic PCBA, which only places parts on one side.
  - Feel free to ask me for Altium training, and I will probably need to talk about RF design considerations

## Future development

- Make this a module card which can go into a standalone battery powered ground station which does not need a laptop to use. This can be helpful if our laptops run out of energy and there are no generators.

# Analog video transmitter

## Success criteria

- Receive at least 1 minute of video over a 10 kft LOS distance

## Scope

- Make a prototype setup to transmit and receive analog or digital video
- Use a raspberry pi to overlay text containing telemetry such as altitude, position, etc.
- Does not need to be a PCB yet

## Hints and notes

- To be honest, I am not quite sure how this stuff works and I'm interested in learning as well
- Two ways I can see this being done:
  - 1. Use a project like wifibroadcast[[1](https://befinitiv.wordpress.com/wifibroadcast-analog-like-transmission-of-live-video-data/)][[2](https://hackaday.com/2015/06/13/wifibroadcast-makes-wifi-fpv-video-more-like-analog/)] which transmits digital video. Check out the link for more information.
  - 2. Use a COTS analog 2.4 GHz video transmitter and receiver. Search 2.4 GHz video transmitter for examples. The TX6722 and RX6788 appears to be a common combination for 2.4 GHz band.
  - Consider the differences in quality, error handling and bandwidth required when deciding between analog and digital video
- I'll update this once we get past a prototype

# Software defined gnss receiver

## Success criteria

- Get position and altitude of the rocket through all stages of flight, including stages which exceed the velocity and/or altitude limitations of commercial GNSS receivers (510 m/s, 59,000 ft. See: [Coordinating Committee for Multilateral Export Controls](https://en.wikipedia.org/wiki/Coordinating_Committee_for_Multilateral_Export_Controls?&useskin=vector))

# Scope

- Make a prototype/MVP system for doing this. It doesn't need to fit into a rocket or require self-powering at this current design phase. I will update the project when we have an MVP working.
- Test doing the post-processing on a single board computer.
- Record enough data from launch to landing

# Hints and other notes

- Capture raw [IQ](https://en.wikipedia.org/wiki/In-phase_and_quadrature_components?&useskin=vector) data from an SDR and do the post-processing in something like [GNSS SDR](https://github.com/gnss-sdr/gnss-sdr). Select an appropriate SDR which can digitize the L1 C/A GPS signal
- This exists https://www.rtl-sdr.com/rtl-sdr-tutorial-gps-decoding-plotting/, but it seems to require a computer with windows installed to process the data.

# Future development

- Miniaturize this setup and add a power system for use on a rocket
- Make a custom RF frontend specialized for the GNSS signals which is cheaper than buying an SDR
- Is it possible to use an FPGA to process this signal in real-time? (It's apparently really hard to do... I searched and the latest real-time implementation is from 2013)
