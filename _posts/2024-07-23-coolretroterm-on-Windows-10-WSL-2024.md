---
title: cool-retro-term on Windows 10 WSL 2024
author: peter
date: 2024-07-23 18:21:42 +0800
categories: [Blogging] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [getting started] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
image: assets/img/2024-07-23-coolretroterm-on-Win/working.png
---

Install Xserver on Windows side:

I will use chocolatey to install it but you may also download X server from the sourceforge page

Run this command in an administrator powershell prompt to install

```powershell
choco install vcxsrv
```

In WSL Ubuntu, install the `cool-retro-term` package using `apt`:

```bash
sudo apt install cool-retro-term
```

Add this to your `.bashrc` file so WSL knows the address of the Xserver

I found this method to set `DISPLAY` to be the most robust as it works even when your `.wslconf` doesn't have `generateResolvConf=true` and when you are using a custom DNS server. The previous method I was using to set `DISPLAY` would use the wrong address with my setup.

```bash
export DISPLAY=$(ip route list default | awk '{print $3}'):0
```

Now when you run `cool-retro-term` you should get a window!

Making a shortcut to start `cool-retro-term` is annoying since if you try to run it directly from a commandline in Windows, you will likely get this error (I also get this error when specifying the `DISPLAY` parameter in the commandline):

```
C:\Users\Peter>bash -c cool-retro-term
qt.qpa.xcb: could not connect to display
qt.qpa.plugin: Could not load the Qt platform plugin "xcb" in "" even though it was found.
This application failed to start because no Qt platform plugin could be initialized. Reinstalling the application may fix this problem.

Available platform plugins are: eglfs, linuxfb, minimal, minimalegl, offscreen, vnc, xcb.

```

This will work, I think because it opens a login shell.

```bat
bash -c "bash --rcfile <(echo '. ~/.bashrc; cool-retro-term; exit')"
```

Now wrap it in a `vbs` script to hide the `cmd.exe` window from appearing:

```vbs
Set objShell = WScript.CreateObject("WScript.Shell")
objShell.Run "%comspec% /c start /B """" bash -c ""bash --rcfile <(echo '. ~/.bashrc; cool-retro-term -p DEFAULT_PROFILE; exit')""", 0 'Hide
```

And call this from a shortcut's target field:

```
C:\Windows\System32\wscript.exe "C:\YOUR_PATH_HERE\cool-retro-term.vbs"
```

Congratulations, when you click the shortcut you should get a cool-retro-term window without any other windows being spawned!

![Hooray!](/assets/img/2024-07-23-coolretroterm-on-Win/working.png)
