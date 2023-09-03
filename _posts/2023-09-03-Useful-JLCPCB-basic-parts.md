---
title: Useful JLCPCB basic parts
author: peter
date: 2023-09-03 17:51:43 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, PCB design] # systems | embedded | rf | microwave | electronics | solidworks | automation
---

Here's a list of useful parts I've found on JLCPCB which are in their "basic" category for their PCB assembly service. These parts are definitely worth using in future designs since they are generally cheaper than buying them individually on DigiKey or Mouser, and they get assembled for no extended parts fee (1 USD).

I will update this with more detail as I find more useful parts or as I use the parts.

I found these using [JLC Parts](https://yaqwsx.github.io/jlcparts/#/) since the [official JLCPCB parts](https://jlcpcb.com/parts) website's parametric search isn't the greatest to say the least.

# Recommended ✅

## Capacitors, resistors, LEDs

You can find basics for most common SMD capacitors and resistors, including power supply decoupling and some which are used for matching networks. They also have some 0603 or 0805 LEDs for common colors. These are priced at bulk prices unlike buying them separately. Designing around placing these components is a no-brainer, as it saves the most manual soldering time.

## Inductors and ferrites

There is a limited selection of inductors and ferrites. I did not design around these since when designing a matching network you tend to use "weird" values which are not in the basics list. If you can substitute it though, definitely worth using the JLC ones.

## Microcontrollers

Almost always it is worth using JLCPCB instead of Digikey or Mouser for microcontrollers, even when using extended parts! The STM32F103 is a good deal. The STM32L151 is not that great for the price here, I would avoid it.

| Part number       | Description                                                                                               | Mfg                | Price          |
| ----------------- | --------------------------------------------------------------------------------------------------------- | ------------------ | -------------- |
| STM32L151C8T6     | 64KB 1.8V~3.6V ARM Cortex-M3 10KB 32MHz FLASH 37 LQFP-48(7x7) Microcontroller Units (MCUs/MPUs/SOCs) ROHS | STMicroelectronics | 2.528$/1 units |
| ATMEGA328P-AU     | 32KB 2KB FLASH 23 1.8V~5.5V AVR 20MHz TQFP-32(7x7) Microcontroller Units (MCUs/MPUs/SOCs) ROHS            | Microchip Tech     | 2.152$/1 units |
| **STM32F103C8T6** | 64KB 2V~3.6V ARM Cortex-M3 20KB 72MHz FLASH 37 LQFP-48(7x7) Microcontroller Units (MCUs/MPUs/SOCs) ROHS   | STMicroelectronics | 1.351$/1 units |
| STM8S105K6T6C     | 32KB 2.95V~5.5V STM8 2KB 16MHz FLASH 25 LQFP-32(7x7) Microcontroller Units (MCUs/MPUs/SOCs) ROHS          | STMicroelectronics | 0.996$/1 units |
| STM32F030C8T6     | 64KB 2.4V~3.6V ARM Cortex-M0 8KB 48MHz FLASH 39 LQFP-48(7x7) Microcontroller Units (MCUs/MPUs/SOCs) ROHS  | STMicroelectronics | 0.739$/1 units |
| STM8S003F3P6TR    | 8KB 1KB FLASH 16 2.95V~5.5V STM8 16MHz TSSOP-20 Microcontroller Units (MCUs/MPUs/SOCs) ROHS               | STMicroelectronics | 0.482$/1 units |

## Power

## Linear regulators

There are many linear regulators which are worth using. Some of them are quite outdated though (LM317)

## DC-DC converters

There are some buck, boost, and buck OR boost converters which are nice. However, there is no buck-boost converter on there.

## Battery management

There are some charging ICs for single-cell lithium ion batteries (TP4054, TP4056). Unfortunately there are no protection circuits but you should be able to implement one using operational amplifiers (also in basic parts) and a power MOSFET (not in basic parts unfortunately).

## Memory and storage

### W25Q128JVSIQ NOR flash (0.558$/1 units)

128 MBit SPI flash memory in a SOP-8 package. Drivers for the W25Q series are widely available.
![](https://assets.lcsc.com/images/lcsc/96x96/20180914_Winbond-Elec-W25Q128JVSIQ_C97521_front_10.jpg)

### I2C EEPROMs

| Part number      | Description                   | Mfg                | Price          |
| ---------------- | ----------------------------- | ------------------ | -------------- |
| M24C02-WMN6TP    | 2Kbit I2C SOP-8 EEPROM ROHS   | STMicroelectronics | 0.079$/1 units |
| M24C64-RMN6TP    | 64Kbit I2C SOP-8 EEPROM ROHS  | STMicroelectronics | 0.12$/1 units  |
| AT24C256C-SSHL-T | 256Kbit I2C SOP-8 EEPROM ROHS | Microchip Tech     | 0.358$/1 units |

## Transceivers

### SN65HVD230DR CAN bus transceiver (0.742$/1 units)

    1Mbps Transceiver SOIC-8 CAN ICs ROHS

Very cheap price. It is $2.55 USD on Mouser.

### RS232/RS422

I have not used these yet but I plan to use some RS232 transceivers in a future project (communication for my old Hitachi VC 6025 oscilloscope). I will update this if I finish that.

## Sensors

The only sensor in the basics parts category is the MPU-6050

### MPU-6050 (4.066$/1 units)

I don't recommend using the MPU-6050 since it is a very outdated accelerometer. Because it is old, however, it is very well supported and there are many libraries and code examples out there.

## ESD

### SRV05-4-P-T7 USB ESD protection (0.188$/1 units)

Very cheap ESD protection for your USB interface. Maximum VDD is 5V though, so you can't use it for higher voltages.

![](https://assets.lcsc.com/images/lcsc/96x96/20180914_ProTek-Devices-SRV05-4-P-T7_C85364_front_10.jpg)

### All TVS diodes:

| Part number     | Description                             | Mfg                      | Price          |
| --------------- | --------------------------------------- | ------------------------ | -------------- |
| SMF6.0CA        | 10.3V 6.67V 6V SOD-123FL TVS ROHS       | Liown                    | 0.028$/1 units |
| SMF30CA         | 48.4V 33.3V 30V SOD-123FL TVS ROHS      | Liown                    | 0.029$/1 units |
| SMAJ5.0A        | 9.2V 6.4V 5V SMA(DO-214AC) TVS ROHS     | Liown                    | 0.035$/1 units |
| P6SMAJ33CA      | 53.3V 36.7V 33V SMA TVS ROHS            | Liown                    | 0.039$/1 units |
| SMBJ6.0CA       | 10.3V 6.67V 6V SMB(DO-214AA) TVS ROHS   | Liown                    | 0.04$/1 units  |
| SMBJ30CA        | 48.4V 33.3V 30V SMB(DO-214AA) TVS ROHS  | Liown                    | 0.041$/1 units |
| P6SMB6.8CA/TR13 | 10.5V 6.45V 5.8V SMB(DO-214AA) TVS ROHS | Brightking Elec (TAIWAN) | 0.046$/1 units |
| SMCJ6.5CA       | 11.2V 7.22V 6.5V SMC(DO-214AB) TVS ROHS | Liown                    | 0.109$/1 units |
| SRV05-4-P-T7    | 12V 6V 5V SOT-23-6 TVS ROHS             | ProTek Devices           | 0.188$/1 units |
| PSM712-LF-T7    | 19V 13.3V 12V SOT-23(TO-236) TVS ROHS   | ProTek Devices           | 0.289$/1 units |
| 5.0SMDJ64CA     | 103V 71.1V 64V SMC(DO-214AB) TVS ROHS   | Liown                    | 0.332$/1 units |
| 5.0SMDJ75CA     | 121V 83.3V 75V SMC(DO-214AB) TVS ROHS   | Liown                    | 0.332$/1 units |

## Crystals

There are quite a few crystals for different frequencies
There is a 32.768 kHz crystal for a RTC and many more as HSE crystals

| Part number       | Description                                      | Mfg           | Price          |
| ----------------- | ------------------------------------------------ | ------------- | -------------- |
| Q13FC1350000400   | 32.768kHz 12.5pF ±20ppm SMD3215-2P Crystals ROHS | Seiko Epson   | 0.181$/1 units |
| X50328MSB2GI      | 8MHz 20pF ±10ppm SMD5032-2P Crystals ROHS        | Yangxing Tech | 0.154$/1 units |
| X49SM8MSD2SC      | 8MHz 20pF ±20ppm HC-49S-SMD Crystals ROHS        | Yangxing Tech | 0.073$/1 units |
| X5032110592MSB2GI | 11.0592MHz 20pF ±10ppm SMD5032-2P Crystals ROHS  | Yangxing Tech | 0.188$/1 units |
| X322512MSB4SI     | 12MHz 20pF ±10ppm SMD3225-4P Crystals ROHS       | Yangxing Tech | 0.052$/1 units |
| X322516MLB4SI     | 16MHz 9pF ±10ppm SMD3225-4P Crystals ROHS        | Yangxing Tech | 0.056$/1 units |
| X322525MOB4SI     | 25MHz 12pF ±10ppm SMD3225-4P Crystals ROHS       | Yangxing Tech | 0.058$/1 units |

## Other I have not mentioned

There are bridge rectifiers, optoisolators, magnetic isolators, operational amplifiers, darlington arrays, buffers, some logic ICs, analog switches, power diodes and small-signal MOSFETs available

# Not sure if these are useful ⚠

### FEMDRM008G-58A39 (3.079$/1 units)

7.28 GB eMMC in a 153 BGA package. Not sure if this is usable given the via minimum spacing of JLCPCB standard, or if this needs pad-in-via technology (which would raise the cost). If you can make this work with standard PCB, it would save a lot of cost.

![](https://assets.lcsc.com/images/lcsc/96x96/20230202_FORESEE-FEMDRM008G-58A39_C719499_back.jpg)

# Not recommended ❌

### CP2102-GMR (1.901$/1 units)

I don't have first-hand experience using this chip, but my mate used it in a design and he said it just used so much power. This chip is also expensive compared to other options such as the CH340-E, which are only ~$0.4. Not much of a money-save this one.

# Wishlist for more basic parts

## Smaller button

Currently the only button in the basic parts is the TS-1187A-B-A-B. It has a HUGE footprint

![](https://assets.lcsc.com/images/lcsc/96x96/20181028_XKB-Connectivity-TS-1187A-B-A-B_C318884_front.jpg)

I would like something smaller like these [oval shaped buttons](https://www.lcsc.com/product-detail/Tactile-Switches_XUNPU-TS-1089S-02526_C455282.html):

![](https://assets.lcsc.com/images/lcsc/96x96/20230118_XUNPU-TS-1089S-02526_C455282_front.jpg)

## Buck-boost converter

The only power converters in the basic list are buck converters, boost converters, or buck OR boost converter (controllers which can be configured as buck or boost depending on the components but cannot do both at the same time).
