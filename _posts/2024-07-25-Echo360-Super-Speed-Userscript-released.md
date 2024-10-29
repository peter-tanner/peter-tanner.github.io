---
title: Echo360 Super Speed Userscript released!
author: peter
date: 2024-07-25 02:35:04 +0800
categories: [Programming, University] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [extension, userscript, browser, echo360] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
image: /assets/img/2024-07-25-Echo360-Super-Speed-/preview.png
---

I've just made a userscript which allows you to set the speed of the Echo360 lecture player over the 2x maximum. By default, the script lets you set the player speed to 4x and 3x in addition to the default set of speeds, but you may customize the dropdown to have any speed you want (subject to browser limits).

![superspeed](/assets/img/2024-07-25-Echo360-Super-Speed-/superspeed.png)

**Install the script from [GitHub](https://github.com/peter-tanner/Echo360-Super-Speed/raw/master/echo360-super-speed.user.js) or [Greasyfork](https://greasyfork.org/en/scripts/501694-echo360-super-speed)**

Note that you need to be using firefox since this script uses the `beforescriptexecute` hook. If there's a way to do this without the hook do get in touch, but since I use firefox and this looks like the easiest way to do the script, this is what I've used.

In short, the script works by intercepting the `echoPlayerV2FullApp.react-bundle.js` file, modifying it to contain the new list of speeds, then calls the modified code by putting the modified code in a script tag in the head.

## Adding your own speeds

Open the userscript file, then modify the `selected_speeds` and/or `speed_hotkey_increment` constants which are in the `USER CUSTOMIZATION` section.

For example, if I wanted only 4x, 3x and 2x options, I can replace the `selected_speeds` constant with the following:

```js
const selected_speeds = [4, 3, 2];
```

⚠ Note that there is a browser set limit of 16x, and speeds above 4x are muted, according to [these constants in the firefox source code](https://searchfox.org/mozilla-central/rev/f1c881ba5603410dacbe52874053af38bd825c3b/dom/html/HTMLMediaElement.cpp#179-183)

## Current issues

- When setting `selected_speeds` to a list of speeds which does not include 1x, the player by default loads with 1x speed when the page is loaded. Once the speed is changed manually by clicking on a speed from the dropdown this is not an issue anymore, but it would be nice if the default speed was valid.
