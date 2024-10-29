---
title: Useful Mathematica functions for signal processing units
author: peter
date: 2024-08-01 01:40:23 +0800
categories: [Programming, University] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [ELEC4402, communications systems, mathematica] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-08-01-Useful-Mathematica-f/preview.png
---

I will update this as I add more functions.

Using it for the unit ELEC4402 Communication Systems

```mathematica
(* Signal power *)
SigPower[expr_, t_] :=
 Limit[1/(2 T) Integrate[expr^2, {t, -T, T}], T -> Infinity]

(* Normalized sinc function,default Sinc in Mathematica is not \
normalized *)
SincNorm[Infinity] := Sinc[Pi  Infinity]
SincNorm[t_?NumericQ] := Sinc[Pi  t]

(* Fourier transform,frequency in Hz *)
FTfreq[varargs__] :=
 FourierTransform[varargs,
   FourierParameters -> {0, -2*Pi}] /. {Sinc[f_] :>
    SincNorm[Simplify[f/Pi]]}

(* Inverse Fourier transform,frequency in Hz *)
IFTfreq[varargs__] :=
 InverseFourierTransform[varargs,
   FourierParameters -> {0, -2*Pi}] /. {Sinc[f_] :>
    SincNorm[Simplify[f/Pi]]}
```
