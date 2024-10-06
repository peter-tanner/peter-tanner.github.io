---
title: Dev log: GPS receiver based on MAX2769 and Zynq 7010 FPGA
author: peter
date: 2024-10-02 20:10:44 +0800
categories: [Electronics, Programming]    # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [rf, electronics, fpga, ebaz4205, max2769, zynq7010]   # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-10-02-Dev-log-GPS-receiver/preview.png
---

## 🚧🚧 THIS PAGE IS NOT FINISHED 🚧🚧

## Notes:

https://github.com/iliasam/STM32F4_SDR_GPS?tab=readme-ov-file

https://habr.com/ru/articles/789382/

https://dsp.stackexchange.com/questions/92028/max2769-i-q-for-signal-acquisition-tracking

## Datasheet

> The MAX2769B features an on-chip ADC to digitize the
> downconverted GPS signal. The maximum sampling
> rate of the ADC is approximately 50Msps. The sampled
> output is provided in a **2-bit format (1-bit magnitude and
> 1-bit sign) by default** and also can be configured as a
> **1-bit or 2-bit** in both I and Q channels, or 1-bit, 2-bit, or
> 3-bit in the I channel only. The ADC supports the digital
> outputs in three different formats: the unsigned binary,
> the sign and magnitude, or the two’s complement format
> by setting bits FORMAT in Configuration register 2. MSB
> bits are output at I1 or Q1 pins and LSB bits are output at
> I0 or Q0 pins, for I or Q channel, respectively. In the case
> of 3-bit, output data format is selected in the I channel
> only, the MSB is output at I1, the second bit is at I0, and
> the LSB is at Q1.

Surely two-bit correlation is the same process, just with more precision because of the additional bit?
