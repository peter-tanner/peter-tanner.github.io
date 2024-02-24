---
title: Inside a bus USB charger
author: peter
date: 2024-02-24 14:06:00 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, bus] # systems | embedded | rf | microwave | electronics | solidworks | automation
image: /assets/img/2024-02-24-Inside-a-bus-USB-cha/preview.png
---

Random post, on the bus I saw one of those wall-mounted USB chargers with the plastic cover already removed (I did not remove it). This is what the PCB inside of it looks like.

Looks like there are two DC-DC converters, pretty simple. The board also appears to be conformal coated.

EDIT:
Looks like this is just a COTS charging module. Searching `"USB3.25"`, which is present on the sticker on the USB-A port, leads to this [product page](https://www.vignal-group.com/en/30-double-charging-usb-socket-for-a-bus-or-a-coach-6957.html). The [datasheet](https://www.vignal-group.com/en/fiche-technique-30-double-charging-usb-socket-for-a-bus-or-a-coach-6957.pdf) claims it is "equipped with a protection against overvoltages, polarity reversals and short-circuits(intentional vandalism).".

![Charger board](/assets/img/2024-02-24-Inside-a-bus-USB-cha/usb-charger-bus-highres.jpg)
