---
title: ELEC4406/ELEC2311 notes and tips
author: peter
date: 2024-08-19 02:26:49 +0800
categories: [Blogging] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [getting started] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-08-19-ELEC4406ELEC2311-not/preview.png
---

## Issues with saving file/modifying files not updating the simulation

The optimizer is once again causing issues.

My recommendation is to use `qrun` and do things in the terminal with `assert`s instead of trying to do it graphically using the verification diagrams. It also is much quicker.

For some reason, I can't get incremental compilation working and it just causes more issuse than the time it saves right now, since it results in changes not affecting the simulation, so for now I am cleanly rebuilding each simulation.

```cmd
qrun main.vhd -optimize -simulate -cleanlib -top <Your top level element>
```

## No objects appearing in modelsim/questa for testbenches

⚠ TODO: Fix previous issue in GUI as well (I am now using qrun instead of the GUI).

This is because the signals are being optimized out since they aren't really used for anything useful.

The intel questa/modelsim version shipped with the unit is 18.1, but this allowed vopt to be disabled. This is no longer the case on the latest versions of intel questa (You will get a compile error if you disable vopt flow).

Go to `Simulate > Start Simulation...`, ensure optimization is enabled then click on `Optimization Options...`

![Start simulation GUI](/assets/img/2024-08-19-ELEC4406ELEC2311-not/start_simulation.png)

Then select `Apply full visibility to all modules(full debug mode)` and press `OK`.

![Enable debug mode](/assets/img/2024-08-19-ELEC4406ELEC2311-not/debug_mode.png)

## Dark mode in intel quartus

Run this script I made on windows. [🔗Link](https://github.com/peter-tanner/Intel-Quartus-Dark-Mode-Windows)
