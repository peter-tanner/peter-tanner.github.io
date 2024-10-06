---
title: Buggy shell extensions causing Windows explorer to hang
author: peter
date: 2024-10-05 22:44:41 +0800
categories: [Blogging] # Blogging | Electronics | Programming | Mechanical | SelfHosting
tags: [getting started] # systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-10-05-Buggy-shell-extensio/preview.png
---

If you are having issues where right-clicking causes explorer to lock up/hang for a painfully long amount of time (~30 seconds) it could be due to a buggy shell extension as in my case.

I downloaded [ShellExView](https://www.nirsoft.net/utils/shexview.html) which is a small program that can disable/enable shell extensions.

I went and checked `Options > Hide all Microsoft extensions` since I assumed all OS extensions worked fine.

I then went to `Options > Filter by extension type > Context Menu` since this type is what is used in Explorer.

Then I simply binary searched my way to finding the buggy shell extension (split the list of extensions in half, see which half causes the error. Then split that half of the list in half again and find which half causes the error. Repeat until one extension is found).

![Shellexview](/assets/img/2024-10-05-Buggy-shell-extensio/shellexview.png)

Looks like the issue is "DriveFS ContextMenu Handler" which is used by Google Drive. For whatever reason this is causing issues. Disabling this extension resolved the issue.

For reference, at the time of writing I haven't used Google Drive client in a while, at least since my old work. Looks like something has gone wrong with my install since starting Google Drive doesn't create the system tray icon/widget, so I guess if the client is having issues the shell extension is probably timing out when it cannot connect to the client is my guess.
