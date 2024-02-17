---
title: PCB manufacturing checklist
author: peter
date: 2024-02-18 00:06:32 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics] # systems | embedded | rf | microwave | electronics | solidworks | automation
---

A list of things to check before putting a board into production. Update this list as fails occurs.

## Pre-ordering

- [ ] Put `JLCJLCJLCJLC` text on the PCB to ensure the order number is placed in a hidden location under a connector, large component, etc.

## PCB ordering

### Ordering

- [ ] Select "Specify a location" for remove order number to ensure the the `JLCJLCJLCJLC` text is replaced with the order number.\
       ![](/assets/img/2024-02-18-PCB-manufacturing-ch/order-number.png)
- [ ] Make sure expensive items/option parts not meant for assembly are not placed down/autodetected by JLCPCB's parts catalog (you should use the variants system to ensure this cannot happen).
- [ ] Check the orientation of each IC and diode in the PCBA list. For each item, make a note that it has been checked/corrected.

### Checkout

- [ ] Make sure to use the coupon for free PCBA setup.

## Ordering separate parts from Mouser/Digikey

Take a risk-adverse approach since ordering individual parts is expensive with shipping fees.

- [ ] Create variant for parts used in JLC and parts which need to be ordered separately. **Double check the BOM and order extras** of critical components.
