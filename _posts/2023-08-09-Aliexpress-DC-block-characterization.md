---
title: Aliexpress DC block characterization
author: Peter Tanner
date: 2023-08-09 19:41:27 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [rf, microwave, electronics] # systems | embedded | rf | microwave | electronics | solidworks | automation
---

I recently purchased [this DC block](https://www.aliexpress.com/item/1005002575850555.html) from Aliexpress to protect our HP 8560A spectrum analyzer. I did some basic tests on the DC block and it looks alright.

![DC block](/assets/img/2023-08-09-Aliexpress-DC-block/IMG20230809195538.jpg)

Firstly, I did a continuity check with a multimeter and it does not conduct DC, and it has a capacitance of about 2.2 nF.

![Broadband performance](/assets/img/2023-08-09-Aliexpress-DC-block/IMG20230809200336.jpg)

The DC block performs well over the 1 MHz to 2.9 GHz frequency range. At 2.45 GHz and 915 MHz there is an insertion loss of -0.2 dB. The response is "linear enough" for my tests. There is of course some non-linearity but it seems the loss in this frequency range varies, up to a maximum of -0.5 dB. The HP 8560A has a maximum frequency of 2.9 GHz, so I was not able to test it's performance up to the stated 6 GHz maximum frequency, quoted on the DC block's specifications.

![Performance near 0 Hz](/assets/img/2023-08-09-Aliexpress-DC-block/IMG20230809200758.jpg)

The -3 dB cutoff point is at ~850 kHz. The figure shows the performance from 300 kHz to 2 MHz (Note that the minimum frequency of the HP 8560A tracking generator is 300 kHz). So if you are using this block above 1 MHz, you should be fine.
