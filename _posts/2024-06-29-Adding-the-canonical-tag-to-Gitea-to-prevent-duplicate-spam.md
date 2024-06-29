---
title: Adding the canonical tag to Gitea to prevent duplicate spam
author: peter
date: 2024-06-29 02:55:28 +0800
categories: [SelfHosting] # Blogging | Electronics | Programming | Mechanical
tags: [tip] # systems | embedded | rf | microwave | electronics | solidworks | automation
# image: assets/img/2024-06-29-Adding-the-canonical/preview.png
---

Gitea doesn't include the canonical tag in their pages, leading to a lot of duplicate pages being indexed by Google. Each page being indexed has a different sorting option, or other superflous parameter.

> Duplicate without user-selected canonical
>
> These pages aren't indexed or served on Google

Not sure if having a lot of these errors affects SEO but I've noticed a lot of my real pages are being discovered but not indexed by Google.

![Search console page getting spammed with duplicate urls](/assets/img/2024-06-29-Adding-the-canonical/search%20console.png)

To fix this,

1. Create a `custom/templates/base/` directory under your Gitea installation. In my case it is in `/var/lib/gitea/custom/templates/base/`.
2. CD to the base directory and run `wget https://raw.githubusercontent.com/go-gitea/gitea/main/templates/base/head.tmpl`. Make sure your Gitea is updated to the latest version, or choose the right version instead of the `main` branch.
3. Modify `head.tmpl`: Add this line somewhere in the `<head>` section:

<!-- {% raw %} -->

```html
<link rel="canonical" href="{{AppUrl}}{{if $.Link}}{{slice $.Link 1}}{{end}}" />
```

<!-- {% endraw %} -->

4. Restart the gitea service
