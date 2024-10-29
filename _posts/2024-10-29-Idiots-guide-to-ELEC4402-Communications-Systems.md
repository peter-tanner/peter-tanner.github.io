---
title: Idiot's guide to ELEC4402 Communications Systems
author: peter
date: 2024-10-29 16:11:34 +0800
categories: [Guides, University]    # 0-2 categories. Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [ELEC4402, communications systems, guide, formula sheet, datasheet, notes]   # 0-\infty. systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-10-29-Idiots-guide-to-ELEC/2024-10-29-Idiots-guide-to-ELEC/preview.png
math: true
---

This unit allows you to bring infinite physical notes (except books borrowed from the UWA library) to all tests and the final exam. You can't rely on what material they provide in the test/exam, it is very _minimal_ to say the least. Hope this helps.

If you have issues or suggestions, [raise them on GitHub](https://github.com/peter-tanner/IDIOTS-GUIDE-TO-ELEC4402-communication-systems/issues/new). I accept [pull requests](https://github.com/peter-tanner/IDIOTS-GUIDE-TO-ELEC4402-communication-systems/pulls) for fixes or suggestions but the content must not be copyrighted under a non-GPL compatible license.

## [Download PDF 📄](https://raw.githubusercontent.com/peter-tanner/IDIOTS-GUIDE-TO-ELEC4402-communication-systems/refs/heads/master/README.pdf)

It is recommended to refer to use [the PDF copy](https://raw.githubusercontent.com/peter-tanner/IDIOTS-GUIDE-TO-ELEC4402-communication-systems/refs/heads/master/README.pdf) instead of this webpage for offline viewing/printing.

## License and information

Notes are open-source and licensed under the GNU GPL-3.0. **You must include the [full-text of the license](https://github.com/peter-tanner/IDIOTS-GUIDE-TO-ELEC4402-communication-systems/blob/master/COPYING.txt) and follow its terms when using these notes or any diagrams in derivative works** (but not when printing as notes)

Copyright (C) 2024 Peter Tanner

<details>
<summary>GPL copyright information</summary>
Copyright (C) 2024 Peter Tanner

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. If not, see <http://www.gnu.org/licenses/>.

</details>

## Fourier transform identities

| **Time Function**                                                     | **Fourier Transform**                                                                                                                     |
| --------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| $\text{rect}\left(\frac{t}{T}\right)\quad\Pi\left(\frac{t}{T}\right)$ | $T \text{sinc}(fT)$                                                                                                                       |
| $\text{sinc}(2Wt)$                                                    | $\frac{1}{2W}\text{rect}\left(\frac{f}{2W}\right)\quad\frac{1}{2W}\Pi\left(\frac{f}{2W}\right)$                                           |
| $\exp(-at)u(t),\quad a>0$                                             | $\frac{1}{a + j2\pi f}$                                                                                                                   |
| $\exp(-a\lvert t \rvert),\quad a>0$                                   | $\frac{2a}{a^2 + (2\pi f)^2}$                                                                                                             |
| $\exp(-\pi t^2)$                                                      | $\exp(-\pi f^2)$                                                                                                                          |
| $1 - \frac{\lvert t \rvert}{T},\quad\lvert t \rvert < T$              | $T \text{sinc}^2(fT)$                                                                                                                     |
| $\delta(t)$                                                           | $1$                                                                                                                                       |
| $1$                                                                   | $\delta(f)$                                                                                                                               |
| $\delta(t - t_0)$                                                     | $\exp(-j2\pi f t_0)$                                                                                                                      |
| $g(t-a)$                                                              | $\exp(-j2\pi fa)G(f)\quad\text{shift property}$                                                                                           |
| $g(bt)$                                                               | $\frac{G(f/b)}{\|b\|}\quad\text{scaling property}$                                                                                        |
| $g(bt-a)$                                                             | $\frac{1}{\|b\|}\exp(-j2\pi a(f/b))\cdot G(f/b)\quad\text{shift and scale}$                                                               |
| $\frac{d}{dt}g(t)$                                                    | $j2\pi fG(f)\quad\text{differentiation property}$                                                                                         |
| $G(t)$                                                                | $g(-f)\quad\text{duality property}$                                                                                                       |
| $g(t)h(t)$                                                            | $G(f)*H(f)$                                                                                                                               |
| $g(t)*h(t)$                                                           | $G(f)H(f)$                                                                                                                                |
| $\exp(j2\pi f_c t)$                                                   | $\delta(f - f_c)$                                                                                                                         |
| $\cos(2\pi f_c t)$                                                    | $\frac{1}{2}[\delta(f - f_c) + \delta(f + f_c)]$                                                                                          |
| $\sin(2\pi f_c t)$                                                    | $\frac{1}{2j} [\delta(f - f_c) - \delta(f + f_c)]$                                                                                        |
| $\text{sgn}(t)$                                                       | $\frac{1}{j\pi f}$                                                                                                                        |
| $\frac{1}{\pi t}$                                                     | $-j \text{sgn}(f)$                                                                                                                        |
| $u(t)$                                                                | $\frac{1}{2} \delta(f) + \frac{1}{j2\pi f}$                                                                                               |
| $\sum_{n=-\infty}^{\infty} \delta(t - nT_0)$                          | $\frac{1}{T_0} \sum_{n=-\infty}^{\infty} \delta\left(f - \frac{n}{T_0}\right)=f_0 \sum_{n=-\infty}^{\infty} \delta\left(f - n f_0\right)$ |

$$
\begin{align*}
    u(t) &= \begin{cases} 1, & t > 0 \\ \frac{1}{2}, & t = 0 \\ 0, & t < 0 \end{cases}&\text{Unit Step Function}\\
    \text{sgn}(t) &= \begin{cases} +1, & t > 0 \\ 0, & t = 0 \\ -1, & t < 0 \end{cases}&\text{Signum Function}\\
    \text{sinc}(2Wt) &= \frac{\sin(2\pi W t)}{2\pi W t}&\text{sinc Function}\\
    \text{rect}(t) = \Pi(t) &= \begin{cases} 1, & -0.5 < t < 0.5 \\ 0, & \lvert t \rvert > 0.5 \end{cases}&\text{Rectangular/Gate Function}\\
    g(t)*h(t)=(g*h)(t)&=\int_\infty^\infty g(\tau)h(t-\tau)d\tau&\text{Convolution}\\
\end{align*}
$$

### Fourier transform of continuous time periodic signal

Required for some questions on **sampling**:

<!-- Transform a continuous time-periodic signal $x(t)=\sum_{n=-\infty}^\infty x_p(t-nT_s)$ with period $T_s$: -->

Transform a continuous time-periodic signal $x_p(t)=\sum_{n=-\infty}^\infty x(t-nT_s)$ with period $T_s$:

$$
X_p(f)=\sum_{n=-\infty}^\infty C_n\delta(f-nf_s)\quad f_s=\frac{1}{T_s}
$$

Calculate $C_n$ coefficient as follows from $x_p(t)$:

<!-- Remember $X_p(f)\leftrightarrow x_p(t)$ and **NOT** $\color{red}X_p(f)\leftrightarrow x_p(t-nT_s)$ -->

$$
\begin{align*}
    % C_n&=X_p(nf_s)\\
    C_n&=\frac{1}{T_s} \int_{T_s} x_p(t)\exp(-j2\pi f_s t)dt\\
       &=\frac{1}{T_s} X(nf_s)\quad\color{red}\text{(TODO: Check)}\quad\color{white}\text{$x(t-nT_s)$ is contained in the interval $T_s$}
\end{align*}
$$

### $\text{rect}$ function

![rect](/assets/img/2024-10-29-Idiots-guide-to-ELEC/rect.drawio.svg)

### Bessel function

$$
\begin{align*}
    \sum_{n\in\mathbb{Z}}{J_n}^2(\beta)&=1\\
    J_n(\beta)&=(-1)^nJ_{-n}(\beta)
\end{align*}
$$

### White noise

$$
\begin{align*}
R_W(\tau)&=\frac{N_0}{2}\delta(\tau)=\frac{kT}{2}\delta(\tau)=\sigma^2\delta(\tau)\\
G_w(f)&=\frac{N_0}{2}\\
N_0&=kT\\
G_y(f)&=|H(f)|^2G_w(f)\\
G_y(f)&=G(f)G_w(f)\\
\end{align*}
$$

### WSS

$$
\begin{align*}
    \mu_X(t) &= \mu_X\text{ Constant}\\
    R_{XX}(t_1,t_2)&=R_X(t_1-t_2)=R_X(\tau)\\
    E[X(t_1)X(t_2)]&=E[X(t)X(t+\tau)]
\end{align*}
$$

### Ergodicity

$$
\begin{align*}
    \braket{X(t)}_T&=\frac{1}{2T}\int_{-T}^{T}x(t)dt\\
    \braket{X(t+\tau)X(t)}_T&=\frac{1}{2T}\int_{-T}^{T}x(t+\tau)x(t)dt\\
    E[\braket{X(t)}_T]&=\frac{1}{2T}\int_{-T}^{T}x(t)dt=\frac{1}{2T}\int_{-T}^{T}m_Xdt=m_X\\
\end{align*}
$$

| Type                                | Normal                                                  | Mean square sense                                           |
| ----------------------------------- | ------------------------------------------------------- | ----------------------------------------------------------- |
| ergodic in mean                     | $$\lim_{T\to\infty}\braket{X(t)}_T=m_X(t)=m_X$$         | $$\lim_{T\to\infty}\text{VAR}[\braket{X(t)}_T]=0$$          |
| ergodic in autocorrelation function | $$\lim_{T\to\infty}\braket{X(t+\tau)X(t)}_T=R_X(\tau)$$ | $$\lim_{T\to\infty}\text{VAR}[\braket{X(t+\tau)X(t)}_T]=0$$ |

Note: **A WSS random process needs to be both ergodic in mean and autocorrelation to be considered an ergodic process**

### Other identities

$$
\begin{align*}
    f*(g*h) &=(f*g)*h\quad\text{Convolution associative}\\
    a(f*g) &= (af)*g \quad\text{Convolution associative}\\
    \sum_{x=-\infty}^\infty(f(x a)\delta(\omega-x b))&=f\left(\frac{\omega a}{b}\right)
\end{align*}
$$

### Other trig

$$
\begin{align*}
    \cos2\theta=2 \cos^2 \theta-1&\Leftrightarrow\frac{\cos2\theta+1}{2}=\cos^2\theta\\
    e^{-j\alpha}-e^{j\alpha}&=-2j \sin(\alpha)\\
    e^{-j\alpha}+e^{j\alpha}&=2 \cos(\alpha)\\
    \cos(-A)&=\cos(A)\\
    \sin(-A)&=-\sin(A)\\
    \sin(A+\pi/2)&=\cos(A)\\
    \sin(A-\pi/2)&=-\cos(A)\\
    \cos(A-\pi/2)&=\sin(A)\\
    \cos(A+\pi/2)&=-\sin(A)\\
    \int_{x\in\mathbb{R}}\text{sinc}(A x) &= \frac{1}{|A|}\\
\end{align*}
$$

$$
\begin{align*}
    \cos(A+B) &= \cos (A) \cos (B)-\sin (A) \sin (B) \\
    \sin(A+B) &= \sin (A) \cos (B)+\cos (A) \sin (B) \\
    \cos(A)\cos(B) &= \frac{1}{2} (\cos (A-B)+\cos (A+B)) \\
    \cos(A)\sin(B) &= \frac{1}{2} (\sin (A+B)-\sin (A-B)) \\
    \sin(A)\sin(B) &= \frac{1}{2} (\cos (A-B)-\cos (A+B)) \\
\end{align*}
$$

$$
\begin{align*}
    \cos(A)+\cos(B) &= 2 \cos \left(\frac{A}{2}-\frac{B}{2}\right) \cos \left(\frac{A}{2}+\frac{B}{2}\right) \\
    \cos(A)-\cos(B) &= -2 \sin \left(\frac{A}{2}-\frac{B}{2}\right) \sin \left(\frac{A}{2}+\frac{B}{2}\right) \\
    \sin(A)+\sin(B) &= 2 \sin \left(\frac{A}{2}+\frac{B}{2}\right) \cos \left(\frac{A}{2}-\frac{B}{2}\right) \\
    \sin(A)-\sin(B) &= 2 \sin \left(\frac{A}{2}-\frac{B}{2}\right) \cos \left(\frac{A}{2}+\frac{B}{2}\right) \\
    \cos(A)+\sin(B)&= -2 \sin \left(\frac{A}{2}-\frac{B}{2}-\frac{\pi }{4}\right) \sin \left(\frac{A}{2}+\frac{B}{2}+\frac{\pi }{4}\right) \\
    \cos(A)-\sin(B)&= -2 \sin \left(\frac{A}{2}+\frac{B}{2}-\frac{\pi }{4}\right) \sin \left(\frac{A}{2}-\frac{B}{2}+\frac{\pi }{4}\right) \\
\end{align*}
$$

## IQ/Complex envelope

Def. $\tilde{g}(t)=g_I(t)+jg_Q(t)$ as the complex envelope. Best to convert to $e^{j\theta}$ form.

### Convert complex envelope representation to time-domain representation of signal

$$
\begin{align*}
g(t)&=g_I(t)\cos(2\pi f_c t)-g_Q(t)\sin(2\pi f_c t)\\
&=\text{Re}[\tilde{g}(t)\exp{(j2\pi f_c t)}]\\
&=A(t)\cos(2\pi f_c t+\phi(t))\\
A(t)&=|g(t)|=\sqrt{g_I^2(t)+g_Q^2(t)}\quad\text{Amplitude}\\
\phi(t)&\quad\text{Phase}\\
g_I(t)&=A(t)\cos(\phi(t))\quad\text{In-phase component}\\
g_Q(t)&=A(t)\sin(\phi(t))\quad\text{Quadrature-phase component}\\
\end{align*}
$$

### For transfer function

$$
\begin{align*}
h(t)&=h_I(t)\cos(2\pi f_c t)-h_Q(t)\sin(2\pi f_c t)\\
&=2\text{Re}[\tilde{h}(t)\exp{(j2\pi f_c t)}]\\
\Rightarrow\tilde{h}(t)&=h_I(t)/2+jh_Q(t)/2=A(t)/2\exp{(j\phi(t))}
\end{align*}
$$

## AM

### CAM

$$
\begin{align*}
    m_a &= \frac{\min_t|k_a m(t)|}{A_c} \quad\text{$k_a$ is the amplitude sensitivity ($\text{volt}^{-1}$), $m_a$ is the modulation index.}\\
    m_a &= \frac{A_\text{max}-A_\text{min}}{A_\text{max}+A_\text{min}}\quad\text{ (Symmetrical $m(t)$)}\\
    m_a&=k_a A_m \quad\text{ (Symmetrical $m(t)$)}\\
    x(t)&=A_c\cos(2\pi f_c t)\left[1+k_a m(t)\right]=A_c\cos(2\pi f_c t)\left[1+m_a m(t)/A_c\right], \\
    &\text{where $m(t)=A_m\hat m(t)$ and $\hat m(t)$ is the normalized modulating signal}\\
    P_c &=\frac{ {A_c}^2}{2}\quad\text{Carrier power}\\
    P_x &=\frac{1}{4}{m_a}^2{A_c}^2\\
    \eta&=\frac{\text{Signal Power}}{\text{Total Power}}=\frac{P_x}{P_x+P_c}\\
    B_T&=2f_m=2B
\end{align*}
$$

$B_T$: Signal bandwidth
$B$: Bandwidth of modulating wave

Overmodulation (resulting in phase reversals at crossing points): $m_a>1$

### DSB-SC

$$
\begin{align*}
    x_\text{DSB}(t) &= A_c \cos{(2\pi f_c t)} m(t)\\
    B_T&=2f_m=2B
\end{align*}
$$

## FM/PM

$$
\begin{align*}
    s(t) &= A_c\cos\left[2\pi f_c t + k_p m(t)\right]\quad\text{Phase modulated (PM)}\\
    s(t) &= A_c\cos\left[2\pi f_c t + 2 \pi k_f \int_0^t m(\tau) d\tau\right]\quad\text{Frequency modulated (FM)}\\
    s(t) &= A_c\cos\left[2\pi f_c t + \beta \sin(2\pi f_m t)\right]\quad\text{FM single tone}\\
    \beta&=\frac{\Delta f}{f_m}=k_f A_m\quad\text{Modulation index}\\
    \Delta f&=\beta f_m=k_f A_m f_m = \max_t(k_f m(t))- \min_t(k_f m(t))\quad\text{Maximum frequency deviation}\\
    D&=\frac{\Delta f}{W_m}\quad\text{Deviation ratio, where $W_m$ is bandwidth of $m(t)$ (Use FT)}
\end{align*}
$$

### Bessel form and magnitude spectrum (single tone)

$$
\begin{align*}
    s(t) &= A_c\cos\left[2\pi f_c t + \beta \sin(2\pi f_m t)\right] \Leftrightarrow s(t)= A_c\sum_{n=-\infty}^{\infty}J_n(\beta)\cos[2\pi(f_c+nf_m)t]
\end{align*}
$$

### FM signal power

$$
\begin{align*}
    P_\text{av}&=\frac{ {A_c}^2}{2}\\
    P_\text{band\_index}&=\frac{ {A_c}^2{J_\text{band\_index}}^2(\beta)}{2}\\
    \text{band\_index}&=0\implies f_c+0f_m\\
    \text{band\_index}&=1\implies f_c+1f_m,\dots\\
\end{align*}
$$

### Carson's rule to find $B$ (98% power bandwidth rule)

$$
\begin{align*}
B &= 2Mf_m = 2(\beta + 1)f_m\\
    &= 2(\Delta f+f_m)\\
    &= 2(k_f A_m+f_m)\\
    &= 2(D+1)W_m\\
B &= \begin{cases}
    2(\Delta f+f_m) & \text{FM, sinusoidal message}\\
    2(\Delta\phi + 1)f_m & \text{PM, sinusoidal message}
\end{cases}\\
\end{align*}
$$

#### $\Delta f$ of arbitrary modulating signal

Find instantaneous frequency $f_\text{FM}$.

$M$: Number of **pairs** of significant sidebands

$$
\begin{align*}
s(t)&=A_c\cos(\theta_\text{FM}(t))\\
f_\text{FM}(t) &= \frac{1}{2\pi}\frac{d\theta_\text{FM}(t)}{dt}\\
A_m &= \max_t|m(t)|\\
\Delta f &= \max_t(f_\text{FM}(t)) - f_c\\
W_m &= \text{max}(\text{frequencies in $\theta_\text{FM}(t)$...}) \\
\text{Example: }&\text{sinc}(At+t)+2\cos(2\pi t)=\frac{\sin(2\pi((At+t)/2))}{\pi(At+t)}+2\cos(2\pi t)\to W_m=\max\left(\frac{A+1}{2},1\right)\\
D &= \frac{\Delta f}{W_m}\\
B_T &= 2(D+1)W_m
\end{align*}
$$

### Complex envelope

$$
\begin{align*}
    s(t)&=A_c\cos(2\pi f_c t+\beta\sin(2\pi f_m t)) \Leftrightarrow \tilde{s}(t) = A_c\exp(j\beta\sin(2\pi f_m t))\\
    s(t)&=\text{Re}[\tilde{s}(t)\exp{(j2\pi f_c t)}]\\
    \tilde{s}(t) &= A_c\sum_{n=-\infty}^{\infty}J_n(\beta)\exp(j2\pi f_m t)
\end{align*}
$$

### Band

| Narrowband    | Wideband      |
| ------------- | ------------- |
| $D<1,\beta<1$ | $D>1,\beta>1$ |

## Power, energy and autocorrelation

$$
\begin{align*}
    G_\text{WGN}(f)&=\frac{N_0}{2}\\
    G_x(f)&=|H(f)|^2G_w(f)\text{ (PSD)}\\
    G_x(f)&=G(f)G_w(f)\text{ (PSD)}\\
    G_x(f)&=\lim_{T\to\infty}\frac{|X_T(f)|^2}{T}\text{ (PSD)}\\
    G_x(f)&=\mathfrak{F}[R_x(\tau)]\text{ (WSS)}\\
    P&=\sigma^2=\int_\mathbb{R}G_x(f)df\\
    P&=\sigma^2=\lim_{t\to\infty}\frac{1}{T}\int_{-T/2}^{T/2}|x(t)|^2dt\\
    P[A\cos(2\pi f t+\phi)]&=\frac{A^2}{2}\quad\text{Power of sinusoid }\\
    E&=\int_{-\infty}^{\infty}|x(t)|^2dt=|X(f)|^2\\
    R_x(\tau) &= \mathfrak{F}(G_x(f))\quad\text{PSD to Autocorrelation}
\end{align*}
$$

##

## Noise performance

$$
\begin{align*}
    \text{CNR}_\text{in} &= \frac{P_\text{in}}{P_\text{noise}}\\
    \text{CNR}_\text{in,FM} &= \frac{A^2}{2WN_0}\\
    \text{SNR}_\text{FM} &= \frac{3A^2k_f^2P}{2N_0W^3}\\
    \text{SNR(dB)} &= 10\log_{10}(\text{SNR}) \quad\text{Decibels from ratio}
\end{align*}
$$

## Sampling

$$
\begin{align*}
    t&=nT_s\\
    T_s&=\frac{1}{f_s}\\
    x_s(t)&=x(t)\delta_s(t)=x(t)\sum_{n\in\mathbb{Z}}\delta(t-nT_s)=\sum_{n\in\mathbb{Z}}x(nT_s)\delta(t-nT_s)\\
    X_s(f)&=X(f)*\sum_{n\in\mathbb{Z}}\delta\left(f-\frac{n}{T_s}\right)=X(f)*\sum_{n\in\mathbb{Z}}\delta\left(f-n f_s\right)\\
    B&>\frac{1}{2}f_s, 2B>f_s\rightarrow\text{Aliasing}\\
\end{align*}
$$

### Procedure to reconstruct sampled signal

Analog signal $x'(t)$ which can be reconstructed from a sampled signal $x_s(t)$: Put $x_s(t)$ through LPF with maximum frequency of $f_s/2$ and minimum frequency of $-f_s/2$. Anything outside of the BPF will be attenuated, therefore $n$ which results in frequencies outside the BPF will evaluate to $0$ and can be ignored.

Example: $f_s=5000\implies \text{LPF}\in[-2500,2500]$

Then iterate for $n=0,1,-1,2,-2,\dots$ until the first iteration where the result is 0 since all terms are eliminated by the LPF.

TODO: Add example

Then add all terms and transform $\bar X_s(f)$ back to time domain to get $x_s(t)$

### Fourier transform of continuous time periodic signal (1)

Required for some questions on **sampling**:

<!-- Transform a continuous time-periodic signal $x(t)=\sum_{n=-\infty}^\infty x_p(t-nT_s)$ with period $T_s$: -->

Transform a continuous time-periodic signal $x_p(t)=\sum_{n=-\infty}^\infty x(t-nT_s)$ with period $T_s$:

$$
X_p(f)=\sum_{n=-\infty}^\infty C_n\delta(f-nf_s)\quad f_s=\frac{1}{T_s}
$$

Calculate $C_n$ coefficient as follows from $x_p(t)$:

<!-- Remember $X_p(f)\leftrightarrow x_p(t)$ and **NOT** $\color{red}X_p(f)\leftrightarrow x_p(t-nT_s)$ -->

$$
\begin{align*}
    % C_n&=X_p(nf_s)\\
    C_n&=\frac{1}{T_s} \int_{T_s} x_p(t)\exp(-j2\pi f_s t)dt\\
       &=\frac{1}{T_s} X(nf_s)\quad\color{red}\text{(TODO: Check)}\quad\color{white}\text{$x(t-nT_s)$ is contained in the interval $T_s$}
\end{align*}
$$

<!-- Reconstruct from $\bar{X_s}(f)$ within the range $[-f_s/2,f_s/2]$ -->

### Nyquist criterion for zero-ISI

Do not transmit more than $2B$ samples per second over a channel of $B$ bandwidth.

![By Bob K - Own work, CC0, https://commons.wikimedia.org/w/index.php?curid=94674142](/assets/img/2024-10-29-Idiots-guide-to-ELEC/Nyquist_frequency_&_rate.svg)

### Insert here figure 8.3 from M F Mesiya - Contemporary Communication Systems (Add image to `assets/img/2024-10-29-Idiots-guide-to-ELEC/sampling.png`)

Cannot add directly due to copyright!

<!-- ![sampling](copyrighted_assets/img/2024-10-29-Idiots-guide-to-ELEC/sampling.png) -->
<!-- ![sampling](/assets/img/2024-10-29-Idiots-guide-to-ELEC/sampling.png) -->

## Quantizer

$$
\begin{align*}
    \Delta &= \frac{x_\text{Max}-x_\text{Min}}{2^k} \quad\text{for $k$-bit quantizer (V/lsb)}\\
\end{align*}
$$

### Quantization noise

$$
\begin{align*}
    e &:= y-x\quad\text{Quantization error}\\
    \mu_E &= E[E] = 0\quad\text{Zero mean}\\
    {\sigma_E}^2&=E[E^2]-0^2=\int_{-\Delta/2}^{\Delta/2}e^2\times\left(\frac{1}{\Delta}\right) de\quad\text{Where $E\thicksim 1/\Delta$ uniform over $(-\Delta/2,\Delta/2)$}\\
    \text{SQNR}&=\frac{\text{Signal power}}{\text{Quantization noise}}\\
    \text{SQNR(dB)}&=10\log_{10}(\text{SQNR})
\end{align*}
$$

### Insert here figure 8.17 from M F Mesiya - Contemporary Communication Systems (Add image to `assets/img/2024-10-29-Idiots-guide-to-ELEC/quantizer.png`)

Cannot add directly due to copyright!
<!-- ![quantizer](copyrighted_assets/img/2024-10-29-Idiots-guide-to-ELEC/quantizer.png) -->
<!-- ![quantizer](/assets/img/2024-10-29-Idiots-guide-to-ELEC/quantizer.png) -->

## Line codes

![binary_codes](/assets/img/2024-10-29-Idiots-guide-to-ELEC/Line_Codes.drawio.svg)

$$
\begin{align*}
    R_b&\rightarrow\text{Bit rate}\\
    D&\rightarrow\text{Symbol rate | }R_d\text{ | }1/T_b\\
    A&\rightarrow m_a\\
    V(f)&\rightarrow\text{Pulse shape}\\
    V_\text{rectangle}(f)&=T\text{sinc}(fT\times\text{DutyCycle})\\
    G_\text{MunipolarNRZ}(f)&=\frac{(M^2-1)A^2D}{12}|V(f)|^2+\frac{(M-1)^2}{4}(DA)^2\sum_{l=-\infty}^{\infty}|V(lD)|^2\delta(f-lD)\\
    G_\text{MpolarNRZ}(f)&=\frac{(M^2-1)A^2D}{3}|V(f)|^2\\
    G_\text{unipolarNRZ}(f)&=\frac{A^2}{4R_b}\left(\text{sinc}^2\left(\frac{f}{R_b}\right)+R_b\delta(f)\right), \text{NB}_0=R_b\\
    G_\text{polarNRZ}(f)&=\frac{A^2}{R_b}\text{sinc}^2\left(\frac{f}{R_b}\right)\\
    G_\text{unipolarNRZ}(f)&=\frac{A^2}{4R_b}\left(\text{sinc}^2\left(\frac{f}{R_b}\right)+R_b\delta(f)\right)\\
    G_\text{unipolarRZ}(f)&=\frac{A^2}{16} \left(\sum _{l=-\infty }^{\infty } \delta \left(f-\frac{l}{T_b}\right) \left| \text{sinc}(\text{duty} \times l) \right| {}^2+T_b \left| \text{sinc}\left(\text{duty} \times f T_b\right) \right| {}^2\right), \text{NB}_0=2R_b
\end{align*}
$$

## Modulation and basis functions

![Constellation diagrams](./assets/img/2024-10-29-Idiots-guide-to-ELEC/Constellation.drawio.svg)

### BASK

#### Basis functions

$$
\begin{align*}
    \varphi_1(t) &= \sqrt{\frac{2}{T_b}}\cos(2\pi f_c t)\quad0\leq t\leq T_b\\
\end{align*}
$$

#### Symbol mapping

$$
b_n:\{1,0\}\to a_n:\{1,0\}
$$

#### 2 possible waveforms

$$
\begin{align*}
    s_1(t)&=A_c\sqrt{\frac{T_b}{2}}\varphi_1(t)=\sqrt{2E_b}\varphi_1(t)\\
    s_1(t)&=0\\
    &\text{Since $E_b=E_\text{average}=\frac{1}{2}(\frac{ {A_c}^2}{2}\times T_b + 0)=\frac{ {A_c}^2}{4}T_b$}
\end{align*}
$$

Distance is $d=\sqrt{2E_b}$

### BPSK

#### Basis functions

$$
\begin{align*}
    \varphi_1(t) &= \sqrt{\frac{2}{T_b}}\cos(2\pi f_c t)\quad0\leq t\leq T_b\\
\end{align*}
$$

#### Symbol mapping

$$
b_n:\{1,0\}\to a_n:\{1,\color{green}-1\color{white}\}
$$

#### 2 possible waveforms

$$
\begin{align*}
    s_1(t)&=A_c\sqrt{\frac{T_b}{2}}\varphi_1(t)=\sqrt{E_b}\varphi_1(t)\\
    s_1(t)&=-A_c\sqrt{\frac{T_b}{2}}\varphi_1(t)=-\sqrt{E_b}\varphi_2(t)\\
    &\text{Since $E_b=E_\text{average}=\frac{1}{2}(\frac{ {A_c}^2}{2}\times T_b + \frac{ {A_c}^2}{2}\times T_b)=\frac{ {A_c}^2}{2}T_b$}
\end{align*}
$$

Distance is $d=2\sqrt{E_b}$

### QPSK ($M=4$ PSK)

#### Basis functions

$$
\begin{align*}
    T &= 2 T_b\quad\text{Time per symbol for two bits $T_b$}\\
    \varphi_1(t) &= \sqrt{\frac{2}{T}}\cos(2\pi f_c t)\quad0\leq t\leq T\\
    \varphi_2(t) &= \sqrt{\frac{2}{T}}\sin(2\pi f_c t)\quad0\leq t\leq T\\
\end{align*}
$$

### 4 possible waveforms

$$
\begin{align*}
    s_1(t)&=\sqrt{E_s/2}\left[\varphi_1(t)+\varphi_2(t)\right]\\
    s_2(t)&=\sqrt{E_s/2}\left[\varphi_1(t)-\varphi_2(t)\right]\\
    s_3(t)&=\sqrt{E_s/2}\left[-\varphi_1(t)+\varphi_2(t)\right]\\
    s_4(t)&=\sqrt{E_s/2}\left[-\varphi_1(t)-\varphi_2(t)\right]\\
\end{align*}
$$

Note on energy per symbol: Since $|s_i(t)|=A_c$, have to normalize distance as follows:

$$
\begin{align*}
    s_i(t)&=A_c\sqrt{T/2}/\sqrt{2}\times\left[\alpha_{1i}\varphi_1(t)+\alpha_{2i}\varphi_2(t)\right]\\
          &=\sqrt{T{A_c}^2/4}\left[\alpha_{1i}\varphi_1(t)+\alpha_{2i}\varphi_2(t)\right]\\
          &=\sqrt{E_s/2}\left[\alpha_{1i}\varphi_1(t)+\alpha_{2i}\varphi_2(t)\right]\\
\end{align*}
$$

#### Signal

$$
\begin{align*}
    \text{Symbol mapping: }& \left\{1,0\right\}\to\left\{1,-1\right\}\\
    I(t) &= b_{2n}\varphi_1(t)\quad\text{Even bits}\\
    Q(t) &= b_{2n+1}\varphi_2(t)\quad\text{Odd bits}\\
    x(t) &= A_c[I(t)\cos(2\pi f_c t)-Q(t)\sin(2\pi f_c t)]
\end{align*}
$$

### Example of waveform

<details>
<summary>Code</summary>
<pre><code>
tBitstream[bitstream_, Tb_, title_] :=
  Module[{timeSteps, gridLines, plot},
   timeSteps =
    Flatten[Table[{(n - 1)     Tb, bitstream[[n]]}, {n, 1,
        Length[bitstream]}] /. {t_, v_} :> { {t, v}, {t + Tb, v}}, 1];
   gridLines = {Join[
      Table[{n  Tb, Dashed}, {n, 1, 2  Length[bitstream], 2}],
      Table[{n  Tb, Thin}, {n, 0, 2  Length[bitstream], 2}]], None};
   plot =
    Labeled[ListLinePlot[timeSteps, InterpolationOrder -> 0,
      PlotRange -> Full, GridLines -> gridLines, PlotStyle -> Thick,
      Ticks -> {Table[{n     Tb,
          Row[{n, "\!\(\*SubscriptBox[\(T\), \(b\)]\)"}]}, {n, 0,
          Length[bitstream]}], {-1, 0, 1}},
      LabelStyle -> Directive[Bold, 12],
      PlotRangePadding -> {Scaled[.05]}, AspectRatio -> 0.1,
      ImageSize -> Large], {Style[title, "Text", 16]}, {Right}]];

tBitstream[{0, 1, 0, 0, 1, 0, 1, 1, 1, 0}, 1, "Bitstream Step Plot"]
tBitstream[{-1, -1, -1, -1, 1, 1, 1, 1, 1, 1}, 1, "I(t)"]
tBitstream[{1, 1, -1, -1, -1, -1, 1, 1, -1, -1}, 1, "Q(t)"]
</code></pre>

</details>

Remember that $T=2T_b$

|                         |                                                                         |
| ----------------------- | ----------------------------------------------------------------------- |
| $b_n$                   | ![QPSK bits](/assets/img/2024-10-29-Idiots-guide-to-ELEC/qpsk-bits.svg) |
| $I(t)$ (Odd, 1st bits)  | ![QPSK bits](/assets/img/2024-10-29-Idiots-guide-to-ELEC/qpsk-it.svg)   |
| $Q(t)$ (Even, 2nd bits) | ![QPSK bits](/assets/img/2024-10-29-Idiots-guide-to-ELEC/qpsk-qt.svg)   |

## Matched filter

### 1. Filter function

Find transfer function $h(t)$ of matched filter and apply to an input:

$$
\begin{align*}
    h(t)&=s_1(T-t)-s_2(T-t)\\
    h(t)&=s^*(T-t) \qquad\text{((.)* is the conjugate)}\\
    s_{on}(t)&=h(t)*s_n(t)=\int_\infty^\infty h(\tau)s_n(t-\tau)d\tau\quad\text{Filter output}\\
    n_o(t)&=h(t)*n(t)\quad\text{Noise at filter output}
\end{align*}
$$

### 2. Bit error rate

Bit error rate (BER) from matched filter outputs and filter output noise

$$
\begin{align*}
    % H_\text{opt}(f)&=\max_{H(f)}\left(\frac{s_{o1}-s_{o2}}{2\sigma_o}\right)

    % \text{BER}_\text{bin}&=p Q\left(\frac{s_{o1}-V_T}{\sigma_o}\right)+(1-p)Q\left(\frac{V_T-s_{o2}}{\sigma_o}\right)\text{, $p\rightarrow$Probability $s_1(t)$ sent, $V_T\rightarrow$Threshold voltage}
    Q(x)&=\frac{1}{2}-\frac{1}{2}\text{erf}\left(\frac{x}{\sqrt{2}}\right)\Leftrightarrow\text{erf}\left(\frac{x}{\sqrt{2}}\right)=1-2Q(x)\\
    E_b&=d^2=\int_{-\infty}^\infty|s_1(t)-s_2(t)|^2dt\quad\text{Energy per bit/Distance}\\
    T&=1/R_b\quad\text{$R_b$: Bitrate}\\
    E_b&=PT=P_\text{av}/R_b\quad\text{Energy per bit}\\
    P(\text{W})&=10^{\frac{P(\text{dB})}{10}}\\
    P_\text{RX}(W)&=P_\text{TX}(W)\cdot10^{\frac{P_\text{loss}(\text{dB})}{10}}\quad \text{$P_\text{loss}$ is expressed with negative sign e.g. "-130 dB"}\\
    \text{BER}_\text{MatchedFilter}&=Q\left(\sqrt{\frac{d^2}{2N_0}}\right)=Q\left(\sqrt{\frac{E_b}{2N_0}}\right)\\
    \text{BER}_\text{unipolarNRZ|BASK}&=Q\left(\sqrt{\frac{d^2}{N_0}}\right)=Q\left(\sqrt{\frac{E_b}{N_0}}\right)\\
    \text{BER}_\text{polarNRZ|BPSK}&=Q\left(\sqrt{\frac{2d^2}{N_0}}\right)=Q\left(\sqrt{\frac{2E_b}{N_0}}\right)\\
\end{align*}
$$

<div style="page-break-after: always;"></div>

## Value tables for $\text{erf}(x)$ and $Q(x)$

### $Q(x)$ function

| $x$    | $Q(x)$     | $x$    | $Q(x)$                  | $x$    | $Q(x)$                   | $x$    | $Q(x)$                   |
| ------ | ---------- | ------ | ----------------------- | ------ | ------------------------ | ------ | ------------------------ |
| $0.00$ | $0.5$      | $2.30$ | $0.010724$              | $4.55$ | $2.6823 \times 10^{-6}$  | $6.80$ | $5.231 \times 10^{-12}$  |
| $0.05$ | $0.48006$  | $2.35$ | $0.0093867$             | $4.60$ | $2.1125 \times 10^{-6}$  | $6.85$ | $3.6925 \times 10^{-12}$ |
| $0.10$ | $0.46017$  | $2.40$ | $0.0081975$             | $4.65$ | $1.6597 \times 10^{-6}$  | $6.90$ | $2.6001 \times 10^{-12}$ |
| $0.15$ | $0.44038$  | $2.45$ | $0.0071428$             | $4.70$ | $1.3008 \times 10^{-6}$  | $6.95$ | $1.8264 \times 10^{-12}$ |
| $0.20$ | $0.42074$  | $2.50$ | $0.0062097$             | $4.75$ | $1.0171 \times 10^{-6}$  | $7.00$ | $1.2798 \times 10^{-12}$ |
| $0.25$ | $0.40129$  | $2.55$ | $0.0053861$             | $4.80$ | $7.9333 \times 10^{-7}$  | $7.05$ | $8.9459 \times 10^{-13}$ |
| $0.30$ | $0.38209$  | $2.60$ | $0.0046612$             | $4.85$ | $6.1731 \times 10^{-7}$  | $7.10$ | $6.2378 \times 10^{-13}$ |
| $0.35$ | $0.36317$  | $2.65$ | $0.0040246$             | $4.90$ | $4.7918 \times 10^{-7}$  | $7.15$ | $4.3389 \times 10^{-13}$ |
| $0.40$ | $0.34458$  | $2.70$ | $0.003467$              | $4.95$ | $3.7107 \times 10^{-7}$  | $7.20$ | $3.0106 \times 10^{-13}$ |
| $0.45$ | $0.32636$  | $2.75$ | $0.0029798$             | $5.00$ | $2.8665 \times 10^{-7}$  | $7.25$ | $2.0839 \times 10^{-13}$ |
| $0.50$ | $0.30854$  | $2.80$ | $0.0025551$             | $5.05$ | $2.2091 \times 10^{-7}$  | $7.30$ | $1.4388 \times 10^{-13}$ |
| $0.55$ | $0.29116$  | $2.85$ | $0.002186$              | $5.10$ | $1.6983 \times 10^{-7}$  | $7.35$ | $9.9103 \times 10^{-14}$ |
| $0.60$ | $0.27425$  | $2.90$ | $0.0018658$             | $5.15$ | $1.3024 \times 10^{-7}$  | $7.40$ | $6.8092 \times 10^{-14}$ |
| $0.65$ | $0.25785$  | $2.95$ | $0.0015889$             | $5.20$ | $9.9644 \times 10^{-8}$  | $7.45$ | $4.667 \times 10^{-14}$  |
| $0.70$ | $0.24196$  | $3.00$ | $0.0013499$             | $5.25$ | $7.605 \times 10^{-8}$   | $7.50$ | $3.1909 \times 10^{-14}$ |
| $0.75$ | $0.22663$  | $3.05$ | $0.0011442$             | $5.30$ | $5.7901 \times 10^{-8}$  | $7.55$ | $2.1763 \times 10^{-14}$ |
| $0.80$ | $0.21186$  | $3.10$ | $0.0009676$             | $5.35$ | $4.3977 \times 10^{-8}$  | $7.60$ | $1.4807 \times 10^{-14}$ |
| $0.85$ | $0.19766$  | $3.15$ | $0.00081635$            | $5.40$ | $3.332 \times 10^{-8}$   | $7.65$ | $1.0049 \times 10^{-14}$ |
| $0.90$ | $0.18406$  | $3.20$ | $0.00068714$            | $5.45$ | $2.5185 \times 10^{-8}$  | $7.70$ | $6.8033 \times 10^{-15}$ |
| $0.95$ | $0.17106$  | $3.25$ | $0.00057703$            | $5.50$ | $1.899 \times 10^{-8}$   | $7.75$ | $4.5946 \times 10^{-15}$ |
| $1.00$ | $0.15866$  | $3.30$ | $0.00048342$            | $5.55$ | $1.4283 \times 10^{-8}$  | $7.80$ | $3.0954 \times 10^{-15}$ |
| $1.05$ | $0.14686$  | $3.35$ | $0.00040406$            | $5.60$ | $1.0718 \times 10^{-8}$  | $7.85$ | $2.0802 \times 10^{-15}$ |
| $1.10$ | $0.13567$  | $3.40$ | $0.00033693$            | $5.65$ | $8.0224 \times 10^{-9}$  | $7.90$ | $1.3945 \times 10^{-15}$ |
| $1.15$ | $0.12507$  | $3.45$ | $0.00028029$            | $5.70$ | $5.9904 \times 10^{-3}$  | $7.95$ | $9.3256 \times 10^{-16}$ |
| $1.20$ | $0.11507$  | $3.50$ | $0.00023263$            | $5.75$ | $4.4622 \times 10^{-9}$  | $8.00$ | $6.221 \times 10^{-16}$  |
| $1.25$ | $0.10565$  | $3.55$ | $0.00019262$            | $5.80$ | $3.3157 \times 10^{-9}$  | $8.05$ | $4.1397 \times 10^{-16}$ |
| $1.30$ | $0.0968$   | $3.60$ | $0.00015911$            | $5.85$ | $2.4579 \times 10^{-9}$  | $8.10$ | $2.748 \times 10^{-16}$  |
| $1.35$ | $0.088508$ | $3.65$ | $0.00013112$            | $5.90$ | $1.8175 \times 10^{-9}$  | $8.15$ | $1.8196 \times 10^{-16}$ |
| $1.40$ | $0.080757$ | $3.70$ | $0.0001078$             | $5.95$ | $1.3407 \times 10^{-9}$  | $8.20$ | $1.2019 \times 10^{-16}$ |
| $1.45$ | $0.073529$ | $3.75$ | $8.8417 \times 10^{-5}$ | $6.00$ | $9.8659 \times 10^{-10}$ | $8.25$ | $7.9197 \times 10^{-17}$ |
| $1.50$ | $0.066807$ | $3.80$ | $7.2348 \times 10^{-5}$ | $6.05$ | $7.2423 \times 10^{-10}$ | $8.30$ | $5.2056 \times 10^{-17}$ |
| $1.55$ | $0.060571$ | $3.85$ | $5.9059 \times 10^{-5}$ | $6.10$ | $5.3034 \times 10^{-10}$ | $8.35$ | $3.4131 \times 10^{-17}$ |
| $1.60$ | $0.054799$ | $3.90$ | $4.8096 \times 10^{-5}$ | $6.15$ | $3.8741 \times 10^{-10}$ | $8.40$ | $2.2324 \times 10^{-17}$ |
| $1.65$ | $0.049471$ | $3.95$ | $3.9076 \times 10^{-5}$ | $6.20$ | $2.8232 \times 10^{-10}$ | $8.45$ | $1.4565 \times 10^{-17}$ |
| $1.70$ | $0.044565$ | $4.00$ | $3.1671 \times 10^{-5}$ | $6.25$ | $2.0523 \times 10^{-10}$ | $8.50$ | $9.4795 \times 10^{-18}$ |
| $1.75$ | $0.040059$ | $4.05$ | $2.5609 \times 10^{-5}$ | $6.30$ | $1.4882 \times 10^{-10}$ | $8.55$ | $6.1544 \times 10^{-18}$ |
| $1.80$ | $0.03593$  | $4.10$ | $2.0658 \times 10^{-5}$ | $6.35$ | $1.0766 \times 10^{-10}$ | $8.60$ | $3.9858 \times 10^{-18}$ |
| $1.85$ | $0.032157$ | $4.15$ | $1.6624 \times 10^{-5}$ | $6.40$ | $7.7688 \times 10^{-11}$ | $8.65$ | $2.575 \times 10^{-18}$  |
| $1.90$ | $0.028717$ | $4.20$ | $1.3346 \times 10^{-5}$ | $6.45$ | $5.5925 \times 10^{-11}$ | $8.70$ | $1.6594 \times 10^{-18}$ |
| $1.95$ | $0.025588$ | $4.25$ | $1.0689 \times 10^{-5}$ | $6.50$ | $4.016 \times 10^{-11}$  | $8.75$ | $1.0668 \times 10^{-18}$ |
| $2.00$ | $0.02275$  | $4.30$ | $8.5399 \times 10^{-6}$ | $6.55$ | $2.8769 \times 10^{-11}$ | $8.80$ | $6.8408 \times 10^{-19}$ |
| $2.05$ | $0.020182$ | $4.35$ | $6.8069 \times 10^{-6}$ | $6.60$ | $2.0558 \times 10^{-11}$ | $8.85$ | $4.376 \times 10^{-19}$  |
| $2.10$ | $0.017864$ | $4.40$ | $5.4125 \times 10^{-6}$ | $6.65$ | $1.4655 \times 10^{-11}$ | $8.90$ | $2.7923 \times 10^{-19}$ |
| $2.15$ | $0.015778$ | $4.45$ | $4.2935 \times 10^{-6}$ | $6.70$ | $1.0421 \times 10^{-11}$ | $8.95$ | $1.7774 \times 10^{-19}$ |
| $2.20$ | $0.013903$ | $4.50$ | $3.3977 \times 10^{-6}$ | $6.75$ | $7.3923 \times 10^{-12}$ | $9.00$ | $1.1286 \times 10^{-19}$ |
| $2.25$ | $0.012224$ |        |                         |        |                          |        |                          |

Adapted from table 6.1 M F Mesiya - Contemporary Communication Systems

### $\text{erf}(x)$ function

| $x$    | $\text{erf}(x)$ | $x$    | $\text{erf}(x)$ | $x$    | $\text{erf}(x)$ |
| ------ | --------------- | ------ | --------------- | ------ | --------------- |
| $0.00$ | $0.00000$       | $0.75$ | $0.71116$       | $1.50$ | $0.96611$       |
| $0.05$ | $0.05637$       | $0.80$ | $0.74210$       | $1.55$ | $0.97162$       |
| $0.10$ | $0.11246$       | $0.85$ | $0.77067$       | $1.60$ | $0.97635$       |
| $0.15$ | $0.16800$       | $0.90$ | $0.79691$       | $1.65$ | $0.98038$       |
| $0.20$ | $0.22270$       | $0.95$ | $0.82089$       | $1.70$ | $0.98379$       |
| $0.25$ | $0.27633$       | $1.00$ | $0.84270$       | $1.75$ | $0.98667$       |
| $0.30$ | $0.32863$       | $1.05$ | $0.86244$       | $1.80$ | $0.98909$       |
| $0.35$ | $0.37938$       | $1.10$ | $0.88021$       | $1.85$ | $0.99111$       |
| $0.40$ | $0.42839$       | $1.15$ | $0.89612$       | $1.90$ | $0.99279$       |
| $0.45$ | $0.47548$       | $1.20$ | $0.91031$       | $1.95$ | $0.99418$       |
| $0.50$ | $0.52050$       | $1.25$ | $0.92290$       | $2.00$ | $0.99532$       |
| $0.55$ | $0.56332$       | $1.30$ | $0.93401$       | $2.50$ | $0.99959$       |
| $0.60$ | $0.60386$       | $1.35$ | $0.94376$       | $3.00$ | $0.99998$       |
| $0.65$ | $0.64203$       | $1.40$ | $0.95229$       | $3.30$ | $0.999998$\*\*  |
| $0.70$ | $0.67780$       | $1.45$ | $0.95970$       |        |                 |

\*\*The value of $\text{erf}(3.30)$ should be $\approx0.999997$ instead, but this value is quoted in the formula table.

<div style="page-break-after: always;"></div>

### Receiver output shit

$$
\begin{align*}
    r_o(t)&=\begin{cases}
        s_{o1}(t)+n_o(t) & \text{code 1}\\
        s_{o2}(t)+n_o(t) & \text{code 0}\\
    \end{cases}\\
    n&: \text{AWGN with }\sigma_o^2\\
\end{align*}
$$

<!--
$$
\begin{align*}
    G_x(f)
\end{align*}
$$ -->

## ISI, channel model

### Nyquist criterion for zero ISI

TODO:

### Nomenclature

$$
\begin{align*}
    D&\rightarrow\text{Symbol Rate, Max. Signalling Rate}\\
    T&\rightarrow\text{Symbol Duration}\\
    M&\rightarrow\text{Symbol set size}\\
    W&\rightarrow\text{Bandwidth}\\
\end{align*}
$$

### Raised cosine (RC) pulse

![Raised cosine pulse](/assets/img/2024-10-29-Idiots-guide-to-ELEC/RC.drawio.svg)

$$
0\leq\alpha\leq1
$$

⚠ NOTE might not be safe to assume $T'=T$, if you can solve the question without $T$ then use that method.

To solve this type of question:

1. Use the formula for $D$ below
2. Consult the BER table below to get the BER which relates the noise of the channel $N_0$ to $E_b$ and to $R_b$.

| Linear modulation ($M$-PSK, $M$-QAM)                | NRZ unipolar encoding                              |
| --------------------------------------------------- | -------------------------------------------------- |
| $W=B_\text{\color{green}abs-abs}$                   | $W=B_\text{\color{green}abs}$                      |
| $W=B_\text{abs-abs}=\frac{1+\alpha}{T}=(1+\alpha)D$ | $W=B_\text{abs}=\frac{1+\alpha}{2T}=(1+\alpha)D/2$ |
| $D=\frac{W\text{ symbol/s}}{1+\alpha}$              | $D=\frac{2W\text{ symbol/s}}{1+\alpha}$            |

#### Symbol set size $M$

$$
\begin{align*}
    D\text{ symbol/s}&=\frac{2W\text{ Hz}}{1+\alpha}\\
    R_b\text{ bit/s}&=(D\text{ symbol/s})\times(k\text{ bit/symbol})\\
    M\text{ symbol/set}&=2^k\\
    E_b&=PT=P_\text{av}/R_b\quad\text{Energy per bit}\\
\end{align*}
$$

### Nyquist stuff

#### TODO: Condition for 0 ISI

$$
P_r(kT)=\begin{cases}
    1 & k=0\\
    0 & k\neq0
\end{cases}
$$

#### Other

$$
\begin{align*}
    \text{Excess BW}&=B_\text{abs}-B_\text{Nyquist}=\frac{1+\alpha}{2T}-\frac{1}{2T}=\frac{\alpha}{2T}\quad\text{FOR NRZ (Use correct $B_\text{abs}$)}\\
    \alpha&=\frac{\text{Excess BW}}{B_\text{Nyquist}}=\frac{B_\text{abs}-B_\text{Nyquist}}{B_\text{Nyquist}}\\
    T&=1/D
\end{align*}
$$

### Table of bandpass signalling and BER

| **Binary Bandpass Signaling**     | **$B_\text{null-null}$ (Hz)**    | **$B_\text{abs-abs}\color{red}=2B_\text{abs}$ (Hz)** | **BER with Coherent Detection**                                                                                      | **BER with Noncoherent Detection**                                                                |
| --------------------------------- | -------------------------------- | ---------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| ASK, unipolar NRZ                 | $2R_b$                           | $R_b (1 + \alpha)$                                   | $Q\left( \sqrt{E_b / N_0} \right)$                                                                                   | $0.5\exp(-E_b / (2N_0))$                                                                          |
| BPSK                              | $2R_b$                           | $R_b (1 + \alpha)$                                   | $Q\left( \sqrt{2E_b / N_0} \right)$                                                                                  | Requires coherent detection                                                                       |
| Sunde's FSK                       | $3R_b$                           |                                                      | $Q\left( \sqrt{E_b / N_0} \right)$                                                                                   | $0.5\exp(-E_b / (2N_0))$                                                                          |
| DBPSK, $M$-ary Bandpass Signaling | $2R_b$                           | $R_b (1 + \alpha)$                                   |                                                                                                                      | $0.5\exp(-E_b / N_0)$                                                                             |
| QPSK/OQPSK (**$M=4$, PSK**)       | $R_b$                            | $\frac{R_b (1 + \alpha)}{2}$                         | $Q\left( \sqrt{2E_b / N_0} \right)$                                                                                  | Requires coherent detection                                                                       |
| MSK                               | $1.5R_b$                         | $\frac{3R_b (1 + \alpha)}{4}$                        | $Q\left( \sqrt{2E_b / N_0} \right)$                                                                                  | Requires coherent detection                                                                       |
| $M$-PSK ($M > 4$)                 | $2R_b / \log_2 M$                | $\frac{R_b (1 + \alpha)}{\log_2 M}$                  | $\frac{2}{\log_2 M} Q\left( \sqrt{2 \log_2 M \sin^2 \left( \pi / M \right) E_b / N_0} \right)$                       | Requires coherent detection                                                                       |
| $M$-DPSK ($M > 4$)                | $2R_b / \log_2 M$                | $\frac{R_b (1 + \alpha)}{2 \log_2 M}$                |                                                                                                                      | $\frac{2}{\log_2 M} Q\left( \sqrt{4 \log_2 M \sin^2 \left( \pi / (2M) \right) E_b / N_0} \right)$ |
| $M$-QAM (Square constellation)    | $2R_b / \log_2 M$                | $\frac{R_b (1 + \alpha)}{\log_2 M}$                  | $\frac{4}{\log_2 M} \left( 1 - \frac{1}{\sqrt{M}} \right) Q\left( \sqrt{\frac{3 \log_2 M}{M - 1} E_b / N_0} \right)$ | Requires coherent detection                                                                       |
| $M$-FSK Coherent                  | $\frac{(M + 3) R_b}{2 \log_2 M}$ |                                                      | $\frac{M - 1}{\log_2 M} Q\left( \sqrt{(\log_2 M) E_b / N_0} \right)$                                                 |                                                                                                   |
| Noncoherent                       | $2M R_b / \log_2 M$              |                                                      |                                                                                                                      | $\frac{M - 1}{2 \log_2 M} 0.5\exp({-(\log_2 M) E_b / 2N_0})$                                      |

Adapted from table 11.4 M F Mesiya - Contemporary Communication Systems

### PSD of modulated signals

| Modulation | $G_x(f)$                                                                                          |
| ---------- | ------------------------------------------------------------------------------------------------- |
| Quadrature | $\color{red}\frac{ {A_c}^2}{4}[G_I(f-f_c)+G_I(f+f_c)+G_Q(f-f_c)+G_Q(f+f_c)]$                      |
| Linear     | $\color{red}\frac{\|V(f)\|^2}{2}\sum_{l=-\infty}^\infty R(l)\exp(-j2\pi l f T)\quad\text{What??}$ |

### Symbol error probability

- Minimum distance between any two point
- Different from bit error since a symbol can contain multiple bits

## Information theory

### Entropy for discrete random variables

$$
\begin{align*}
    H(x) &\geq 0\\
    H(x) &= -\sum_{x_i\in A_x} p_X(x_i) \log_2(p_X(x_i))\\
    H(x,y) &= -\sum_{x_i\in A_x}\sum_{y_i\in A_y} p_{XY}(x_i,y_i)\log_2(p_{XY}(x_i,y_i)) \quad\text{Joint entropy}\\
    H(x,y) &= H(x)+H(y) \quad\text{Joint entropy if $x$ and $y$ independent}\\
    H(x|y=y_j) &= -\sum_{x_i\in A_x} p_X(x_i|y=y_j) \log_2(p_X(x_i|y=y_j)) \quad\text{Conditional entropy}\\
    H(x|y) &= -\sum_{y_j\in A_y} p_Y(y_j) H(x|y=y_j) \quad\text{Average conditional entropy, equivocation}\\
    H(x|y) &= -\sum_{x_i\in A_x}\sum_{y_i\in A_y} p_X(x_i,y_j) \log_2(p_X(x_i|y=y_j))\\
    H(x|y) &= H(x,y)-H(y)\\
    H(x,y) &= H(x) + H(y|x) = H(y) + H(x|y)\\
\end{align*}
$$

Entropy is **maximized** when all have an equal probability.

### Differential entropy for continuous random variables

TODO: Cut out if not required

$$
\begin{align*}
    h(x) &= -\int_\mathbb{R}f_X(x)\log_2(f_X(x))dx
\end{align*}
$$

### Mutual information

Amount of entropy decrease of $x$ after observation by $y$.

$$
\begin{align*}
    I(x;y) &= H(x)-H(x|y)=H(y)-H(y|x)\\
\end{align*}
$$

### Channel model

Vertical, $x$: input\
Horizontal, $y$: output

$$
\mathbf{P}=\left[\begin{matrix}
    p_{11} & p_{12} &\dots & p_{1N}\\
    p_{21} & p_{22} &\dots & p_{2N}\\
    \vdots & \vdots &\ddots & \vdots\\
    p_{M1} & p_{M2} &\dots & p_{MN}\\
\end{matrix}\right]
$$

$$
\begin{array}{c|cccc}
    P(y_j|x_i)& y_1 & y_2 & \dots & y_N \\\hline
    x_1 & p_{11} & p_{12} & \dots & p_{1N} \\
    x_2 & p_{21} & p_{22} & \dots & p_{2N} \\
    \vdots & \vdots & \vdots & \ddots & \vdots \\
    x_M & p_{M1} & p_{M2} & \dots & p_{MN} \\
\end{array}
$$

Input has probability distribution $p_X(a_i)=P(X=a_i)$

Channel maps alphabet $`\{a_1,\dots,a_M\} \to \{b_1,\dots,b_N\}`$

Output has probabiltiy distribution $p_Y(b_j)=P(y=b_j)$

$$
\begin{align*}
    p_Y(b_j) &= \sum_{i=1}^{M}P[x=a_i,y=b_j]\quad 1\leq j\leq N \\
        &= \sum_{i=1}^{M}P[X=a_i]P[Y=b_j|X=a_i]\\
       [\begin{matrix}p_Y(b_0)&p_Y(b_1)&\dots&p_Y(b_j)\end{matrix}] &= [\begin{matrix}p_X(a_0)&p_X(a_1)&\dots&p_X(a_i)\end{matrix}]\times\mathbf{P}
\end{align*}
$$

#### Fast procedure to calculate $I(y;x)$

$$
\begin{align*}
    &\text{1. Find }H(x)\\
    &\text{2. Find }[\begin{matrix}p_Y(b_0)&p_Y(b_1)&\dots&p_Y(b_j)\end{matrix}] = [\begin{matrix}p_X(a_0)&p_X(a_1)&\dots&p_X(a_i)\end{matrix}]\times\mathbf{P}\\
    &\text{3. Multiply each row in $\textbf{P}$ by $p_X(a_i)$ since $p_{XY}(x_i,y_i)=P(y_i|x_i)P(x_i)$}\\
    &\text{4. Find $H(x,y)$ using each element from (3.)}\\
    &\text{5. Find }H(x|y)=H(x,y)-H(y)\\
    &\text{6. Find }I(y;x)=H(x)-H(x|y)\\
\end{align*}
$$

### Channel types

| Type              | Definition                                                                                                                                            |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| Symmetric channel | Every row is a permutation of every other row, Every column is a permutation of every other column. $\text{Symmetric}\implies\text{Weakly symmetric}$ |
| Weakly symmetric  | Every row is a permutation of every other row, Every column has the same sum                                                                          |

#### Channel capacity of weakly symmetric channel

$$
\begin{align*}
    C &\to\text{Channel capacity (bits/channels used)}\\
    N &\to\text{Output alphabet size}\\
    \mathbf{p} &\to\text{Probability vector, any row of the transition matrix}\\
    C &= \log_2(N)-H(\mathbf{p})\quad\text{Capacity for weakly symmetric and symmetric channels}\\
    R &< C \text{ for error-free transmission}
\end{align*}
$$

#### Channel capacity of an AWGN channel

$$
y_i=x_i+n_i\quad n_i\thicksim N(0,N_0/2)
$$

$$
C=\frac{1}{2}\log_2\left(1+\frac{P_\text{av}}{N_0/2}\right)
$$

#### Channel capacity of a bandwidth AWGN channel

Note: Define XOR ($\oplus$) as exclusive OR, or modulo-2 addition.

$$
\begin{align*}
    P_s&\to\text{Bandwidth limited average power}\\
    y_i&=\text{bandpass}_W(x_i)+n_i\quad n_i\thicksim N(0,N_0/2)\\
    C&=W\log_2\left(1+\frac{P_s}{N_0 W}\right)\\
    C&=W\log_2(1+\text{SNR})\quad\text{SNR}=P_s/(N_0 W)
\end{align*}
$$

## Channel code

|                  |                                   |                                                                                                                              |
| ---------------- | --------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Hamming weight   | $w_H(x)$                          | Number of `'1'` in codeword $x$                                                                                              |
| Hamming distance | $d_H(x_1,x_2)=w_H(x_1\oplus x_2)$ | Number of different bits between codewords $x_1$ and $x_2$ which is the hamming weight of the XOR of the two codes.          |
| Minimum distance | $d_\text{min}$                    | **IMPORTANT**: $x\neq\textbf{0}$, excludes weight of all-zero codeword. For a linear block code, $d_\text{min}=w_\text{min}$ |

### Linear block code

Code is $(n,k)$

$n$ is the width of a codeword

$2^k$ codewords

A linear block code must be a subspace and satisfy both:

1. Zero vector must be present at least once
2. The XOR of any codeword pair in the code must result in a codeword that is already present in the code table.

For a linear block code, $d_\text{min}=w_\text{min}$

### Code generation

Each generator vector is a binary string of size $n$. There are $k$ generator vectors in $\mathbf{G}$.

$$
\begin{align*}
\mathbf{g}_i&=[\begin{matrix}
    g_{i,0}& \dots & g_{i,n-2} & g_{i,n-1}
\end{matrix}]\\
\color{darkgray}\mathbf{g}_0&\color{darkgray}=[1010]\quad\text{Example for $n=4$}\\
\mathbf{G}&=\left[\begin{matrix}
    \mathbf{g}_0\\
    \mathbf{g}_1\\
    \vdots\\
    \mathbf{g}_{k-1}\\
\end{matrix}\right]=\left[\begin{matrix}
    g_{0,0}& \dots & g_{0,n-2} & g_{0,n-1}\\
    g_{1,0}& \dots & g_{1,n-2} & g_{1,n-1}\\
    \vdots & \ddots & \vdots & \vdots\\
    g_{k-1,0}& \dots & g_{k-1,n-2} & g_{k-1,n-1}\\
\end{matrix}\right]
\end{align*}
$$

A message block $\mathbf{m}$ is coded as $\mathbf{x}$ using the generation codewords in $\mathbf{G}$:

$$
\begin{align*}
\mathbf{m}&=[\begin{matrix}
    m_{0}& \dots & m_{n-2} & m_{k-1}
\end{matrix}]\\
\color{darkgray}\mathbf{m}&\color{darkgray}=[101001]\quad\text{Example for $k=6$}\\
\mathbf{x} &= \mathbf{m}\mathbf{G}=m_0\mathbf{g}_0+m_1\mathbf{g}_1+\dots+m_{k-1}\mathbf{g}_{k-1}
\end{align*}
$$

### Systemic linear block code

Contains $k$ message bits (Copy $\mathbf{m}$ as-is) and $(n-k)$ parity bits after the message bits.

$$
\begin{align*}
\mathbf{G}&=\begin{array}{c|c}[\mathbf{I}_k & \mathbf{P}]\end{array}=\left[
    \begin{array}{c|c}
    \begin{matrix}
    1 & 0 & \dots & 0\\
    0 & 1 & \dots & 0\\
    \vdots & \vdots & \ddots & \vdots\\
    0& 0 & \dots & 1\\
\end{matrix}
&
\begin{matrix}
    p_{0,0}& \dots & p_{0,n-2} & p_{0,n-1}\\
    p_{1,0}& \dots & p_{1,n-2} & p_{1,n-1}\\
    \vdots & \ddots & \vdots & \vdots\\
    p_{k-1,0}& \dots & p_{k-1,n-2} & p_{k-1,n-1}\\
\end{matrix}\end{array}\right]\\
\mathbf{m}&=[\begin{matrix}
    m_{0}& \dots & m_{n-2} & m_{k-1}
\end{matrix}]\\
\mathbf{x} &= \mathbf{m}\mathbf{G}= \mathbf{m} \begin{array}{c|c}[\mathbf{I}_k & \mathbf{P}]\end{array}=\begin{array}{c|c}[\mathbf{mI}_k & \mathbf{mP}]\end{array}=\begin{array}{c|c}[\mathbf{m} & \mathbf{b}]\end{array}\\
\mathbf{b} &= \mathbf{m}\mathbf{P}\quad\text{Parity bits of $\mathbf{x}$}
\end{align*}
$$

#### Parity check matrix $\mathbf{H}$

Transpose $\mathbf{P}$ for the parity check matrix

$$
\begin{align*}
\mathbf{H}&=\begin{array}{c|c}[\mathbf{P}^\text{T} & \mathbf{I}_{n-k}]\end{array}\\
&=\left[
    \begin{array}{c|c}
    \begin{matrix}
        {\textbf{p}_0}^\text{T} & {\textbf{p}_1}^\text{T} & \dots & {\textbf{p}_{k-1}}^\text{T}
    \end{matrix}
    &
    \mathbf{I}_{n-k}\end{array}\right]\\
&=\left[
    \begin{array}{c|c}
    \begin{matrix}
        p_{0,0}& \dots & p_{0,k-2} & p_{0,k-1}\\
        p_{1,0}& \dots & p_{1,k-2} & p_{1,k-1}\\
        \vdots & \ddots & \vdots & \vdots\\
        p_{n-1,0}& \dots & p_{n-1,k-2} & p_{n-1,k-1}\\
    \end{matrix}
    &
    \begin{matrix}
    1 & 0 & \dots & 0\\
    0 & 1 & \dots & 0\\
    \vdots & \vdots & \ddots & \vdots\\
    0& 0 & \dots & 1\\
\end{matrix}\end{array}\right]\\
\mathbf{xH}^\text{T}&=\mathbf{0}\implies\text{Codeword is valid}
\end{align*}
$$

#### Procedure to find parity check matrix from list of codewords

1. From the number of codewords, find $k=\log_2(N)$
2. Partition codewords into $k$ information bits and remaining bits into $n-k$ parity bits. The information bits should be a simple counter (?).
3. Express parity bits as a linear combination of information bits
4. Put coefficients into $\textbf{P}$ matrix and find $\textbf{H}$

Example:

$$
\begin{array}{cccc}
    x_1 & x_2 & x_3 & x_4 & x_5 \\\hline
    \color{magenta}1&\color{magenta}0&1&1&0\\
    \color{magenta}0&\color{magenta}1&1&1&1\\
    \color{magenta}0&\color{magenta}0&0&0&0\\
    \color{magenta}1&\color{magenta}1&0&0&1\\
\end{array}
$$

Set $x_1,x_2$ as information bits. Express $x_3,x_4,x_5$ in terms of $x_1,x_2$.

$$
\begin{align*}
\begin{aligned}
    x_3 &= x_1\oplus x_2\\
    x_4 &= x_1\oplus x_2\\
    x_5 &= x_2\\
\end{aligned}
\implies\textbf{P}&=
\begin{array}{c|cc}
    & x_1 & x_2 \\\hline
    x_3&1&1&\\
    x_4&1&1&\\
    x_5&0&1&\\
\end{array}\\
\textbf{H}&=\left[
    \begin{array}{c|c}
    \begin{matrix}
    1&1\\
    1&1\\
    0&1\\
    \end{matrix}
    &
    \begin{matrix}
    1 & 0 & 0\\
    0 & 1 & 0\\
    0 & 0 & 1\\
\end{matrix}\end{array}\right]
\end{align*}
$$

#### Error detection and correction

**Detection** of $s$ errors: $d_\text{min}\geq s+1$

**Correction** of $u$ errors: $d_\text{min}\geq 2u+1$

## CHECKLIST

- Transfer function in complex envelope form $\tilde{h}(t)$ should be divided by two.
- Convolutions: do not forget width when using graphical method
- todo: add more items to check
