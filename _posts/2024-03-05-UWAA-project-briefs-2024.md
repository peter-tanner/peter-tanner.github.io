---
title: UWAA project briefs 2024
author: peter
date: 2024-03-05 10:40:20 +0800
categories: [UWAA] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, projects] # systems | embedded | rf | microwave | electronics | solidworks | automation
# image: assets/img/2024-03-05-UWAA-project-briefs-/preview.png
toc: true
---

Updating this as I add new projects this year.

## Telemetrum ground station

The Telemetrum's Teledongle ground station is out of stock everywhere. We should make our own.

### Success criteria

- Receive signals from the [Telemetrum](https://altusmetrum.org/TeleMetrum/) flight computer over a distance of at least 10 kft.
- Send data to a computer over USB virtual COM port in a format which can be interpreted in real time by the [AltosUI flight monitoring software](https://altusmetrum.org/AltOS/).

### Scope

- Make a PCB which contains a cheap microcontroller with USB support and the CC12xx or [CC11xx](https://jlcpcb.com/parts/componentSearch?searchTxt=CC1120) radio transceiver.
  - Compare what options are in stock on JLCPCB, I think both families should be compatible with each other but double check.
  - Make sure the PCB has mounting holes so it can fit into a case.
  - Use an SMA connector.
- Create software to copy the data from the receiver to the computer over USB through an intermediate MCU.
- CHALLENGE: Use an ESP32 or some BLE enabled MCU so that we don't need USB cables to connect to this station, or maybe a phone application.
- CHALLENGE: Incorporate a planar inverted-F antenna (PIFA), meandering antenna on the PCB for Wi-Fi or BLE.
- CHALLENGE: Incorporate a single-cell 3.7V lithium polymer battery to allow it to operate without USB connection or powerbanks. Use the TP4057 or similar battery charger, which can be found on JLCPCB under their basic parts category.
- CHALLENGE: Design a 3d printed or laser cut case (or just ask someone in mech to make it)

### Hints and notes

- You must read this [protocol specification](https://altusmetrum.org/AltOS/doc/telemetry.html) for the AltusMetrum devices. Luckily, the Teledongle does minimal processing of the raw data, it only encodes it into an ASCII format before transmitting it over serial.
- You should look at the schematics and PCB layout for the Teledongle for inspiration https://altusmetrum.org/TeleDongle/.
  - I advise you don't use the NXP LPC11U14 since a cheaper microcontroller can do well
- [!] PRO TIP: Use JLCPCB's part library to save on money! It tends to be cheaper per unit than buying from distributors online since JLC buys the parts at wholesale prices.
  - Looks like the ESP32-C3 is very reasonably priced, see the list of [ESP32s here](https://jlcpcb.com/parts/componentSearch?searchTxt=esp32)
  - You should consider using the [basic parts library](https://jlcpcb.com/parts/basic_parts) to place passives (resistors, capacitors). On Altium, all components in this library will have a `JLC_PN` attribute.
  - Using extended parts outside the basic library list will incur a $3 USD fee per unique part, but when assembling 5 boards this still beats distributor prices. Of course, if a part is in the basic library it should be used if possible
  - You may decide to use this alternative site to look up parts since JLC's parametric search isn't great https://yaqwsx.github.io/jlcparts/
  - Try to place all/as many components on one side of the board only so you can use economic PCBA, which only places parts on one side.
  - Feel free to ask me for Altium training, and I will probably need to talk about RF design considerations

### Future development

- Make this a module card which can go into a standalone battery powered ground station which does not need a laptop to use. This can be helpful if our laptops run out of energy and there are no generators.
  - Or just make it BLE enabled and use phones which should have good enough battery life anyways.

## WiFi-based video transmitter

SAC now has a some award for the best live video downlink from a rocket. I think the best way in terms of quality would be to use WiFi equipment and transmit the video down using some directional antenna. This is a very ambitious project.

### Success criteria

- Milestone 1: Receive data at a rate of 4000 kbit/s over a distance of 10kft, LOS.
- Milestone 2: ???

### Scope

- Video transmitter on the rocket and receiver on the ground

### Hints and notes

- You should check this project out [wifibroadcast](https://befinitiv.wordpress.com/wifibroadcast-analog-like-transmission-of-live-video-data/)... looks exactly what we need, it's designed for FPV drone applications.
- Make a comparison of cost vs data rate?
- This project is very ambitious and we will probably have to keep this text updated
- Laptops have PCIe NIC cards, check if an SDIO-based NIC is available which can be used on a raspberry pi
- An option is to use a COTS laptop and temporarily bring out the coax to a big antenna?

## E22-900T30S development board

> _E22-900T30S is a wireless serial port module (UART) based on SEMTECH's SX1262 RF chip. It has multiple transmission modes, LoRa spread spectrum technology, TTL level output, compatible with 3.3V and 5V IO port voltage_

We have some of these E22-900T30S modules laying around, they would make for great long range telemetry modules since they have a power amplifier.

### Goals

- Create a dev board which exposes all the useful pins on the E22-900T30S.
- Use an SMA connector to expose the RF port
- Put in a pi network on the RF output for impedance matching
- 2.54 mm headers
- If you can make this board under 5cm\*5cm, you may opt to use JLC's 6-layer process (even if you aren't using all 6 layers, the free ENIG is a nice touch)
- Extra goal: integrate a USB-UART TTL interface and USB-C port so you can directly plug the dev board into a computer without needing an external USB-UART adapter.

### Hints and notes

- The Altium already has the module created in the components library with a 3d model, all you need to do is place the headers and other supporting parts
- Datasheet for this module is [here](https://www.ebyte.com/en/downpdf.aspx?id=485)

## HPIB/GPIB to USB adapter for HP8560A

We have an [old spectrum analyzer](https://www.petertanner.dev/posts/HP-8560A-spectrum-analyzer-as-a-frequency-generator/) which outputs data over [IEEE-488, or GPIB/HPIB](https://en.wikipedia.org/wiki/GPIB?&useskin=vector). We'd like to connect the spectrum analyzer to a laptop over USB.

### Success criteria

- Create one plot on your PC connected to the spectrum analyzer over your GPIB adapter, use [this software](https://www.qsl.net/ke5fx/gpib/7470.htm) to receive the plot.

### Hints and notes

- GPIB uses 5V so you may need to [level shift](https://en.wikipedia.org/wiki/Level_shifter?&useskin=vector) depending on the maximum GPIO voltage of your chosen microcontroller
- You may choose to pick a microcontroller with USB transceiver built in, or a microcontroller combined with a UART-USB bridge IC.
- You are meant to use these [bus transceivers](https://www.ti.com/product/SN75160B), but some designs have gotten away with not using them for single-device applications. It is up to you whether you want your adapter to be compatible with GPIB and accept multiple devices, or only for adapting one device to one usb.
- Search up "GPIB to USB" for other existing designs floating around on GitHub.
- You'll probably need to watch a video on choosing components. I have recorded slides that I've presented last semester, but any video online will do.

### Milestones

1. Choose your parts (microcontroller mainly, and other major parts such as interface ICs or level translators)
1. Create a schematic (Once you get to this stage let me know so I can give you Altium training)
1. Create a PCB (Once you get to this stage let me know so I can give you Altium training)
1. Request design review and get the PCB made
1. Program the PCB (Should be simple since it's just adapting protocols, since this project is more about the PCB side than programming you can rip off some GPIB library code)

## Flight Computer programming

While the hardware will be different, the concept of a flight computer doesn't really change. I will set you up with some breakout boards and you will program a flight computer on an STM32 microcontroller.

### Success criteria

- Program a flight computer which can:
  - Set off a pyrotechnic charge using a basic relay when apogee and a set alittude is released
  - Log information from all sensors to an SD card
- Extension: Maintain a radio downlink

### Hints and notes

- The standard IDE is STM32CubeIDE, but if you hate Eclipse-based IDEs like me you can use the "Embedded tools" VSCode extension
  - To use this extension you should install STM32CubeMX, STM32CubeCLT and STM32CubeProgrammer.
- Use STM32CubeMX for configuring the GPIO pins/Alternate functions
- You can also use STM32CubeMX to include a real time operating system (RTOS), which will make your life easier since it allows you to have threads which can allow for some "concurrency" (actually multitasking).
- You may use C or C++, although I don't find many C++ features useful in this context.
- Look up libraries for your sensor part number to rip off. ST provides "platform independent drivers (PIDs)" which may be useful (you just need to implement the read/write function stubs by populating it with the appropriate code to call HAL functions)
- Please don't hesitate to ask me questions, programming microcontrollers are quite fiddly.

## Squib driver demo board

Squib drivers are used in automotive applications to safely deploy airbags, which use e-matches just like in our avionics. The current avionics uses a current-sense amplifier and analog-to-digital converter. When an ADC interrupt is triggered, the microcontroller switches off the channel momentarily. This system is quite convoluted and failure prone, and having an automotive-certified part would remove this risk even if 10x more expensive.

### Success criteria

- Create a board of "any" size (it can be larger than normal, up to `100 mm * 100 mm`) which can accomodate an automotive squib driver. Ensure you use terminal blocks or some high-current connector for the pins that connect the driver to the squib/e-match.
- Make sure every other pin is accessible through a pin header
- Follow the application note/eval board design if one exists
- Look up parts on mouser or digikey, search squib driver
- Also see if any of these parts are available on JLCPCB directly for cheaper
- Put LEDs and stuff on the board to indicate visually!
- Some parameters to consider are the cost, how many channels are available per IC, the minimum voltage and firing current for example?

### Milestones

1. Choose your parts (Make a comparison table based on the parameters I suggested?)
1. Create a schematic (Once you get to this stage let me know so I can give you Altium training)
1. Create a PCB (Once you get to this stage let me know so I can give you Altium training)
1. Request design review and get the PCB made

## ESP32 development board

We typically use STM32 microcontrollers for flight computers, but ESP32 may be a good alternative since it has support for WiFi and BLE, which may simplify interfacing with the flight computer. One example of this is the Blue Raven flight computer, which has a mobile phone application.

### Success criteria

- Make an ESP32 dev board with basics such as voltage regulator, USB connection. Also include a WiFi antenna on the board (either integrated into the PCB or using a pre-made sheet metal stamp antenna, ask me when you get to this stage)
- Make sure it has headers spaced correctly so we can use it on a standard breadboard
- Look at arduinos for design ideas.

### Hints/notes

- I'm not too sure what the ESP32 ecosystem is like, I think it would be good to start off by doing a comparison of each of the parts (flash, ram, peripherals, pin count, cost...) and then we can decide which part to use.
- Ask me when you get to the antenna design stage which is in the PCB design phase (after schematics)

### Milestones

1. Choose your parts (Make a comparison table based on the parameters I suggested?)
1. Create a schematic (Once you get to this stage let me know so I can give you Altium training)
1. Create a PCB (Once you get to this stage let me know so I can give you Altium training)
1. Request design review and get the PCB made

<!--
## Analog video transmitter

### Success criteria

- Receive at least 1 minute of video over a 10 kft LOS distance

### Scope

- Make a prototype setup to transmit and receive analog or digital video
- Use a raspberry pi to overlay text containing telemetry such as altitude, position, etc.
- Does not need to be a PCB yet

### Hints and notes

- To be honest, I am not quite sure how this stuff works and I'm interested in learning as well
- Two ways I can see this being done:
  - 1. Use a project like wifibroadcast[[1](https://befinitiv.wordpress.com/wifibroadcast-analog-like-transmission-of-live-video-data/)][[2](https://hackaday.com/2015/06/13/wifibroadcast-makes-wifi-fpv-video-more-like-analog/)] which transmits digital video. Check out the link for more information.
  - 2. Use a COTS analog 2.4 GHz video transmitter and receiver. Search 2.4 GHz video transmitter for examples. The TX6722 and RX6788 appears to be a common combination for 2.4 GHz band.
  - Consider the differences in quality, error handling and bandwidth required when deciding between analog and digital video
- I'll update this once we get past a prototype

## Software defined gnss receiver

### Success criteria

- Get position and altitude of the rocket through all stages of flight, including stages which exceed the velocity and/or altitude limitations of commercial GNSS receivers (510 m/s, 59,000 ft. See: [Coordinating Committee for Multilateral Export Controls](https://en.wikipedia.org/wiki/Coordinating_Committee_for_Multilateral_Export_Controls?&useskin=vector))

### Scope

- Make a prototype/MVP system for doing this. It doesn't need to fit into a rocket or require self-powering at this current design phase. I will update the project when we have an MVP working.
- Test doing the post-processing on a single board computer.
- Record enough data from launch to landing

### Hints and other notes

- Capture raw [IQ](https://en.wikipedia.org/wiki/In-phase_and_quadrature_components?&useskin=vector) data from an SDR and do the post-processing in something like [GNSS SDR](https://github.com/gnss-sdr/gnss-sdr). Select an appropriate SDR which can digitize the L1 C/A GPS signal
- This exists https://www.rtl-sdr.com/rtl-sdr-tutorial-gps-decoding-plotting/, but it seems to require a computer with windows installed to process the data.

### Future development

- Miniaturize this setup and add a power system for use on a rocket
- Make a custom RF frontend specialized for the GNSS signals which is cheaper than buying an SDR
- Is it possible to use an FPGA to process this signal in real-time? (It's apparently really hard to do... I searched and the latest real-time implementation is from 2013) -->

<!-- # Computer vision based rocket tracker

### Success criteria

- Create a system to track a rocket from launch to X ft (Until it becomes unrecognizable to the human eye or is obscured by cloud cover).

### Scope

- Create a prototype of the system on a perfboard (Does not need a PCB implementation).
- Must capture at least 15 minutes of video footage (enough for one launch)
- Auto-zooms on the rocket
- Must be self-powered either from Pb acid battery, generic powerbank or some self-contained power source

### Hints and other notes

- Use a raspberry pi or some equivalent single board computer with **video processing capabilities** (Hardware-accelerated video encoder) and with enough processing power to do computer vision
- Should mount on a tripod
- Use several servos (pitch yaw and roll) and a servo to control the zoom (Search up zoom lens)

### Future development

- Incorporate this tracking system into the antenna tracker to improve on the RF-based tracking during launch

## -->

## Active tracking antenna

### Purpose

Antennas can be either directional or omnidirectional (Meaning the gain of the antenna is the same no matter how it is oriented). A directional antenna has high gain when oriented at the target, but poor gain if incorrectly oriented. This project will allow us to automatically orient an antenna so it has the maximum gain possible.

### Success criteria

- Track a water bottle rocket (for the first test iteration of the system), then track an L1 rocket!

### Scope

- Create a 2-axis gimbal system capable of supporting the [YAGI-868/914A](https://lprs.co.uk/assets/files/downloads/yagi-868-914a-antenna-datasheet-v1.3.pdf) Yagi-Uda antenna. Mass and dimensions are in the linked datasheet. There is no CAD model but feel free to measure the MMOI and other physical properties from the real antenna in the office.
- You may power the system off any power source you choose, we have a lead acid car battery you can use for the ground station in the office.
- At minimum create a perfboard prototype of the system using modules, or if you are feeling confident make a PCB as well.
- You don't need to make the tripod, feel free to buy something cheap from Aliexpress.

### Hints and other notes

- A video of an antenna tracking system for a [drone](https://www.youtube.com/watch?v=8GCqYTDYZaM). This uses an ardupilot flight computer, but the same principles can be applied to the custom solution you will be developing
  - The gist of it is the target contains a GNSS receiver, and its position is transmitted to the ground station. The ground station has a GNSS receiver to get its location. From the two positions, you can find out where to point the antenna so it is facing the target.
- This is a wikipedia article on [active tracking](https://en.wikipedia.org/wiki/Antenna_tracking_system?&useskin=vector), although in the context of microwave links with satellites. Still, the same principle applies.

## Build your own flight computer

### Purpose

A minimum viable flight computer for a competition grade rocket has at minimum the following functions

- Tracking of the rocket using global navigation satellite system (GNSS) receiver
- Firing of pyrotechnic charges
- Barometric pressure sensor to get the current altitude, and thus fire charges are the correct altitude
- Radio transmitter to transmit position to the ground
- Regulator to create the logic voltage for the components on the board from a basic dry cell battery
- Switch input to arm the system

Optionally, a flight computer may provide other functionality such as

- Storage, to log data which is not transmitted to ground
- Inertial measurement unit (IMU) to get the orientation of the rocket throughout flight
- Battery management system (BMS) when using rechargeable lithium-ion batteries instead of basic dry cell batteries, to allow recharging and safe discharging.
- High-_g_ accelerometer to characterize motor burn
- Able to be interfaced with through USB for configuration
- CAN bus transceiver to communicate with external modules

You will prototype a flight computer on a breadboard, create a perfboard prototype then make a PCB of your flight computer which we will launch in a rocket! (Either your own if you are doing the L1 program or one of our members).

### Milestone 1: Perfboard flight computer

Create a flight computer on a perfboard using the following modules on a perfboard:

- A microcontroller breakout of your choice (in descending order of specs):
  - [Raspberry Pi Pico](https://www.raspberrypi.com/documentation/microcontrollers/raspberry-pi-pico.html)
  - [STM32F411 black pill](https://www.aliexpress.com/item/1005005953179540.html)
    <!-- - [STM32F103 blue pill](https://www.aliexpress.com/item/1005004918334754.html) -->
    <!-- - [ESP32C3](https://www.aliexpress.com/item/1005005183150522.html) -->
  - [Arduino Nano](https://docs.arduino.cc/hardware/nano/)
  - NOTE: We will use the [platformio](https://platformio.org/) platform to program our microcontroller, so the programming process should be similar
- MPU6050 accelerometer
  - Note: if you want a different accelerometer let me know and I'll purchase it for the club
- BME280 barometric pressure sensor
  - Note: if you want a different accelerometer let me know and I'll purchase it for the club
- Memory device pick one
  - Flash memory breakout
  - Micro SD card breakout
- Linear regulator to step down voltage
- Relay board

### Milestone 1b: Programming

We will program a basic flight computer using Arduino. Details to come, but it will include data logging and a way to deploy a parachute.

### Milestone 2: Incorporate GNSS tracking

Since these modules are a bit more expensive, I'm going to share them around

- LoRa Sub-GHz radio
- U-blox GNSS receiver module

### Milestone 3: Create a PCB based on these components
