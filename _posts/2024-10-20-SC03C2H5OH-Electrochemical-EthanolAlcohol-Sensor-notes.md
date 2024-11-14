---
title: SC03-C2H5OH Electrochemical Ethanol/Alcohol Sensor notes
author: peter
date: 2024-10-20 15:05:45 +0800
categories: [Electronics]    # 0-2 categories. Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [electrochemical,sensor,electronics,beers,alcohol]   # 0-\infty. systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-10-20-SC03C2H5OH-Electroch/preview.png
---

Most alcohol sensor modules use the MQ3 alcohol sensor (or similar), which operate using a metal oxide semiconductor which changes in resistivity when alcohol is exposed to it. These tend to be terrible. The SC03-C2H5OH is the cheapest electrochemical alcohol sensor I could find online, it uses an electrochemical cell which should be better.

I was able to purchase it in quantities of one on [Aliexpress](item/1005005789802562.html) for around $20 AUD. The package arrived with the sensor and a male-male ribbon cable to connect it to a 2.0 mm picoblade connector (see below for specifications).

## Better datasheet

If you email the company listed on the Aliexpress page you will get a datasheet, but it is quite unreadable. It appears this datasheet has been copy and pasted from other similar gas sensors since the commands used to communicate are the same. The datasheet is missing some commands present on other gas sensors (like putting the sensor into polling mode).

### Product Description

SC03-C2H5OH electrochemical ethanol module is a general-purpose, miniaturized
module. Using the electrochemical principle to detect C2H5OH existing in the air
has good selectivity and stability. SC03-C2H5OH is a general- purpose gas module
designed and manufactured by combining mature electrochemical detection
technology with sophisticated circuit design. It has digital output and analog
voltage output, and is suitable for various application circuit schemes.

### Module Features

- High sensitivity, high resolution, low power consumption, long service life
- Provide UART data output mode
- High stability, excellent anti-interference ability, temperature compensation, excellent linear output

### Main Application

Alcohol detectors, etc.

### Specifications

| Parameter               | Value                                          |
| ----------------------- | ---------------------------------------------- |
| Product Model           | SC03-C2H5OH                                    |
| Detection gas           | Ethanol (alcohol)                              |
| Interfering gases       | Carbon monoxide and other gases                |
| Output data             | UART output (3V TTL level)                     |
| Working voltage         | 3.7 V - 5.5 V                                  |
| Warm-up time            | ≤ 5 seconds                                    |
| Response time           | ≤ 5 seconds                                    |
| Recovery time           | ≤ 10 seconds                                   |
| Range                   | 0 - 500 mg/100mL (blood alcohol concentration) |
| Resolution              | ≤ 0.1 mg/100mL (blood alcohol concentration)   |
| Recovery time（T10）    | < 5s                                           |
| Working temperature     | -20℃ - 50℃                                     |
| Working humidity        | 15% RH - 90% RH (non-condensing)               |
| Storage temperature     | 0 - 25℃                                        |
| Service life            | 5 years (0℃ - 35℃ in air)                      |
| Module size (L x W x H) | 18.2 mm x 15.2 mm x 6.5 mm                     |

### Module dimensions

TODO:

### Pin description

![pinout](/assets/img/2024-10-20-SC03C2H5OH-Electroch/pinout_top.png)

Header ("Micro JST" (Molex Picoblade) 7 pin, 1.25 mm pitch. [🔗 Example listing](https://www.aliexpress.com/item/1005004032675657.html)):

| Pin | Function | Direction | Maximum rating |
| --- | -------- | --------- | -------------- |
| 1   | NC       |           |                |
| 2   | NC       |           |                |
| 3   | GND      | I         |                |
| 4   | VIN      | I         | 3.7 V - 5.5 V  |
| 5   | UART_RXD | I         | 0 - 3.3 V      |
| 6   | UART_TXD | O         | 0 - 3.3 V      |
| 7   | NC       |           |                |

### Protocol

#### UART settings

| Baud rate | Data bits | Stop bit | Parity bit |
| --------- | --------- | -------- | ---------- |
| 9600 baud | 8         | 1        | None       |

#### Checksum calculation

```c
unsigned char get_checksum(unsigned char array[], unsigned char array_size)
{
    unsigned char checksum = 0;
    for (unsigned char i = 1; i < array_size - 2; i++)
        checksum += array[i];
    checksum = (~checksum) + 1;
    return checksum;
}
```

### Important notes

1. Electrolyte leakage may cause damage; do not disassemble the sensor.
2. Avoid exposing the sensor to organic solvents (including silicone rubber, adhesives), coatings, pharmaceuticals, oils, or high-concentration gases.
3. Electrochemical sensors should not be fully encapsulated in resin or placed in oxygen-free environments, as this will damage the sensor and affect its performance.
4. Do not use electrochemical sensors in environments with corrosive gases for extended periods, as these gases can damage the sensors.
5. Gas zero-point measurements must be conducted in a clean atmosphere.
6. When testing or using the sensor, avoid direct vertical air intake from the front.
7. Do not block or contaminate the air inlet surface of the sensor.
8. Do not open or damage the waterproof and breathable membrane on the sensor.
9. The sensor must not be subjected to excessive shock or vibration.
10. Do not use the sensor if the casing is damaged or deformed.
11. After prolonged exposure to high-concentration gases, the sensor will recover slowly to its original state.
12. During storage, the anode and cathode should remain short-circuited.
13. Do not encapsulate the sensor using hot melt adhesive or sealant that cures at temperatures above 80 °C.
14. Avoid storing or using the sensor in high-concentration alkaline gas for extended periods.

## Reverse engineering

This configuration appears to be copy-pasted between a lot of these gas sensors on Alibaba/Aliexpress. The commands/output data format are also the same between most of these sensors. The PCB layouts are also very similar, but sometimes differ for some reason. For example, the picoblade connector is sometimes omitted, and others use 2.54 mm headers instead of the 2.00 mm headers on this sensor.

### Linear regulator

MICRONE(Nanjing Micro One Elec) type regulator, marking on the top of the regulator `S2UD`

Similar to [this one.](https://www.lcsc.com/product-detail/Voltage-Regulators-Linear-Low-Drop-Out-LDO-Regulators_MICRONE-Nanjing-Micro-One-Elec-ME6211C33M5G-N_C82942.html)

### Microcontroller

`CX32L003F8` (STM32 clone)

Used to digitize signal and format it for UART.

It may be programmed over SWD interface through the 2.00 mm headers.

### Operational ampplifier

`GS8552`

???

### Headers

2.00 mm headers

Header ("Micro JST" (Molex Picoblade) 7 pin, 1.25 mm pitch. [🔗 Example listing](https://www.aliexpress.com/item/1005004032675657.html)):
