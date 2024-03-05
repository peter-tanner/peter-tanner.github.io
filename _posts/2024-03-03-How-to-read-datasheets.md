---
title: How to read datasheets
author: peter
date: 2024-03-03 01:10:38 +0800
categories: [Blogging] # Blogging | Electronics | Programming | Mechanical
tags: [getting started] # systems | embedded | rf | microwave | electronics | solidworks | automation
# image: assets/img/2024-03-03-How-to-read-datashee/preview.png
---

General advice on how to read a datasheet

## Digital pins

### Inverted/Active low/NOT

A pin which is active low is typically designated with a `/` or an overbar

For example: /CS or <span style="text-decoration:overline">CS</span>

A common example is the chip select (/CS) pin on devices with SPI, where the chip select must be low for the SPI on the chip to become active. When it it high, it is idle.
