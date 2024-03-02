---
title: Debugging steps for CDC USB on STM32 and Platformio
author: peter
date: 2024-03-02 21:58:54 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, STM32, platformio] # systems | embedded | rf | microwave | electronics | solidworks | automation
# image: assets/img/2024-03-02-Debugging-steps-for-/preview.png
---

Progress to the next step if it still isn't working

## Step 1: Have you put the required defines in your build flags?

The build flags enable the USB CDC functionality. Make sure to also set the CPU frequency, on my board I've used a 16 MHz crystal.

```ini
[env:genericSTM32F103C8]
platform = ststm32
board = genericSTM32F103C8
framework = arduino
upload_protocol = stlink
debug_tool = stlink
board_build.f_cpu = 16000000L   ; This should match your crystal oscillator frequency (On my board I've used a 16 MHz crystal)
monitor_dtr = 1

build_flags =
   -D PIO_FRAMEWORK_ARDUINO_ENABLE_CDC
   -D USBCON
```

## Step 2: Does your MCU require a 1.5kR pullup resistor?

Consult ST application note [AN4879](https://www.st.com/resource/en/application_note/dm00296349-usb-hardware-and-pcb-guidelines-using-stm32-mcus-stmicroelectronics.pdf), Table 3. Find your MCU series and check the "Embedded pull-up resistor on USB_DP line" column. In my case, unfortunately, I forgot to put the 1.5kR pullup resistor and I am using an STM32F103, which has a `-` in that column. The note (2) states:

> To be compliant with the USB 2.0 full-speed electrical specification, the USB_DP (D+) pin must be pulled up to a voltage in the 3.0 to 3.6 V range with a 1.5 kΩ resistor.

Try putting a resistor on `USB_DP`, then reset and re-connect the MCU to your host device. It should work with any low-value resistor, in my case I used a 10kR through hole resistor since I was not at my lab. This worked and I received characters as long as the resistor was held there.

## Step 3: ???

I've solved my issue with my custom board, but if you took more debugging steps feel free to leave your solutions in the comments below and I'll add them here.
