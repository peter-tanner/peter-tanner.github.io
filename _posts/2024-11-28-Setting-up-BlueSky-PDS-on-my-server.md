---
title: Setting up BlueSky PDS on my server
author: peter
date: 2024-11-28 20:29:11 +0800
categories: [SelfHosting]    # 0-2 categories. Blogging | Electronics | Programming | Mechanical | SelfHosting | Guides | University
tags: [selfhosting,bluesky,pds]   # 0-\infty. systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-11-28-Setting-up-BlueSky-P/preview.png
---

I've decided to join Bluesky, purely because I like how the federation system works and being able to keep my own data on my own server.

My setup uses NGINX as a reverse proxy since that is what I am currently using and the BlueSky PDS is hosted on a docker instance.

I followed [this guide](https://cprimozic.net/notes/posts/notes-on-self-hosting-bluesky-pds-alongside-other-services/). Some things are missing from the guide, for example creating the initial `pds.env` file. You can use the installation script, but I didn't want to install caddy or any other unused packages, so I [modified the script and have put it on GitHub gist here](https://gist.github.com/peter-tanner/1ede26badfd7759d38dcd46d155ecbd5).

For the NGINX configuration, put your routes under `ssl`:

```nginx
server {
        listen 443 ssl;
        server_name petertanner.dev;

        ssl_certificate /etc/letsencrypt/live/petertanner.dev/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/petertanner.dev/privkey.pem;

        location /xrpc {
                proxy_pass http://[DOCKER IP ADDRESS]:6010;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header Host $host;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

                # WebSocket support
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
        }

        location /.well-known/atproto-did {
                default_type text/plain;
                return 200 "did:plc:[DID]";
        }

        # Note that I redirect https://petertanner.dev -> https://www.petertanner.dev for my website (anything other than the bluesky related endpoints).
        location / {
                return 301 $scheme://www.petertanner.dev$request_uri;
        }
}
```

I hard coded the `atproto-did` because I was having issues with invalid handle and also because the PDS returned `User not found` for some reason. This is probably not good practice but it worked.

Note that the guide puts the Bluesky data directory under `/opt/pds` instead of `/pds`

To use `pdsadmin`, simply copy the `pdsadmin.sh` script from the `pds` repository and make it executable. When using it with the data directory under `/opt/pds`, either modify the script or call it as follows: `PDS_ENV_FILE=/opt/pds/pds.env ./pdsadmin.sh [...]`

As stated in the guide, I had to first create an account on a "subdomain" (`temp.petertanner.dev`) and then change it in the account settings once logged in. Using this [service](https://bsky-debug.app/handle) I checked that the verification worked. However, even with both HTTP and DNS verified, I still got the error `Failed to verify handle. Please try again.` for both methods. I checked in the debug console, and it looked like bad requests were being sent to my server (400).

I did some more digging and found [this answer](https://github.com/bluesky-social/atproto/discussions/2909#discussioncomment-11157373). Using the `goat` tool worked great, and it resolved both the issue of not being able to change my handle and the invalid handle issues.

```bash
goat account login -u did:plc:<did> -p <password>
goat account update-handle <domain>
```

You can find me on Bluesky at [@petertanner.dev](https://bsky.app/profile/petertanner.dev)
