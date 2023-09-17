---
title: Gamma spectrometer project brief
author: peter
date: 2023-09-08 05:26:55 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, radiation, embedded, physics] # systems | embedded | rf | microwave | electronics | solidworks | automation
---

This is a project proposal/brief for UWA Aerospace.

🚧 UNDER CONSTRUCTION 🚧\
🚧 UNDER CONSTRUCTION 🚧\
🚧 UNDER CONSTRUCTION 🚧\
🚧 UNDER CONSTRUCTION 🚧

## Project introduction

### Definitions

- Analog digital converter (ADC)
- Microcontroller unit (MCU)
- International atomic energy agency (IAEA)
- Silicon photomultiplier (SiPM)
- Radio frequency (RF)

### Gamma ray spectrometer

A gamma spectrometer produces a spectrum containing the counts per second of the different wavelengths of gamma rays detected by the spectrometer. A scintillation detector is a common form of gamma spectrometer.

### Scintillation detector

A scintillation detector contains a block of scintillating material and a photomultiplier sealed in an opaque case. When a gamma ray interacts with the scintillating material, several photons are emitted. The photomultiplier can amplify several photons into a detectable signal (several mV). The signal can amplified by an operational amplifier to a usable voltage (several V), which can be digitized by an ADC, and digital signal processing can be done on this digitized signal with a MCU.

⚠ It is important that the photomultiplier is not exposed to direct light, as it is intended to amplify a small amount of photons. Exposing it to large amount of photons will permanently damage the photomultiplier.

There are several types of scintillators:

| Type    | Advantage | Disadvantage                                 |
| ------- | --------- | -------------------------------------------- |
| Plastic |
| CsI(Tl) |           | Must be kept free of moisture, water soluble |
| LYSO    |

### Applications of gamma ray spectroscopy

This [IAEA report](https://inis.iaea.org/collection/NCLCollectionStore/_Public/22/072/22072114.pdf) describes applications of gamma ray spectroscopy and expands further on the theory. Applications include geological mapping of radioactive minerals and of other minerals such as gold, molybdenum and tin, radon detection and mapping of radioactive fallout. Airborne gamma ray spectroscopy allows for surveys of large amounts of land, at the tradeoff of ground-level sensitivity due to decrease in amplitude with altitude.

## Conditions for success

- There is a difference in radon concentration between the Perth metropolitan area (10 Bq/m³), and Northam/Grass Valley area (20 Bq/m³).
- Radioactive materials can be used for validation. Check the spectra.

## Budget estimate

| Item                                     | Example (Link)                                                                                                                                                                                                         | Rough Budget                         |
| ---------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------ |
| Silicon photomultiplier (SiPM)           | https://au.mouser.com/c/?marcom=110616262&sort=pricing                                                                                                                                                                 | [$50,$100]                           |
| Scintillator crystal                     | LYSO crystal https://www.ebay.com.au/itm/251986066149 (Do your own research on which crystal is the best and cheapest to use here.)                                                                                    | [$70,$120]                           |
| Complementary components                 | SiPM power supply DC-DC converter, MCU, SiPM frontend, PCB, 3d printed casing materials                                                                                                                                | ~$50                                 |
| Radioactive gamma-emitting test material | Granite benchtops, uranium glass, anything which emits negligible but detectable amounts of gamma radiation. Ask physics department if they can calibrate once pre-testing is done with some low radioactive materials | idk just find granite benchtop chips |

## Design requirements

- RF output for direct connection from SiPM frontend to spectrum analyzer
- MCU for saving data onto the board (consider SD card)
- SiPM and crystal assembly should ideally be waterproof and shock resistant since it's the most expensive part, and reusable.
- USB serial connection so we can use a computer to do live analysis
- Mounting holes
- Allow for swapping of SiPM/scintillator crystal assembly (Use good locking connector)
- Allow for power input port (5V)
- Protect the SiPM! Make the power supply for the SiPM have all the necessary precautions (fuses, reverse polarity protection, ESD protection, etc.).

Nice to haves

- OLED display attachment?
