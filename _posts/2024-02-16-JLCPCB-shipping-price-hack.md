---
title: JLCPCB shipping prices
author: peter
date: 2024-02-16 03:13:46 +0800
categories: [Electronics] # Blogging | Electronics | Programming | Mechanical
tags: [electronics, JLCPCB] # systems | embedded | rf | microwave | electronics | solidworks | automation
---


## TL;DR

- Parts assembly adds more mass than you would think to an order
- Mass of a board is calculated by the bounding rectangle dimensions and the PCB thickness, so if you have areas cut out from a board it is still counted. You can see this in the quote screen.
  - Thickness makes a big impact, but it can't be avoided if you want to use economic PCBA.
- A steep jump in price occurs at 0.3 kg, if it's above this mass the incremental jumps in price are less and it's generally not worth optimizing small combined orders to save on shipping (See last plot)

## Details

There is a shipping option called "Global Standard Direct Line" which is the cheapest but has a longer shipping time.

This is pretty good though if you are not a business and want to shave off as much cost as possible, it incentives making more revisions and shipping often, compared to bundling orders in one shipment.

![Shipping estimate](/assets/img/2024-02-16-JLCPCB-shipping-pric/shipping_estimate.png)

This shipping method has the following limits:

![Shipping maximums](/assets/img/2024-02-16-JLCPCB-shipping-pric/maximums.png)

There are price breakpoints though, I have a board which has an estimated mass of 0.18 kg, and it costs 2.35 AUD to ship.

![Shipping estimate no assembly](/assets/img/2024-02-16-JLCPCB-shipping-pric/estimate_no_assembly.png)

However, it looks like assembly really overestimates the mass of the parts (or are they really this heavy in total?). When using assembly, the mass goes up to 0.39 kg total, which goes over some price breakpoint and increases the shipping cost to 14.90 AUD.

If you want seriously cheap shipping then you should golf the final mass to be under 0.3 kg since this is where it changes to 14.90 AUD. 

![Shipping estimate with assembly](/assets/img/2024-02-16-JLCPCB-shipping-pric/estimate_assembly.png)

I will have to do some tests to see how the assembly mass is calculated (whether it is a constant mass for the number of items added or if each item has its own mass), since I really can't see some chips and passives adding 0.2 kg of mass. Also knowing how the shipping is calculated would be nice since it would let us know what the maximum amount of parts are to get 3 AUD shipping.

For Australia, the two options you should only consider are Global Standard Direct Line or DHL Express, the others have higher costs and longer times.

Here's some shipping data from some of my past orders and tests with random PCBs

All prices in AUD.

| Mass [kg] | Global Standard Direct Line | DHL express | S.F Express Standard | FedEx International Packet | UPS Express Saver | Notes                                        |
| --------- | --------------------------- | ----------- | -------------------- | -------------------------- | ----------------- | -------------------------------------------- |
| 0.18      | **3.18**                    | Ignored     | Ignored              | Ignored                    | Ignored           | openGNSS (no assembly)                       |
| 0.29      | **3.18**                    | **28.40**   | 31.42                | 31.72                      | 49.52             | Simulated mass                               |
| 0.33      | 14.35                       | **28.40**   | 31.42                | 31.72                      | 49.52             | Simulated mass                               |
| 0.39      | 14.35                       | Ignored     | Ignored              | Ignored                    | Ignored           | openGNSS (assembled)                         |
| 0.46      | 14.35                       | **28.40**   | 31.42                | 31.72                      | 49.52             | Simulated mass                               |
| 0.56      | 19.80                       | Ignored     | Ignored              | Ignored                    | Ignored           | Test                                         |
| 0.59      | 20.68                       | Ignored     | Ignored              | Ignored                    | Ignored           | Test: openGNSS (assembled), patch antenna V3 |
| 0.60      | 20.68                       | Ignored     | Ignored              | Ignored                    | Ignored           | Test: openGNSS (assembled), patch antenna V2 |
| 0.61      | 20.68                       | Ignored     | Ignored              | Ignored                    | Ignored           | Test: openGNSS (assembled), patch antenna    |
| 0.67      | 23.39                       | 40.49       | 37.42                | 45.02                      | 67.74             | Simulated mass                               |
| 0.8       | 23.61                       | 40.49       | 37.42                | 45.02                      | 67.74             | Neptunium Order after assembly               |
| 1.19      | 31.59                       | 63.01       | 43.06                | 64.40                      | 46.65$A           | Simulated mass                               |

```mathematica
prices = {{0.18, 3.18}, {0.29, 3.18}, {0.33, 14.35}, {0.39, 
   14.35}, {0.46, 14.35}, {0.56, 19.80}, {0.59, 20.68}, {0.60, 
   20.68}, {0.61, 20.68}, {0.67, 23.39}, {0.8, 23.61}, {1.19, 31.59}}

ListPlot[prices]
```

Price plot for Global Standard Direct Line

![Price plot for Global Standard Direct Line](/assets/img/2024-02-16-JLCPCB-shipping-pric/price_plot.png)