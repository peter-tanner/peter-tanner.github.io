---
title: Altium to 3d GLTF
author: peter
date: 2024-02-15 16:41:46 +0800
categories: [Blogging, Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, solidworks] # systems | embedded | rf | microwave | electronics | solidworks | automation
---

As part of the Neptunium flight computer, I wanted to create a proper webpage to showcase the flight computer. This will also be a landing page for people who want to use the wasm powered Neptunium Explorer, which will allow users to analyze flight data in the browser. At the center of this webpage I want to show an interactive 3d model of the flight computer

![Neptunium website](/assets/img/2024-02-15-Altium-to-3d-GLTF/Screen%20Shot%202024-02-15%20at%2016.59.07.png){: height="500" }

While [Altium viewer](https://www.altium.com/viewer/) offers a method of showing PCBs in the browser as interactive 3d models, I wanted more control over this so I wanted to use the [`three.js`](https://threejs.org/) library to display the PCB.

To convert an Altium PCB to GLTF for use in `three.js`, the best way I found is to:

## Steps

1. Export the file as a STEP file (Export > STEP 3D) in Altium. Check "Export As Single Part".
2. Use the MCAD codesigner plugin and push the PCB.
3. In SolidWorks, using the MCAD codesigner plugin pull the PCB and save it to a directory. Keep this file open.
4. Go to Display Manager > View Decals. Expand the decal tree to reveal the two decals used to texture the top and bottom layers. Right click, Edit decal and click on Save Decal for both top and bottom layer decals. You should have two decal files.
5. Open the `STEP` file in SolidWorks. Apply the two decal files, check the boxes to ensure it fits to the plane size. MAKE SURE YOU USE XY PROJECTION. Save the STEP file with the decals as a `SLDPRT`.
6. Open the part in SolidWorks Visualize. Everything should be textured correctly. Now export the files as draco GLTFs. You should get a GLTF, images for the two decals and a .bin file. Copy all of these to your website.

## Why is this process so convoluted?

I found that using MCAD codesigner alone generates an assembly which views fine in SolidWorks, but for some reason the materials are completely broken in SolidWorks Visualize. Exporting a STEP directly from Altium generates a file which has valid materials in Visualize, but lacks the texture for the top and bottom layers. Therefore we still need MCAD codesigner to generate these layer images with the correct scaling.
