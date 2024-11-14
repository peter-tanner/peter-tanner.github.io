---
title: "Dev log: GPS receiver based on MAX2769 and Zynq 7010 FPGA"
author: peter
date: 2024-10-02 20:10:44 +0800
categories: [Electronics, Programming] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [rf, electronics, fpga, ebaz4205, max2769, zynq7010, gps, devlog] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-10-02-Dev-log-GPS-receiver/preview.png
---

## 🚧🚧 THIS PAGE IS NOT FINISHED 🚧🚧

## Updates

### 2024-11-15: First PCB design

The openGNSS PCB is done! The tab extending down on the left side of the board is to provide a mounting point for the board to mount to the ebaz4205 board if the top mounting points cannot be used, since IREC regulations do not allow use of connectors as mechanical mounting.

![Top PCB](/assets/img/2024-10-02-Dev-log-GPS-receiver/top.png)

![bottom PCB](/assets/img/2024-10-02-Dev-log-GPS-receiver/bottom.png)

## Notes

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

## I and Q

This answer says we need both I and Q for acquisition

https://dsp.stackexchange.com/questions/92028/max2769-i-q-for-signal-acquisition-tracking

But the GPS document says

> The two L1 carrier components modulated by the two separate bit trains (C/A-code plus data and P(Y)-code
> plus data) shall be in phase quadrature (within ±100 milliradians) with the C/A signal carrier lagging the P
> signal by 90 degrees

Another confusing thing is the GPS doc says In phase is P(Y) xor D(t) while Quadrature is C/A xor D(t), but the MAX2769 seems to operate where I is the C/A code since that's the only component the STM32 based GPS receiver uses. However, the diagram in the MAX2769 seems to have Q be +90deg phase shift ahead of I, whereas in the GPS document C/A lags by 90deg behind P(y) so I in GPS doc is +90deg phase shift ahead of Q in gps doc, so i guess the receiver and the doc have opposite conventions?

## Signal generation

Use MATLAB

https://au.mathworks.com/help/satcom/ug/gps-waveform-generation.html#mw_rtc_GPSWaveformGenerationExample_52AA1397

Looks like this generates a GPS baseband waveform OR it can generate the bits.

https://gge.ext.unb.ca/Resources/gpsworld.april93.pdf Observables (carrier phase, pseudorange)

https://descanso.jpl.nasa.gov/monograph/series2/Descanso2_S13.pdf Observables

## ZYNQ platform

https://www.xilinx.com/support/answers/65240.html  https://old.reddit.com/r/FPGA/comments/e5e8ia/be_aware_of_zynq_7020_arm_core_1_bricking_due_to/  Seems important for devboard