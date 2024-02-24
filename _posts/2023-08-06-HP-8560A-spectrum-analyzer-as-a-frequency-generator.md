---
title: HP 8560A spectrum analyzer as a frequency generator
author: peter
date: 2023-08-06 21:45:13 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, rf, oscilloscope, spectrum analyzer, hack] # systems | embedded | rf | microwave | electronics | solidworks | automation
image: /assets/img/2023-08-06-HP-8560A-spectrum/preview.png
---

I just bought a Hitachi VC-6025 oscilloscope from my Singapore trip for 85 SGD. It's a good deal, since there is not a lot of second-hand electronics auctions on Ebay Australia, and the shipping costs from overseas or even interstate make it not very economical.

I was inspired by [this blog post](http://www.toughdev.com/content/2021/05/vintage-oscilloscopes-to-the-test-hitachi-vc-6025-gw-instek-gos-6103-and-kenwood-cs-5275/) and decided to test the frequency response of the oscilloscope. I didn't have any sort of frequency generator though, so I used a HP 8560A spectrum analyzer to generate the frequency.

![25 MHz signal from spectrum analyzer](/assets/img/2023-08-06-HP-8560A-spectrum/IMG20230801223458.jpg)

Not shown in the picture, there is a N type to SMA, SMA to BNC cable which connects to the scope (yes, this is very suboptimal but I don't have many cables laying around - I still need to buy probes). The cable is connected to the tracking generator output of the SA.

As you can see on the screen, I'm operating the SA in zero-span mode. This also makes the tracking generator output to have a span of 0 Hz - effectively, it generates a pure signal.

By changing the center frequency I can select the output frequency of the TG. As shown in the image, the oscilloscope is triggering on the 25 MHz signal nicely.

![200 MHz](/assets/img/2023-08-06-HP-8560A-spectrum/IMG20230801222053.jpg)

At 200 MHz, the signal is heavily attenuated (as expected - the bandwidth of the Hitachi VC-6025 is 50 MHz in analog mode) and it is heavily unfocused, however it still triggers. Above 200 MHz it is so unfocused, it becomes unrecognizable.

Bonus image: why CRTs are just great to look at

![CRTs](/assets/img/2023-08-06-HP-8560A-spectrum/IMG20230801205713.jpg)
