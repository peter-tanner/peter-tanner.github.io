---
title: Chinese ZHONGKEWEI ATGM* GNSS modules comparison
author: peter
date: 2024-11-25 04:00:36 +0800
categories: [Electronics]    # 0-2 categories. Blogging | Electronics | Programming | Mechanical | SelfHosting | Guides | University
tags: [gps,gnss,cheap,comparison,ublox]   # 0-\infty. systems | embedded | rf | microwave | electronics | solidworks | automation | tip
# image: assets/img/2024-11-25-Chinese-ZHONGKEWEI-A/preview.png
---

The ZHONGKEWEI ATGM* series of GNSS modules appear to emulate the popular u-blox NEO and MAX series and are (almost) pin compatible.

| Model                | GPS | BDS | GLONASS | Galileo | QZSS | VCC [V] | Interfaces           | Internal SOC | TTFF [s] | Maximum output rate [Hz] | CEP50 [m] | Cost [AUD] |
| -------------------- | --- | --- | ------- | ------- | ---- | ------- | -------------------- | ------------ | -------- | ------------------------ | --------- | ---------- |
| ATGM332D-6N-74       | ✅   | ✅   | ✅       | ✅       | ✅    | 2.7-3.6 | UART,I2C,SPI         | AT6668       | 23       | 10                       | 1.5       | 5.3287     |
| ATGM336H-6N-74       | ✅   | ✅   | ✅       | ✅       | ✅    | 2.7-3.6 | UART,I2C,SPI         | AT6668       | 23       | 10                       | 1.5       | 5.3171     |
| ATGM336H-5N31        | ✅   | ✅   | ❌       | ❌       | ❌    | 2.7-3.6 | UART1,UART2          | AT6558       | 32       | 10                       | 2.5       | 4.6255     |
| ATGM332D-5N31        | ✅   | ✅   | ❌       | ❌       | ❌    | 2.7-3.6 | UART1,UART2          | AT6558       | 32       | 10                       | 2.5       | 4.1224     |
| ATGM332D-5NR32       | ✅   | ✅   | ❌ (?)   | ❌       | ❌    | 1.8-3.6 | UART1,UART2          | AT6558R      | 32       | 5                        | 2.5       | 4.0525     |
| ATGM336H-5NR32       | ✅   | ✅   | ❌ (?)   | ❌       | ❌    | 1.8-3.6 | UART1,UART2          | AT6558R      | 32       | 5                        | 2.5       | 3.8498     |
| ATGM332D-5N11        | ✅   | ❌   | ❌       | ❌       | ❌    | 2.7-3.6 | UART1,UART2          | AT6558       | 32       | 10                       | 2.5       | 5.9460     |
| ATGM336H-5N11        | ✅   | ❌   | ❌       | ❌       | ❌    | 2.7-3.6 | UART1,UART2          | AT6558       | 32       | 10                       | 2.5       | 5.0609     |
| NEO-M9N (**u-blox**) | ✅   | ✅   | ✅       | ✅       | ✅    | 2.7-3.6 | UART,I2C,SPI,**USB** | UBX-M9140-KB | 24       | **25**                   | 2.0       | 45         |

These parameters seem to be the same for all ATGM modules:

| Key                          | Value    | Note                     |
| ---------------------------- | -------- | ------------------------ |
| Cold start sensitivity [dBm] | -148     |                          |
| Tracking sensitivity [dBm]   | -162     |                          |
| Protocols                    | NMEA0183 |                          |
| Assisted GNSS                | ✅        |                          |
| Battery and RTC              | ✅        |                          |
| Lockout speed [m/s]          | 515      | Not specified on AT6668? |
| Lockout altitude [m]         | 18000    | Not specified on AT6668? |
| Lockout acceleration [g]     | 4        | Not specified on AT6668? |

The main differences compared to the NEO-M9N are:

- Significantly lower cost
- Lower maximum output data rate of only 10 Hz
- Slightly higher lockout speed of 515 m/s
- Lower lockout altitude of 18000 m (compared to 80000 m)
- Lacks USB and lacks UBX or any binary output format

## AGNSS

The GNSS receivers support assisted GNSS. The datasheet refers to another file, "AGNSS solution of ZhongKe micro". I could only find these slides from an [unofficial source](https://espruino.microcosm.app/api/v1/files/b589417f21931e2a2182c6785b846ac64ef64b40.pdf).

The document contains the following code and the password and username of a free trial account which is rate-limited to 1000 requests per hour. The code works and the server is still online and will complain if you don't provide a username/password. I could not confirm that this account worked, either due to bots hitting the 1000 requests per hour rate limit or due to it being deactivated since the document was made.

```py
addr = "121.41.40.95"  # Server address
port = 2621  # port
message = b"user=freetrial;pwd=123456;cmd=full;lat=30;lon=120;"  # Request message
import socket

socket.setdefaulttimeout(4)
client = socket.socket()
client.connect((addr, port))
client.send(message)
reply_data = b""
while True:
    current_reply = client.recv(1024)
    if len(current_reply) == 0:
        break
    else:
        reply_data += current_reply

print(reply_data)

import serial
tty = serial.Serial()
tty.port = "COM1"
tty.baudrate = 9600
tty.open()
tty.write(reply_data)
tty.close()
```

The document seems to indicate the AGNSS service is supported by China Aerospace Science and Industry Corporation.
